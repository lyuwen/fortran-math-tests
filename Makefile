include Makefile.in

TARGETS=matinv example
MODULES=modules

.PHONY: all clean $(TARGETS) $(MODULES)

all: $(TARGETS) $(MODULES)

clean:
	for i in $(TARGETS) $(MODULES); do $(MAKE) -C $$i clean; done

$(TARGETS): %: $(MODULES)

$(MODULES) $(TARGETS):
	$(MAKE) -C $@ all
