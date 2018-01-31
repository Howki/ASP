#include <stdio.h>
#include <malloc.h>
#include <math.h>
#include <stdlib.h>

static __inline__ unsigned long long rdtsc(void);
float*** allocMemMatrix();
void freeMemMatrix(float ***matrix);
void mullInternalMatrix(float *matrixA, float *matrixB, float *matrixC);
void mullExternalMatrix(float ***matrixA, float ***matrixB, float ***matrixC);
void fillMatrixRandElem(float ***matrix);

const int SIZE_EXT_MATRIX = 512;
const int SIZE_INT_MATRIX = 4;
const int MAX_RAND_DIV = 128;

int main(int argc, char **argv) {
  float ***matrixA = allocMemMatrix();
  float ***matrixB = allocMemMatrix();
  float ***matrixC = allocMemMatrix();

  fillMatrixRandElem(matrixA);
  fillMatrixRandElem(matrixB);

  unsigned long long timeElapsed = rdtsc();

  mullExternalMatrix(matrixA, matrixB, matrixC);

  /*printf("Elapsed time: %f (seconds).\n", (timeElapsed - rdtsc()) / pow(2, 21));*/

  freeMemMatrix(matrixA);
  freeMemMatrix(matrixB);
  freeMemMatrix(matrixC);

  return 0;
}

void mullExternalMatrix(float ***matrixA, float ***matrixB, float ***matrixC) {
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      for(int k = 0; k < SIZE_EXT_MATRIX; k++)
        mullInternalMatrix(matrixA[i][k], matrixB[k][j], matrixC[i][j]);
}

void mullInternalMatrix(float *matrixA, float *matrixB, float *matrixC) {
  for(int i = 0; i < SIZE_INT_MATRIX; i++)
    for(int j = 0; j < SIZE_INT_MATRIX; j++)
      for(int k = 0; k < SIZE_INT_MATRIX; k++)
        matrixC[i * SIZE_INT_MATRIX + j] += matrixA[i * SIZE_INT_MATRIX + k] * matrixB[k * SIZE_INT_MATRIX + j];
}

void fillMatrixRandElem(float ***matrix) {
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      for(int k = 0; k < SIZE_INT_MATRIX; k++)
        for(int l = 0; l < SIZE_INT_MATRIX; l++)
          matrix[i][j][k * SIZE_INT_MATRIX + l] = rand() / MAX_RAND_DIV + 1;
}

float*** allocMemMatrix() {
  float ***matrix = (float***)calloc(sizeof(float**), SIZE_EXT_MATRIX);

  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    matrix[i] = (float**)calloc(sizeof(float*), SIZE_EXT_MATRIX);

  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      matrix[i][j] = (float*)calloc(sizeof(float), SIZE_INT_MATRIX * SIZE_INT_MATRIX);

  return matrix;
}

void freeMemMatrix(float ***matrix) {
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      free(matrix[i][j]);

  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    free(matrix[i]);

  free(matrix);
}

static __inline__ unsigned long long rdtsc(void) {
  unsigned long long hi, lo;
  __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
  return (((unsigned long long)lo) | (((unsigned long long)hi) << 32));
}
