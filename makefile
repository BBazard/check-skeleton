CC=gcc
CFLAGS=-Wall
LIBS=-lcheck -lm -lpthread -lrt

# NO TARGET
all: bin/sum2ints

bin/sum2ints: main.o implementation.o
	$(CC) -o bin/sum2ints main.o implementation.o

main.o: src/main.c include/implementation.h
	$(CC) $(CFLAGS) -c src/main.c

implementation.o: src/implementation.c include/implementation.h
	$(CC) $(CFLAGS) -c src/implementation.c

# TESTS TARGET
test: bin/sum2ints-test
	bin/sum2ints-test

bin/sum2ints-test: implementation-test.o implementation.o
	$(CC) -o bin/sum2ints-test implementation.o implementation-test.o $(LIBS)

implementation-test.o: src/implementation-test.c include/implementation.h
	$(CC) $(CFLAGS) -c src/implementation-test.c

src/implementation-test.c: tests/implementation-test.check
	checkmk tests/implementation-test.check > src/implementation-test.c

# CLEAN TARGET
clean :
	rm -rf implementation.o implementation-test.o main.o
	rm -rf src/implementation-test.c
	rm -rf bin/sum2ints bin/sum2ints-test

