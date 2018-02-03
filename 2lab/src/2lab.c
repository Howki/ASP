#include <stdio.h>
#include <malloc.h>
#include <math.h>
#include <xmmintrin.h>
#include <time.h>
#include <omp.h>

static __inline__ unsigned long long rdtsc(void);

void mullOptMatrix(float *, float *, float *, int, int);
void mullBlocks(float *, float *, float *, int, int, int, int);

void mullMatrix(float *, float *, float *, int);

void fillMatrixRandElem(float *, int);
void fillMatrixZeroElem(float *, int);

int compareMatrix(float *, float *, int);

float* allocMemMatrix(int);
void freeMemMatrix(float *);

void printMatrix(float *, int);

const int MAX_RAND_DIV = 128;
const int N_THREADS = 4;

int main(int argc, char **argv) {

  if(argc != 5) {
    printf("Incorrect arguments!\n");
    return 1;
  }

  int sizeMatrix = atoi(argv[4]);
  int sizeCacheL1 = atoi(argv[1]);
  int sizeCacheL2 = atoi(argv[2]);
  int sizeCacheL3 = atoi(argv[3]);

  printf("\nL1 size - %d (bytes)\n", sizeCacheL1);
  printf("L2 size - %d (bytes)\n", sizeCacheL2);
  printf("L3 size - %d (bytes)\n\n", sizeCacheL3);

  int sizeBlockL1 = (int)(sqrt(sizeCacheL1) * 0.8 / 3) & 0xFFFFFFF0;
  int sizeBlockL2 = (int)(sqrt(sizeCacheL2) * 0.8 / 3) & 0xFFFFFFF0;
  int sizeBlockL3 = (int)(sqrt(sizeCacheL3) * 0.8 / 3) & 0xFFFFFFF0;

  printf("L1 cache block size: %d\n", sizeBlockL1);
  printf("L2 cache block size: %d\n", sizeBlockL2);
  printf("L3 cache block size: %d\n", sizeBlockL3);

  float *matrixA = allocMemMatrix(sizeMatrix);
  float *matrixB = allocMemMatrix(sizeMatrix);
  float *matrixC = allocMemMatrix(sizeMatrix);
  float *matrixD = allocMemMatrix(sizeMatrix);

  fillMatrixRandElem(matrixA, sizeMatrix);
  fillMatrixRandElem(matrixB, sizeMatrix);

  /*L3*/
  printf("\nL3:\n");
  unsigned long long timeElapsed = rdtsc();

  mullOptMatrix(matrixA, matrixB, matrixC, sizeMatrix, sizeBlockL3);
  
  printf("Elapsed time (L3): %.5f (seconds).\n", (rdtsc() - timeElapsed) / pow(2, 31));
  
  /*L2*/
  printf("\nL2:\n");
  fillMatrixZeroElem(matrixC, sizeMatrix);
  timeElapsed = rdtsc();

  mullOptMatrix(matrixA, matrixB, matrixC, sizeMatrix, sizeBlockL2);
  
  printf("Elapsed time (L2): %.5f (seconds).\n", (rdtsc() - timeElapsed) / pow(2, 31));

  
  /*L1*/
  printf("\nL1:\n");
  fillMatrixZeroElem(matrixC, sizeMatrix);
  timeElapsed = rdtsc();

  mullOptMatrix(matrixA, matrixB, matrixC, sizeMatrix, sizeBlockL1);
  
  printf("Elapsed time (L1): %.5f (seconds).\n", (rdtsc() - timeElapsed) / pow(2, 31));

  /*Without cache opt*/
  printf("\nWithout cache opt:\n");
  timeElapsed = rdtsc();

  mullMatrix(matrixA, matrixB, matrixD, sizeMatrix);

  printf("Elapsed time (no opt): %.5f (seconds).\n", (rdtsc() - timeElapsed) / pow(2, 31));

  if(compareMatrix(matrixC, matrixD, sizeMatrix))
    printf("\nEqual.\n");
  else
    printf("\nNot Equal.\n");

  freeMemMatrix(matrixA);
  freeMemMatrix(matrixB);
  freeMemMatrix(matrixC);
  freeMemMatrix(matrixD);

  return 0;
}

