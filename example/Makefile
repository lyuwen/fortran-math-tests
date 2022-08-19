include ../Makefile.in

.PHONY: all test clean

all: lapack_examples_test

lapack_examples_test: lapack_examples_test.f
	$(FC) $(CPPFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

test: lapack_examples_test
	./$<

clean:
	rm -f lapack_examples_test
