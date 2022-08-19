include Makefile.in

TARGETS=matinv example cmateig
MODULES=modules

.PHONY: all clean test test-all $(TARGETS) $(MODULES)

all: $(TARGETS) $(MODULES) run_tests

clean:
	for i in $(TARGETS) $(MODULES); do $(MAKE) -C $$i clean; done
	rm -vf run_tests run_tests.o

test-all: test
	for i in $(TARGETS); do $(MAKE) -C $$i test; done && echo Tests Passed!!! || Tests Failed!!!

test: run_tests
	./$<

OBJS = matinv/matinv.o cmateig/cmateig.o
LIBS = modules/libmodules.a

run_tests: run_tests.o $(OBJS) $(LIBS)
	$(LD) $(FFLAGS) -o $@ $^ $(LDFLAGS)

$(LIBS): $(MODULES)

%.o: %.f90
	$(FC) $(CPPFLAGS) $(FFLAGS) -o $@ -c $^

$(TARGETS): %: $(MODULES)

$(MODULES) $(TARGETS):
	$(MAKE) -C $@ all
