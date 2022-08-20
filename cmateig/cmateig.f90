subroutine cmateig(array_size, elapsed, iquiet)
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: array_size
  REAL,INTENT(OUT) :: elapsed
  INTEGER,OPTIONAL :: iquiet
  INTEGER :: quiet
  COMPLEX(dp), ALLOCATABLE :: array(:, :)
  REAL :: start, finish
  INTEGER :: LDA, LWORK, INFO, LRWORK, LIWORK
  INTEGER, ALLOCATABLE :: IWORK(:)
  COMPLEX(dp), ALLOCATABLE :: WORK(:)
  REAL(dp), ALLOCATABLE :: W(:), RWORK(:)
  !
  if(present(iquiet))then
    quiet = iquiet
  else
    quiet = 0
  endif
  !
  call now(start)
  if (quiet == 0) then
    print *, "array size: ", array_size
  end if
  allocate(array(array_size, array_size))
  allocate(W(array_size))

  call get_random_complex_hermitian_array(array_size, array)
  if (quiet == 0) then
    print *, "first element: ", array(1, 1)
    print *, "(1, 2) element: ", array(1, 2)
  end if

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

  if (quiet == 0) then
    print *, "Optimal worker array size: ", "LWORK = ", LWORK, ", LIWORK = ", LIWORK, ", LRWORK = ", LRWORK
  end if

  allocate(WORK(LWORK))
  allocate(IWORK(LIWORK))
  allocate(RWORK(LRWORK))
  CALL ZHEEVD( 'Vectors', 'Lower', array_size, array, array_size, W, WORK, LWORK, RWORK, LRWORK, IWORK, LIWORK, INFO )
  deallocate(WORK)
  deallocate(IWORK)
  deallocate(RWORK)

  call now(finish)
  elapsed = finish - start
  if (quiet == 0) then
    call report_elapsed(elapsed)
  end if
  deallocate(array)
  deallocate(W)
end subroutine cmateig
