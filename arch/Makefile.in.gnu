FC=gfortran
CPPFLAGS= -cpp

LDFLAGS= -llapack -lblas # lapack
LIBS= ../modules/libmodules.a
FFLAGS= -g -O3

AR=ar

.PRECIOUS: %.o