void printMatrix(float *matrix, int sizeMatrix) {
  for(int i = 0; i < sizeMatrix; i++) {
    for(int j = 0; j < sizeMatrix; j++) {
      printf("%.1f ", matrix[i * sizeMatrix + j]);
    }
    printf("\n");
  }
  printf("\n");
}

int compareMatrix(float *matrixA, float *matrixB, int sizeMatrix) {
  for(int i = 0; i < sizeMatrix; i++)
    for(int j = 0; j < sizeMatrix; j++) {
      if(matrixA[i * sizeMatrix + j] != matrixB[i * sizeMatrix + j])
        return 0;
    }

  return 1;
}

void mullOptMatrix(float *matrixA, float *matrixB, float *matrixC, int sizeMatrix, int sizeBlock) {
  int numberOfBlocks = ceil((float)sizeMatrix / sizeBlock);

  printf("Number of blocks: %d\n", (int)pow(numberOfBlocks, 2));
  
  #pragma omp parallel num_threads(N_THREADS)
  {
    for(int i = 0, sizeIBlock = sizeBlock; i < numberOfBlocks; i++) {
      if(i == numberOfBlocks - 1)
        sizeIBlock = sizeMatrix - sizeBlock * i;
      for(int j = 0, sizeJBlock = sizeBlock; j < numberOfBlocks; j++) {
        if(j == numberOfBlocks - 1)
          sizeJBlock = sizeMatrix - sizeBlock * j;
        for(int k = 0, sizeKBlock = sizeBlock; k < numberOfBlocks; k++) {
          if(k == numberOfBlocks - 1)
            sizeKBlock = sizeMatrix - sizeBlock * k;
          mullBlocks(&matrixA[i * sizeMatrix * sizeBlock + k * sizeBlock], &matrixB[k * sizeMatrix * sizeBlock + j * sizeBlock], &matrixC[i * sizeMatrix * sizeBlock + j * sizeBlock], sizeMatrix, sizeIBlock, sizeJBlock, sizeKBlock);
        }
      }
    }
  }
}

void mullBlocks(float *matrixA, float *matrixB, float *matrixC, int sizeMatrix, int sizeIBlock, int sizeJBlock, int sizeKBlock) {
  for(int i = 0; i < sizeIBlock; i++)
    for(int k = 0; k < sizeKBlock; k++)
      for(int j = 0; j < sizeJBlock; j++)
        *(matrixC + i * sizeMatrix + j) += *(matrixA + i * sizeMatrix + k) * *(matrixB + k * sizeMatrix + j);
}

void mullMatrix(float *matrixA, float *matrixB, float *matrixC, int sizeMatrix) {
  #pragma omp parallel num_threads(N_THREADS)
  {
    for(int i = 0; i < sizeMatrix; i++)
      for(int k = 0; k < sizeMatrix; k++)
        for(int j = 0; j < sizeMatrix; j++)
          matrixC[i * sizeMatrix + j] += matrixA[i * sizeMatrix + k] * matrixB[k * sizeMatrix + j];
  }
}

void fillMatrixRandElem(float *matrix, int sizeMatrix) {
  srand(time(NULL));
  for(int i = 0; i < sizeMatrix; i++)
    for(int j = 0; j < sizeMatrix; j++)
      matrix[i * sizeMatrix + j] = rand() % MAX_RAND_DIV + 1;
}

void fillMatrixZeroElem(float *matrix, int sizeMatrix) {
  srand(time(NULL));
  for(int i = 0; i < sizeMatrix; i++)
    for(int j = 0; j < sizeMatrix; j++)
      matrix[i * sizeMatrix + j] = 0;
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
