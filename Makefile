include Makefile.in

TARGETS=matinv example
MODULES=modules

.PHONY: all clean test $(TARGETS) $(MODULES)

all: $(TARGETS) $(MODULES)

clean:
	for i in $(TARGETS) $(MODULES); do $(MAKE) -C $$i clean; done

test:
	for i in $(TARGETS); do $(MAKE) -C $$i test; done && echo Tests Passed!!! || Tests Failed!!!

$(TARGETS): %: $(MODULES)

$(MODULES) $(TARGETS):
	$(MAKE) -C $@ all
