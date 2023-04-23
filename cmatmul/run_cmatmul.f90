program main
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
#ifdef ARRSIZE
  INTEGER,PARAMETER :: array_size = ARRSIZE
#else
  INTEGER,PARAMETER :: array_size = 1000
#endif
#ifdef GRIDSIZE
  INTEGER,PARAMETER :: grid_size = GRIDSIZE
#else
  INTEGER,PARAMETER :: grid_size = 10
#endif
  REAL :: elapsed

  call cmatmul(array_size, elapsed, 0)

  call arrcmatmul(grid_size, array_size, elapsed, 0)

end program main
