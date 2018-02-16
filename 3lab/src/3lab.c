#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <math.h>
#include <time.h>

static __inline__ unsigned long long rdtsc(void);
float* allocMemMatrix(int);
void freeMemMatrix(float *);

void printMatrix(float *, int);

const int MAX_ASSOC = 20;
const int MIN_ASSOC = 1;
const int NUMBER_ITER = 10000000;


int main(int argc, char **argv) {
  if(argc < 2) {
    printf("Incoreect arguments.\n");
    return 1;
  }

  double PROC_FREQ = pow(2, 31);
  long BLOCK_SIZE = atoi(argv[1]) / 4;
  long OFFSET = pow(2, 20);
  int BEGIN_TEST, END_TEST;
  int* massive = (int*)aligned_alloc(256, OFFSET * 20 * sizeof(int));

  for(long int n = MIN_ASSOC; n <= MAX_ASSOC; n++) {
    printf("%ld ", n);


    for(unsigned int i = 0; i < BLOCK_SIZE / n; i++)
      for(int j = 0; j < n; j++) {
        if(j == (n - 1))
          massive[i + j * OFFSET] = i + 1;
        else
          massive[i + j * OFFSET] = i + j * OFFSET + OFFSET;
        if((j == (n - 1)) && (i == ((BLOCK_SIZE / n) - 16)))
          massive[i + j * OFFSET] = 0;
      }

    int index = 0;

    BEGIN_TEST = rdtsc();

    for(int k = 0; k < NUMBER_ITER; k++)
      index = massive[index];

    END_TEST = rdtsc() - BEGIN_TEST;

    printf("%f\n", (float)(END_TEST / NUMBER_ITER));
  }

  free(massive);
  return 0;
}

static __inline__ unsigned long long rdtsc(void) {
  unsigned long long hi, lo;
  __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
  return (((unsigned long long)lo) | (((unsigned long long)hi) << 32));
}
