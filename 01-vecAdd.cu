/**
* Basic example; divides a n-element vector add operation two different ways:
* - 1 block, N threads per block
* - N blocks, 1 thread per block
*/

#include <iostream>
#include <cuda_runtime.h>

#define VEC_SIZE 102400
#define THREADS_PER_BLOCK 1024
#define VEC_BYTES (VEC_SIZE * sizeof(float))

__global__ void genIncVector(float *V) {
    int i = (blockIdx.x * THREADS_PER_BLOCK) + threadIdx.x;
    V[i] = i + 1;
}

__global__ void vecAdd(float* A, float* B, float* C) {
    int i = (blockIdx.x * THREADS_PER_BLOCK) + threadIdx.x;
    C[i] = A[i] + B[i];
}

int main() {
    float *a = (float *)malloc(VEC_BYTES);
    float *d_a, *d_b;

    // allocate memory on device
    cudaMalloc((void **) &d_a, VEC_BYTES);
    cudaMalloc((void **) &d_b, VEC_BYTES);

    genIncVector<<<VEC_SIZE/THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(d_a);
    genIncVector<<<VEC_SIZE/THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(d_b);

    // run vecAdd kernel with 8 threads, N_ITERATIONS times
    // Basic operation: A += B
    vecAdd<<<VEC_SIZE/THREADS_PER_BLOCK, THREADS_PER_BLOCK>>>(d_a, d_b, d_a);

    // copy result vectors from device memory back to host
    cudaMemcpy(a, d_a, VEC_BYTES, cudaMemcpyDeviceToHost);

    // print result C
    // std::cout << "A: ";
    // for (int i = 0; i < VEC_SIZE; i++) {
    //     std::cout << *(a+i) << " ";
    // }
    // std::cout << std::endl;

    // free device memory
    cudaFree(d_a); 
    cudaFree(d_b); 

    return 0;
}
