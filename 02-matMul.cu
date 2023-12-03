#include <cuda_runtime.h>
#include "matrixHelpers.hpp"

#define ROWS_A 9
#define COLS_A 7
#define N_THREADS (ROWS_A * ROWS_A)

__global__ void genIncMatrix(float* mat) {

}

__global__ void matmul(float* A, float* B, float* C) {
    int bix = blockIdx.x;
    int tix = threadIdx.x;

    // __shared__ float tile_A[]
    // __syncthreads();
}

int main() {
    float** A = gen_row_inc_matrix(ROWS_A, COLS_A);
    float** B = gen_row_inc_matrix(COLS_A, ROWS_A);
    float** C;
    float** d_A, d_B, d_C;
    size_t matrix_bytes = ROWS_A * sizeof(float*);

    print_matrix(A, ROWS_A, COLS_A, "A");
    print_matrix(B, COLS_A, ROWS_A, "B");

    cudaMalloc((void **) d_A, matrix_bytes);
    cudaMalloc((void **) d_B, matrix_bytes);

    cudaMemcpyAsync(d_A, A, cudaMemcpyHostToDevice);
    cudaMemcpyAsync(d_B, B, cudaMemcpyHostToDevice);
    cudaDeviceSynchronize();

    cudaFree(d_A);
    cudaFree(d_B);

    return 0;
}
