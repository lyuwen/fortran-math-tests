include ../Makefile.in

.PHONY: all test clean

all: lapack_examples_test

lapack_examples_test: lapack_examples_test.o
	$(FC) -o $@ $^ $(LDFLAGS) $(LIBS)

%.o: %.f
	$(FC) $(CPPFLAGS) $(FFLAGS) -o $@ -c $^

test: lapack_examples_test
	./$<

clean:
	rm -vf lapack_examples_test lapack_examples_test.o
