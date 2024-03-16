#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void matrix_vector_multiply(int *matrix, int *vector, int *result, int rows, int cols) {
    for (int i = 0; i < rows; i++) {
        result[i] = 0;
        for (int j = 0; j < cols; j++) {
            result[i] += matrix[i * cols + j] * vector[j];
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <matrix size>\n", argv[0]);
        return 1;
    }

    int size = atoi(argv[1]);

    int *matrix = (int *)malloc(size * size * sizeof(int));
    int *vector = (int *)malloc(size * sizeof(int));
    int *result = (int *)malloc(size * sizeof(int));

    srand(time(NULL));

    for (int i = 0; i < size * size; i++) {
        matrix[i] = rand() % 10;
    }

    for (int i = 0; i < size; i++) {
        vector[i] = rand() % 10;
    }

    // Measure execution time
    clock_t start_time = clock();

    matrix_vector_multiply(matrix, vector, result, size, size);

    // Calculate execution time
    clock_t end_time = clock();
    double execution_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;

    // Print test information
    printf("Test: 1, %s, %d, %.6f\n", argv[0], size, execution_time);

    free(matrix);
    free(vector);
    free(result);

    return 0;
}

