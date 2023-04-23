subroutine cmatmul(array_size, elapsed, iquiet)
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: array_size
  REAL,INTENT(OUT) :: elapsed
  INTEGER,OPTIONAL :: iquiet
  INTEGER :: quiet
  COMPLEX(dp), ALLOCATABLE :: array(:, :)
  REAL :: start, finish
  COMPLEX(dp), ALLOCATABLE :: temp(:, :)
  COMPLEX(dp), parameter :: ALPHA=1.0, BETA=0.0
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

  call get_random_complex_array(array_size, array)
  if (quiet == 0) then
    print *, "first element: ", array(1, 1)
  end if

  allocate(temp(array_size, array_size))
  CALL ZGEMM('N','N',array_size,array_size,array_size,ALPHA,transpose(array),array_size,array,array_size,BETA,temp,array_size)
  
  call now(finish)
  elapsed = finish - start
  if (quiet == 0) then
    call report_elapsed(elapsed)
  end if
  deallocate(array)
  deallocate(temp)
end subroutine cmatmul


subroutine arrcmatmul(grid_size, array_size, elapsed, iquiet)
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: grid_size, array_size
  REAL,INTENT(OUT) :: elapsed
  INTEGER,OPTIONAL :: iquiet
  INTEGER :: quiet, i, j
  COMPLEX(dp), ALLOCATABLE :: array(:, :, :, :)
  REAL :: start, finish
  COMPLEX(dp), ALLOCATABLE :: temp(:, :, :, :)
  COMPLEX(dp), parameter :: ALPHA=1.0, BETA=0.0
  !
  if(present(iquiet))then
    quiet = iquiet
  else
    quiet = 0
  endif
  !
  if (quiet == 0) then
    print *, "grid size: ", grid_size, ", array size: ", array_size
  end if
  allocate(array(array_size, array_size, grid_size, grid_size))

  
  do i = 1, grid_size
    do j = 1, grid_size
      call get_random_complex_array(array_size, array(:, :, i, j))
    enddo
  enddo
  if (quiet == 0) then
    print *, "first element: ", array(1, 1, 1, 1)
  end if

  call now(start)
  allocate(temp(array_size, array_size, 1, 1))
  do i = 1, grid_size
    do j = 1, grid_size
      CALL ZGEMM('N','N',array_size,array_size,array_size,ALPHA,transpose(array(:, :, i, j)),array_size,array(:, :, i, j),array_size,BETA,temp(:, :, 1, 1),array_size)
    enddo
  enddo
  
  call now(finish)
  elapsed = finish - start
  if (quiet == 0) then
    call report_elapsed(elapsed)
  end if
  deallocate(array)
  deallocate(temp)
end subroutine arrcmatmul
