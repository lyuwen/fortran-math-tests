include ../Makefile.in

BASE=zgetrs

.PHONY: all test test-$(BASE)

all: $(BASE)-10 $(BASE)-100 $(BASE)-1000

test: test-$(BASE)

$(BASE)-%: run_$(BASE)_%.o $(BASE).o
	$(LD) $(FFLAGS) -o $@ $^ $(LIBS) $(LDFLAGS)

run_$(BASE)_%.o: run_$(BASE).f90
	$(FC) $(CPPFLAGS) -DARRSIZE=$*  $(FFLAGS) -o $@ -c $^

%.o: %.f90
	$(FC) $(CPPFLAGS) $(FFLAGS) -o $@ -c $^

test-$(BASE): $(BASE)-10 $(BASE)-100 $(BASE)-1000
	@echo Run $(BASE)-10
	./$(BASE)-10
	@echo Run $(BASE)-100
	./$(BASE)-100
	@echo Run $(BASE)-1000
	./$(BASE)-1000

clean:
	rm -vf $(BASE)-10 $(BASE)-100 $(BASE)-1000 $(BASE).o run_$(BASE)_*.o
