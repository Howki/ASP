#include <stdio.h>
#include <malloc.h>
#include <math.h>
#include <stdlib.h>
#include <xmmintrin.h>
#include <time.h>

static __inline__ unsigned long long rdtsc(void);
float*** allocMemMatrix();
void freeMemMatrix(float ***matrix);
void mullOptInternalMatrix(float *matrixA, float *matrixB, float *matrixC);
void mullInternalMatrix(float *matrixA, float *matrixB, float *matrixC);
void mullOptExternalMatrix(float ***matrixA, float ***matrixB, float ***matrixC);
void mullExternalMatrix(float ***matrixA, float ***matrixB, float ***matrixC);
void fillMatrixRandElem(float ***matrix);
void fillMatrixZeroElem(float ***matrixD);
int compareMatrix(float ***matrixA, float ***matrixB);
void printMatrix(float ***matrix);

const int SIZE_EXT_MATRIX = 512;
const int SIZE_INT_MATRIX = 4;
const int MAX_RAND_DIV = 128;

int main(int argc, char **argv) {
  float ***matrixA = allocMemMatrix();
  float ***matrixB = allocMemMatrix();
  float ***matrixC = allocMemMatrix();
  float ***matrixD = allocMemMatrix();

  fillMatrixRandElem(matrixA);
  fillMatrixRandElem(matrixB);
  fillMatrixZeroElem(matrixC);
  fillMatrixZeroElem(matrixD);

  unsigned long long timeElapsed = rdtsc();

  mullOptExternalMatrix(matrixA, matrixB, matrixC);
  
  printf("Elapsed time: %.5f (seconds).\n", (rdtsc() - timeElapsed) / pow(2, 31));

  mullExternalMatrix(matrixA, matrixB, matrixD);

  if(compareMatrix(matrixC, matrixD))
    printf("Equal.\n");
  else
    printf("Not Equal.\n");

  freeMemMatrix(matrixA);
  freeMemMatrix(matrixB);
  freeMemMatrix(matrixC);
  freeMemMatrix(matrixD);

  return 0;
}

void printMatrix(float ***matrix) {
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      for(int k = 0; k < SIZE_INT_MATRIX; k++)
        for(int l = 0; l < SIZE_INT_MATRIX; l++)
          printf("%.1f ", matrix[i][j][k * SIZE_INT_MATRIX +l]);
  printf("\n");
}

int compareMatrix(float ***matrixA, float ***matrixB) {
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      for(int k = 0; k < SIZE_INT_MATRIX; k++)
        for(int l = 0; l < SIZE_INT_MATRIX; l++)
          if(matrixA[i][j][k * SIZE_INT_MATRIX + l] != matrixB[i][j][k * SIZE_INT_MATRIX + l])
            return 0;

  return 1;
}

void fillMatrixZeroElem(float ***matrix) {
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      for(int k = 0; k < SIZE_INT_MATRIX; k++)
        for(int l = 0; l < SIZE_INT_MATRIX; l++)
          matrix[i][j][k * SIZE_INT_MATRIX + l] = 0;
}

void mullOptExternalMatrix(float ***matrixA, float ***matrixB, float ***matrixC) {
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      for(int k = 0; k < SIZE_EXT_MATRIX; k++)
        mullOptInternalMatrix(matrixA[i][k], matrixB[k][j], matrixC[i][j]);
}

void mullExternalMatrix(float ***matrixA, float ***matrixB, float ***matrixC) {
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      for(int k = 0; k < SIZE_EXT_MATRIX; k++)
        mullInternalMatrix(matrixA[i][k], matrixB[k][j], matrixC[i][j]);
}

void mullOptInternalMatrix(float *matrixA, float *matrixB, float *matrixC) {
  __m128 mm_a, mm_b, mm_c, res, buf;

  for(int i = 0; i < SIZE_INT_MATRIX; i++) {
    res = _mm_setzero_ps();
    buf = _mm_load_ps(&matrixC[i * SIZE_INT_MATRIX]);

    for(int k = 0; k < SIZE_INT_MATRIX; k++) {
      mm_a = _mm_set1_ps(matrixA[i * SIZE_INT_MATRIX + k]);
      mm_b = _mm_load_ps(&matrixB[k * SIZE_INT_MATRIX]);
      res = _mm_add_ps(res, _mm_mul_ps(mm_a, mm_b));
    }
    _mm_store_ps(&matrixC[i * SIZE_INT_MATRIX], _mm_add_ps(buf, res));
  }
}

void mullInternalMatrix(float *matrixA, float *matrixB, float *matrixC) {
  for(int i = 0; i < SIZE_INT_MATRIX; i++)
    for(int k = 0; k < SIZE_INT_MATRIX; k++)
      for(int j = 0; j < SIZE_INT_MATRIX; j++)
        matrixC[i * SIZE_INT_MATRIX + j] += matrixA[i * SIZE_INT_MATRIX + k] * matrixB[k * SIZE_INT_MATRIX + j];
}

void fillMatrixRandElem(float ***matrix) {
  srand(time(NULL));
  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      for(int k = 0; k < SIZE_INT_MATRIX; k++)
        for(int l = 0; l < SIZE_INT_MATRIX; l++)
          matrix[i][j][k * SIZE_INT_MATRIX + l] = rand() % MAX_RAND_DIV + 1;
}

float*** allocMemMatrix() {
  float ***matrix = (float***)calloc(sizeof(float**), SIZE_EXT_MATRIX);

  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    matrix[i] = (float**)calloc(sizeof(float*), SIZE_EXT_MATRIX);

  for(int i = 0; i < SIZE_EXT_MATRIX; i++)
    for(int j = 0; j < SIZE_EXT_MATRIX; j++)
      matrix[i][j] = (float*)aligned_alloc(128, sizeof(float) * SIZE_INT_MATRIX * SIZE_INT_MATRIX);

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
