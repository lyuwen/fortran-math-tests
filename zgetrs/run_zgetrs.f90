program main
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
#ifdef ARRSIZE
  INTEGER,PARAMETER :: array_size = ARRSIZE
#else
  INTEGER,PARAMETER :: array_size = 1000
#endif
  REAL :: elapsed

  call test_zgetrs(array_size, elapsed, 0)

end program main
