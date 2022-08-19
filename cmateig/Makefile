include ../Makefile.in

BASE=cmateig

.PHONY: all test test-$(BASE)

all: $(BASE)-10 $(BASE)-100 $(BASE)-1000

test: test-$(BASE)

$(BASE)-%: run_$(BASE).f90 $(BASE).o
	$(FC) $(CPPFLAGS) -DARRSIZE=$* $(FFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $^

test-$(BASE): $(BASE)-10 $(BASE)-100 $(BASE)-1000
	@echo Run $(BASE)-10
	./$(BASE)-10
	@echo Run $(BASE)-100
	./$(BASE)-100
	@echo Run $(BASE)-1000
	./$(BASE)-1000

clean:
	rm -vf $(BASE)-10 $(BASE)-100 $(BASE)-1000 $(BASE).o
