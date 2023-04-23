FC=gfortran
LD=$(FC)
CPPFLAGS= -cpp -DUSE_DGEMM

# LDFLAGS= -lopenblas -lgomp
LDFLAGS= -llapack -lblas # lapack
LIBS= ../modules/libmodules.a
FFLAGS= -g -O3 -ffree-line-length-none #-heap-arrays

AR=ar

.PRECIOUS: %.o
