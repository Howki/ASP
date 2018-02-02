#include <stdio.h>
#include <malloc.h>
#include <math.h>
#include <xmmintrin.h>
#include <time.h>

static __inline__ unsigned long long rdtsc(void);

void mullOptMatrix(float *, float *, float *, int);
void mullBlocks(float *, float *, float *, int);

void mullMatrix(float *, float *, float *, int); // +

void fillMatrixRandElem(float *, int); // +

int compareMatrix(float *, float *, int); // +

float* allocMemMatrix(int); // +
void freeMemMatrix(float *); // +

void printMatrix(float *, int); // +

const int MAX_RAND_DIV = 128;

int main(int argc, char **argv) {

  int sizeMatrix;
  int sizeBlockL1;
  int sizeBlockL2;
  int sizeBlockL3;

  if(argc == 4) {
    sizeMatrix = sizeBlockL3 * 4;
    sizeBlockL1 = sizeBlockL1 * 0.8 / 3;
    sizeBlockL2 = sizeBlockL2 * 0.8 / 3;
    sizeBlockL3 = sizeBlockL3 * 0.8 / 3;
  } else {
    printf("Incorrect arguments!\n");
    return 1;
  }

  float *matrixA = allocMemMatrix(5);
  float *matrixB = allocMemMatrix(5);
  float *matrixC = allocMemMatrix(5);
  float *matrixD = allocMemMatrix(5);

  fillMatrixRandElem(matrixA, 5);
  fillMatrixRandElem(matrixB, 5);

  unsigned long long timeElapsed = rdtsc();

  mullMatrix(matrixA, matrixB, matrixD, 5);
  
  printf("Elapsed time (opt): %.5f (seconds).\n", (rdtsc() - timeElapsed) / pow(2, 31));

  /*if(compareMatrix(matrixC, matrixD))*/
    /*printf("Equal.\n");*/
  /*else*/
    /*printf("Not Equal.\n");*/

  freeMemMatrix(matrixA);
  freeMemMatrix(matrixB);
  freeMemMatrix(matrixC);
  freeMemMatrix(matrixD);

  return 0;
}

void printMatrix(float *matrix, int sizeMatrix) {
  for(int i = 0; i < sizeMatrix; i++)
    for(int j = 0; j < sizeMatrix; j++) {
      printf("%.1f ", matrix[i * sizeMatrix + j]);
      printf("\n");
    }
  printf("\n");
}

int compareMatrix(float *matrixA, float *matrixB, int sizeMatrix) {
  for(int i = 0; i < sizeMatrix; i++)
    for(int j = 0; j < sizeMatrix; j++) {
      if(matrixA[i * sizeMatrix + j] != matrixB[i * sizeMatrix + j]);
      return 0;
    }

  return 1;
}

void mullOptMatrix(float *matrixA, float *matrixB, float *matrixC, int sizeMatrix) {
  for(int i = 0; i < sizeMatrix; i++)
    for(int j = 0; j < sizeMatrix; j++)
      for(int k = 0; k < sizeMatrix; k++)
        mullBlocks(&matrixA[i], matrixB, matrixC, 5);
}

void mullBlocks(float *matrixA, float *matrixB, float *matrixC, int sizeBlock) {
  for(int i = 0; i < sizeBlock; i++)
    for(int k = 0; k < sizeBlock; k++)
      for(int j = 0; j < sizeBlock; j++)
        matrixC[i * sizeBlock + j] += matrixA[i * sizeBlock + k] * matrixB[k * sizeBlock + j];
}

void mullMatrix(float *matrixA, float *matrixB, float *matrixC, int sizeMatrix) {
  for(int i = 0; i < sizeMatrix; i++)
    for(int j = 0; j < sizeMatrix; j++)
      for(int k = 0; k < sizeMatrix; k++)
        matrixC[i * sizeMatrix + j] += matrixA[i * sizeMatrix + k] * matrixB[k * sizeMatrix + j];
}

void fillMatrixRandElem(float *matrix, int sizeMatrix) {
  srand(time(NULL));
  for(int i = 0; i < sizeMatrix; i++)
    for(int j = 0; j < sizeMatrix; j++)
      matrix[i * sizeMatrix + j] = rand() % MAX_RAND_DIV + 1;
}

float* allocMemMatrix(int sizeMatrix) {
  float *matrix = (float*)calloc(sizeof(float), sizeMatrix * sizeMatrix);
  return matrix;
}

void freeMemMatrix(float *matrix) {
  free(matrix);
}

static __inline__ unsigned long long rdtsc(void) {
  unsigned long long hi, lo;
  __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
  return (((unsigned long long)lo) | (((unsigned long long)hi) << 32));
}
