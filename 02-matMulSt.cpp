/**
 * @brief Generate matrix increasing by rows
 * 
 * @param rows number of rows
 * @param cols number of columns
 * @return float** reference to matrix
 */
float** gen_row_inc_matrix(uint rows, uint cols) {
    float **mat = (float **)malloc(rows * sizeof(float*));
    float ctr = 1.;
    size_t row_bytes = cols * sizeof(float);
    for (int r = 0; r < rows; r++) {
        float* row = (float *)malloc(row_bytes);
        for (int c = 0; c < rows; c++) {
            row[c] = ctr;
            ctr += 1.;
        }
        mat[r] = row;
    }
    return mat;
}

/**
 * @brief Print out matrix.
 * 
 * @param m reference to matrix
 * @param rows Number of rows
 * @param cols Number of columns
 * @param name Name of matrix (in title)
 */
void print_matrix(float** m, size_t rows, size_t cols, std::string name) {
    std::cout << "==== MATRIX: " << name << " ====\n";
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            std::cout << m[r][c] << "\t";
        }
        std::cout << "\n";
    }
}

int main() {

}