program main
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER,PARAMETER :: array_sizes(3) = (/10,100,1000/)
  REAL :: totaltime, singletime
#ifdef LOOP
  INTEGER,PARAMETER :: loop = LOOP
#else
  INTEGER,PARAMETER :: loop = 10
#endif
  INTEGER :: i, j


  print *, "Testing matinv:"
  DO i = 1, size(array_sizes)
    totaltime = 0
    DO j = 1, loop
      singletime = 0
      call matinv(array_sizes(i), singletime, 1)
      totaltime = totaltime + singletime
    END DO
    print *, "array_size = ", array_sizes(i), " , average time over ", loop, " loops: ", totaltime / loop
  END DO

  print *, "Testing cmateig:"
  DO i = 1, size(array_sizes)
    totaltime = 0
    DO j = 1, loop
      singletime = 0
      call cmateig(array_sizes(i), singletime, 1)
      totaltime = totaltime + singletime
    END DO
    print *, "array_size = ", array_sizes(i), " , average time over ", loop, " loops: ", totaltime / loop
  END DO

  print *, "Testing dmatmul:"
  DO i = 1, size(array_sizes)
    totaltime = 0
    DO j = 1, loop
      singletime = 0
      call dmatmul(array_sizes(i), singletime, 1)
      totaltime = totaltime + singletime
    END DO
    print *, "array_size = ", array_sizes(i), " , average time over ", loop, " loops: ", totaltime / loop
  END DO

end program main
