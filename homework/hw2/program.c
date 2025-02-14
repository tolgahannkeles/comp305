#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 51801 // Matrix size is N x N -> 051801
#define UPPER_BOUND 100

void generate_matrix(int **matrix, const char *filename) {
    // Opening file in write mode
    FILE *file = fopen(filename, "w");
    if (!file) {
        perror("File could not be opened");
        exit(1);
    }

    // Generating random numbers and writing to file
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            matrix[i][j] = rand() % UPPER_BOUND;
            fprintf(file, "%d ", matrix[i][j]);
        }
        fprintf(file, "\n");
    }

    // Closing file
    fclose(file);
}

void read_matrix(int **matrix, const char *filename) {
    // Opening file in read mode
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("File could not be opened");
        exit(1);
    }

    // Reading matrix from file
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            fscanf(file, "%d", &matrix[i][j]);
        }
    }

    // Closing file
    fclose(file);
}

// Matrix multiplication
void multiply_matrices(int **A, int **B, int **mul) {
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            mul[i][j] = 0;
            for (int k = 0; k < N; ++k) {
                mul[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

int main() {
    // Initialize random number generator seed
    srand(time(NULL));

    // Memory allocation for matrices
    int **A = (int **)malloc(N * sizeof(int *));
    int **B = (int **)malloc(N * sizeof(int *));
    int **mul = (int **)malloc(N * sizeof(int *));

    // Check if memory allocation is successful
    if (!A || !B || !mul) {
        perror("Bellek ayırma hatası");
        exit(1);
    }

    // Allocate memory for each row
    for (int i = 0; i < N; ++i) {
        A[i] = (int *)malloc(N * sizeof(int));
        B[i] = (int *)malloc(N * sizeof(int));
        mul[i] = (int *)malloc(N * sizeof(int));
        if (!A[i] || !B[i] || !mul[i]) {
            perror("Bellek ayırma hatası");
            exit(1);
        }
    }

    // Creating matrices
    generate_matrix(A, "matrix_a.txt");
    generate_matrix(B, "matrix_b.txt");

    // Reading matrices from files
    read_matrix(A, "matrix_a.txt");
    read_matrix(B, "matrix_b.txt");

    // Multiply matrices
    multiply_matrices(A, B, mul);

    // Writing result to file
    FILE *result = fopen("result.txt", "w");
    if (!result) {
        perror("Result file could not be opened");
        exit(1);
    }

    // Writing result to file
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            fprintf(result, "%d ", mul[i][j]);
        }
        fprintf(result, "\n");
    }

    fclose(result);

    // Free memory
    for (int i = 0; i < N; ++i) {
        free(A[i]);
        free(B[i]);
        free(mul[i]);
    }
    free(A);
    free(B);
    free(mul);

    printf("Matrix multiplication is done successfully and the result is written to result.txt\n");
    return 0;
}
