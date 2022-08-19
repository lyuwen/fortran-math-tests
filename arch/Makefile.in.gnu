FC=gfortran
LD=$(FC)
CPPFLAGS= -cpp

LDFLAGS= -llapack -lblas # lapack
LIBS= ../modules/libmodules.a
FFLAGS= -g -O3 #-heap-arrays

AR=ar

.PRECIOUS: %.o
