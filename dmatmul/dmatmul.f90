subroutine dmatmul(array_size, elapsed, iquiet)
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: array_size
  REAL,INTENT(OUT) :: elapsed
  INTEGER,OPTIONAL :: iquiet
  INTEGER :: quiet
  REAL(dp), ALLOCATABLE :: array(:, :)
  REAL :: start, finish
  REAL(dp), ALLOCATABLE :: temp(:, :)
  REAL(dp), parameter :: ALPHA=1.0, BETA=0.0
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

  call get_random_double_array(array_size, array)
  if (quiet == 0) then
    print *, "first element: ", array(1, 1)
  end if

  allocate(temp(array_size, array_size))
  CALL DGEMM('N','N',array_size,array_size,array_size,ALPHA,transpose(array),array_size,array,array_size,BETA,temp,array_size)
  
  call now(finish)
  elapsed = finish - start
  if (quiet == 0) then
    call report_elapsed(elapsed)
  end if
  deallocate(array)
  deallocate(temp)
end subroutine dmatmul
