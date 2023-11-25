#include <iostream>
#include <cuda_runtime.h>

__global__ void matmul(float** A, float** B, float** C) {
    int bix = blockIdx.x;
    int tix = threadIdx.x;
}

void print_matrix(float** m, size_t rows, size_t cols, char* name) {
    std::cout << "==== MATRIX: " << name << " ====\n";
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            std::cout << m[r][c] << "\t";
        }
        std::cout << "\n"
    }
}

int main() {

    return 0;
}
