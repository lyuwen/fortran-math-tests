program main
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
#ifdef ARRSIZE
  INTEGER,PARAMETER :: array_size = ARRSIZE
#else
  INTEGER,PARAMETER :: array_size = 1000
#endif
  COMPLEX(dp), ALLOCATABLE :: array(:, :)
  REAL(dp), ALLOCATABLE :: temp(:, :)
  REAL elapsed, start, finish
  INTEGER :: LDA, LWORK, INFO, LRWORK, LIWORK
  INTEGER, ALLOCATABLE :: IWORK(:)
  COMPLEX(dp), ALLOCATABLE :: WORK(:)
  REAL(dp), ALLOCATABLE :: W(:), RWORK(:)
  !
  call now(start)
  print *, "array size: ", array_size
  allocate(array(array_size, array_size))
  allocate(W(array_size))

  seed = 0
  call random_seed(seed)
  allocate(temp(array_size, array_size))
  call random_number(temp)
  array(:, :) = 0
  array = array + temp * CMPLX(1.0, 0.0)
  call random_number(temp)
  array = array + temp * CMPLX(0.0, 1.0)
  array = (array + CONJG(TRANSPOSE(array))) * 50d0
  print *, "first element: ", array(1, 1)
  print *, "(1, 2) element: ", array(1, 2)

  ! Get optimal worker array size
  LWORK = -1
  LIWORK = -1
  LRWORK = -1
  allocate(WORK(1))
  allocate(IWORK(1))
  allocate(RWORK(1))
  CALL ZHEEVD( 'Vectors', 'Lower', array_size, array, array_size, W, WORK, LWORK, RWORK, LRWORK, IWORK, LIWORK, INFO )
  LWORK  = INT(WORK(1))
  LIWORK = INT(IWORK(1))
  LRWORK = INT(RWORK(1))
  deallocate(WORK)
  deallocate(IWORK)
  deallocate(RWORK)

  print *, "Optimal worker array size: ", "LWORK = ", LWORK, ", LIWORK = ", LIWORK, ", LRWORK = ", LRWORK

  allocate(WORK(LWORK))
  allocate(IWORK(LIWORK))
  allocate(RWORK(LRWORK))
  CALL ZHEEVD( 'Vectors', 'Lower', array_size, array, array_size, W, WORK, LWORK, RWORK, LRWORK, IWORK, LIWORK, INFO )
  deallocate(WORK)
  deallocate(IWORK)
  deallocate(RWORK)
  
  call now(finish)
  elapsed = finish - start
  print *, "Elapsed time: ", elapsed, "seconds."
  deallocate(array)
  deallocate(W)
end program main
