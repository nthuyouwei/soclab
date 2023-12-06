#include "matmul.h"

int* __attribute__ ( ( section ( ".mprjram" ) ) ) matmul()
{
	int i=0;
	int j;
	int k;
	int sum;
	int kk;
	unsigned int count = 0;
	for (i=0; i<SIZED; i++){
		for (j=0; j<SIZED; j++){
			sum = 0;
			for(k = 0;k<SIZED;k++)
				sum += C[(i*SIZED) + k] * B[(k*SIZED) + j];
			result[(i*SIZED) + j] = sum;
		}
	}
	return result;
}
