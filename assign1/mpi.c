#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>

void matrix_vector_multiply(int *matrix, int *vector, int *result, int rows, int cols) {
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Calculate portion of matrix rows for each process
    int chunk_size = rows / size;
    int remainder = rows % size;
    int start_row = rank * chunk_size;
    int end_row = (rank == size - 1) ? start_row + chunk_size + remainder : start_row + chunk_size;

    // Perform matrix-vector multiplication
    for (int i = start_row; i < end_row; i++) {
        result[i] = 0;
        for (int j = 0; j < cols; j++) {
            result[i] += matrix[i * cols + j] * vector[j];
        }
    }

    // Gather results from all processes
    MPI_Allgather(MPI_IN_PLACE, 0, MPI_DATATYPE_NULL, result, chunk_size, MPI_INT, MPI_COMM_WORLD);
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

    // Initialize MPI
    MPI_Init(&argc, &argv);

    // Measure execution time
    double start_time = MPI_Wtime();

    matrix_vector_multiply(matrix, vector, result, size, size);

    // Calculate execution time
    double end_time = MPI_Wtime();
    double execution_time = end_time - start_time;

    // Print test information
    printf("Test: 1, %s, %d, %.6f\n", argv[0], size, execution_time);

    // Finalize MPI
    MPI_Finalize();

    free(matrix);
    free(vector);
    free(result);

    return 0;
}

