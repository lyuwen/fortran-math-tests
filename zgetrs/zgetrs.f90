subroutine test_zgetrs(array_size, elapsed, iquiet)
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: array_size
  REAL,INTENT(OUT) :: elapsed
  INTEGER,OPTIONAL :: iquiet
  INTEGER :: quiet
  COMPLEX(dp), ALLOCATABLE :: array(:, :)
  COMPLEX(dp), ALLOCATABLE :: arrayb(:, :)
  REAL :: start, finish
  INTEGER :: LDA, INFO
  INTEGER, ALLOCATABLE :: IPIV(:)
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
  allocate(arrayb(array_size, array_size))
  LDA = array_size
  allocate(IPIV(array_size))
  IPIV(:) = 0

  call get_random_complex_invertable_hermitian_array(array_size, array)
  call get_random_complex_array(array_size, arrayb)
  if (quiet == 0) then
    print *, "first element: ", array(1, 1)
  end if

  call zgetrf ( array_size, array_size, array, LDA, IPIV, INFO )
  call zgetrs ( "N", array_size, array_size, array, LDA, IPIV, arrayb, LDA, INFO )
  
  call now(finish)
  elapsed = finish - start
  if (quiet == 0) then
    call report_elapsed(elapsed)
  end if
  deallocate(array)
  deallocate(arrayb)
  deallocate(IPIV)
end subroutine test_zgetrs
