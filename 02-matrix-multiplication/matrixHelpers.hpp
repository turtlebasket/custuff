#ifndef MATRIXHELPERS
#define MATRIXHELPERS

#include <iostream>
#include <cstdlib>
#include <string>
#include "matrixHelpers.cpp"

float** gen_row_inc_matrix(uint rows, uint cols);
void print_matrix(float** m, size_t rows, size_t cols, std::string name);

#endif