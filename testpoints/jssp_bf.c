#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <inttypes.h>

#define TASK 20
#define MACHINE 4

int s[TASK];
int d[TASK] = {32,96,4,32,97,29,35,97,6,74,77,78,33,4,92,69,64,51,58,91};
int m[MACHINE];
int bests[TASK];
int best = INT_MAX;
uint64_t trial = 0;

int finds(int tid)
{
	int i;
	if (tid == TASK)
	{
		int max = 0;
		for (i = 0; i < MACHINE; i++)
		{
			if (m[i] > max)
				max = m[i];
		}
		if (max < best)
		{
			best = max;
			memcpy(bests, s, sizeof(s));
		}
		if((trial++ % 100000000) == 0)
			printf("trial: %" PRIu64 "00M, best:%d\n", trial/100000000, best);
		return 0;
	}
	for (i = 0; i < MACHINE; i++)
	{
		m[i] += d[tid];
		s[tid] = i;
		finds(tid + 1);
		m[i] -= d[tid];
	}
	return 0;
}

int main(int argc, char * argv[])
{
	int i;
	for (i = 0; i < MACHINE; i++)
	{
		m[i] = 0;
	}
	finds(0);
	printf("best solution: %d \n", best);
	for (i = 0; i < TASK; i++)
	{
		printf("%d, ", bests[i]);
	}
	printf("\n");
	return 0;
}
