#include <iostream>

#define VEC_SIZE 102400
#define N_ITERATIONS 1

float* gen_inc_vector(uint size) {
    float *vec = (float *)malloc(size*sizeof(float));
    for (uint i = 0; i < size; i++) {
        vec[i] = i + 1;
    }
    return vec;
}

void vecAdd(float *A, float *B, float *C) {
    for (size_t i = 0; i < VEC_SIZE; i++) {
        C[i] = A[i] + B[i];
    }
}

int main() {
    float *a = gen_inc_vector(VEC_SIZE);
    float *b = gen_inc_vector(VEC_SIZE);

    for (int i = 0; i < N_ITERATIONS; i++) {
        vecAdd(a, b, a);
    }

    // std::cout << "A: ";
    // for (int i = 0; i < VEC_SIZE; i++) {
    //     std::cout << *(a+i) << " ";
    // }
    // std::cout << std::endl;

    return 0;
}
