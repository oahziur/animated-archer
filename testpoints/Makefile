CC=clang
CFLAGS= -Wall -O3

jssp_bf:	jssp_bf.o
	${CC} ${CFLAGS} -o jssp_bf jssp_bf.o

%.o:%.c
	${CC} ${CFLAGS} -c $<

clean:
	rm -f *.o *.a jssp_bf
