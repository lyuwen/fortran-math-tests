include ../Makefile.in

SRC=$(wildcard *.f90)
OBJS=$(SRC:.f90=.o)

.PHONY: all clean

all: libmodules.a

libmodules.a: $(OBJS)
	$(AR) r $@ $^

$(OBJS): %.o : %.f90
	$(FC) $(CPPFLAGS) $(FFLAGS) -o $@ -c $^

clean:
	rm -vf libmodules.a $(OBJS)
