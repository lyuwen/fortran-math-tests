subroutine cmatinv(array_size, elapsed, iquiet)
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: array_size
  REAL,INTENT(OUT) :: elapsed
  INTEGER,OPTIONAL :: iquiet
  INTEGER :: quiet
  COMPLEX(dp), ALLOCATABLE :: array(:, :)
  REAL :: start, finish
  INTEGER :: LDA, LWORK, INFO
  INTEGER, ALLOCATABLE :: IPIV(:)
  COMPLEX(dp), ALLOCATABLE :: WORK(:)
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
  LDA = array_size
  LWORK = LDA * LDA
  allocate(WORK(LWORK))
  allocate(IPIV(array_size))
  IPIV(:) = 0
  WORK(:) = 0d0

  call get_random_complex_invertable_hermitian_array(array_size, array)
  if (quiet == 0) then
    print *, "first element: ", array(1, 1)
  end if

  call zgetrf ( array_size, array_size, array, LDA, IPIV, INFO )
  call zgetri ( array_size, array, LDA, IPIV, WORK, LWORK, INFO )
  
  call now(finish)
  elapsed = finish - start
  if (quiet == 0) then
    call report_elapsed(elapsed)
  end if
  deallocate(array)
  deallocate(WORK)
  deallocate(IPIV)
end subroutine cmatinv
