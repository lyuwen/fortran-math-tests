include Makefile.in

TARGETS=matinv example cmateig
MODULES=modules

.PHONY: all clean test $(TARGETS) $(MODULES)

all: $(TARGETS) $(MODULES) run_tests

clean:
	for i in $(TARGETS) $(MODULES); do $(MAKE) -C $$i clean; done

test:
	for i in $(TARGETS); do $(MAKE) -C $$i test; done && echo Tests Passed!!! || Tests Failed!!!

OBJS = matinv/matinv.o cmateig/cmateig.o
LIBS = modules/libmodules.a

run_tests: run_tests.f90 $(OBJS) $(LIBS)
	$(FC) $(CPPFLAGS) $(FFLAGS) -o $@ $^ $(LDFLAGS)

$(LIBS): $(MODULES)

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $^

$(TARGETS): %: $(MODULES)

$(MODULES) $(TARGETS):
	$(MAKE) -C $@ all
