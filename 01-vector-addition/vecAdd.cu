/**
* Basic example; divides a n-element vector add operation two different ways:
* - 1 block, N threads per block
* - N blocks, 1 thread per block
*/

#include <iostream>
#include <cuda_runtime.h>

#define VEC_SIZE 8

/**
 * @brief Vector addition using 1 block and N threads per block
 * 
 * @param A Input Vector pointer 1
 * @param B Input Vector pointer 2
 * @param C Result Vector pointer
 */
__global__ void vecAdd_A(float* A, float* B, float* C)
{
    int i = threadIdx.x;
    C[i] = A[i] + B[i];
}

/**
 * @brief Vector addition using N block and 1 thread per block
 * 
 * @param A Input Vector pointer 1
 * @param B Input Vector pointer 2
 * @param C Result Vector pointer
 */
__global__ void vecAdd_B(float* A, float* B, float* C)
{
    int i = blockIdx.x;
    C[i] = A[i] + B[i];
}

int main() {
    float a[VEC_SIZE] = {1., 2., 3., 4., 5., 6., 7., 8.};
    float b[VEC_SIZE] = {8., 7., 28., 1., 6., 2., 3., 5.};
    size_t vec_bytes = VEC_SIZE * sizeof(float);
    float *c = (float *)malloc(vec_bytes);
    float *d = (float *)malloc(vec_bytes);
    float *d_a, *d_b, *d_c, *d_d;

    // allocate memory on device
    cudaMalloc((void **) &d_a, vec_bytes);
    cudaMalloc((void **) &d_b, vec_bytes);
    cudaMalloc((void **) &d_c, vec_bytes);
    cudaMalloc((void **) &d_d, vec_bytes);

    // copy input vectors from host memory to device
    cudaMemcpy(d_a, &a, vec_bytes, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, vec_bytes, cudaMemcpyHostToDevice);

    // run vecAdd kernel with 8 threads
    vecAdd_A<<<1, VEC_SIZE>>>(d_a, d_b, d_c);
    vecAdd_B<<<VEC_SIZE, 1>>>(d_a, d_b, d_d);

    // copy result vectors from device memory back to host
    cudaMemcpy(c, d_c, vec_bytes, cudaMemcpyDeviceToHost);
    cudaMemcpy(d, d_d, vec_bytes, cudaMemcpyDeviceToHost);

    // print result C
    std::cout << "C: ";
    for (int i = 0; i < VEC_SIZE; i++) {
        std::cout << *(c+i) << " ";
    }
    std::cout << std::endl;

    // print result D
    std::cout << "D: ";
    for (int i = 0; i < VEC_SIZE; i++) {
        std::cout << *(d+i) << " ";
    }
    std::cout << std::endl;

    // free device memory
    cudaFree(d_a); 
    cudaFree(d_b); 
    cudaFree(d_c);
    cudaFree(d_d);

    return 0;
}
