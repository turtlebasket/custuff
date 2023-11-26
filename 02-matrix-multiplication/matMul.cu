#include "matrixHelpers.hpp"
#include <cuda_runtime.h>

#define ROWS_A 9
#define COLS_A 7
#define N_THREADS (ROWS_A * ROWS_A)

__global__ void matmul(float** A, float** B, float** C) {
    int bix = blockIdx.x;
    int tix = threadIdx.x;

    // __shared__ float tile_A[]
    // __syncthreads();
}

int main() {
    float** A = gen_row_inc_matrix(ROWS_A, COLS_A);
    float** B = gen_row_inc_matrix(COLS_A, ROWS_A);
    float** C;
    print_matrix(A, ROWS_A, COLS_A, "A");
    print_matrix(B, COLS_A, ROWS_A, "B");

    // cudaMemcpyAsync()

    return 0;
}
