subroutine matinv(array_size, elapsed)
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: array_size
  REAL,INTENT(OUT) :: elapsed
  REAL(dp), ALLOCATABLE :: array(:, :)
  REAL :: start, finish
  INTEGER :: LDA, LWORK, INFO
  INTEGER, ALLOCATABLE :: IPIV(:)
  REAL(dp), ALLOCATABLE :: WORK(:)
  !
  call now(start)
  print *, "array size: ", array_size
  allocate(array(array_size, array_size))
  LDA = array_size
  LWORK = LDA * LDA
  allocate(WORK(LWORK))
  allocate(IPIV(array_size))
  IPIV(:) = 0
  WORK(:) = 0d0

  seed = 0
  call random_seed(seed)
  call random_number(array)
  array = array * 100d0
  print *, "first element: ", array(1, 1)
  ! array = matmul(array, transpose(array))
  array = matmul(transpose(array), array)

  call dgetrf ( array_size, array_size, array, LDA, IPIV, INFO )
  call dgetri ( array_size, array, LDA, IPIV, WORK, LWORK, INFO )
  
  call now(finish)
  elapsed = finish - start
  call report_elapsed(elapsed)
  deallocate(array)
  deallocate(WORK)
  deallocate(IPIV)
end subroutine matinv
