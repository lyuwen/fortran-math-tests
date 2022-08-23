subroutine get_random_double_array(array_size, array)
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !                                          !
  ! Generate a random double precision array !
  !                                          !
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: array_size
  REAL(dp), INTENT(INOUT) :: array(array_size, array_size)
  !
  seed = 0
  call random_seed(seed)
  call random_number(array)
end subroutine get_random_double_array


subroutine get_random_double_invertable_array(array_size, array)
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !                                                             !
  ! Generate a random double precision array that is invertable !
  !                                                             !
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER,INTENT(IN) :: array_size
  REAL(dp), INTENT(INOUT) :: array(array_size, array_size)
#ifdef USE_DGEMM
  REAL(dp) :: temp(array_size, array_size)
  REAL(dp), parameter :: ALPHA=1.0, BETA=0.0
#endif
  !
  call get_random_double_array(array_size, array)
#ifdef USE_DGEMM
  CALL DGEMM('N','N',array_size,array_size,array_size,ALPHA,transpose(array),array_size,array,array_size,BETA,temp,array_size)
  array = temp / array_size * 100
#else
  array = matmul(transpose(array), array)
  array = array / array_size * 100
#endif
end subroutine get_random_double_invertable_array


subroutine get_random_complex_array(array_size, array)
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !                                           !
  ! Generate a random complex precision array !
  !                                           !
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER :: seed
  INTEGER,INTENT(IN) :: array_size
  COMPLEX(dp), INTENT(INOUT) :: array(array_size, array_size)
  REAL(dp), ALLOCATABLE :: temp(:, :)
  !
  allocate(temp(array_size, array_size))
  call get_random_double_array(array_size, temp)
  array(:, :) = 0
  array = array + temp * CMPLX(1.0, 0.0)
  call get_random_double_array(array_size, temp)
  array = array + temp * CMPLX(0.0, 1.0)
  deallocate(temp)
end subroutine get_random_complex_array


subroutine get_random_complex_hermitian_array(array_size, array)
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !                                                                    !
  ! Generate a random double precision complex array that is Hermitian !
  !                                                                    !
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  IMPLICIT NONE
  INTEGER,PARAMETER :: dp=kind(1.d0)
  INTEGER,INTENT(IN) :: array_size
  COMPLEX(dp), INTENT(INOUT) :: array(array_size, array_size)
  COMPLEX(dp), ALLOCATABLE :: ctemp(:, :)
  !
  call get_random_complex_array(array_size, array)
  allocate(ctemp(array_size, array_size))
  ctemp = TRANSPOSE(array)
  array = (array + CONJG(ctemp)) * 50d0
  deallocate(ctemp)
end subroutine get_random_complex_hermitian_array
