FC=gfortran
CPPFLAGS= -cpp

LDFLAGS= -llapack -lblas # lapack
LDFLAGS+= ../modules/libmodules.a
FFLAGS= -g -O3

AR=ar
