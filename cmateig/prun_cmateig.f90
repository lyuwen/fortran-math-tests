program main
  IMPLICIT NONE
  include 'mpif.h'
  INTEGER :: process_Rank, size_Of_Cluster, ierror
  INTEGER,PARAMETER :: dp=kind(1.d0)
#ifdef ARRSIZE
  INTEGER,PARAMETER :: array_size = ARRSIZE
#else
  INTEGER,PARAMETER :: array_size = 1000
#endif
  REAL :: elapsed
 
  
  call MPI_INIT(ierror)
  call MPI_COMM_SIZE(MPI_COMM_WORLD, size_Of_Cluster, ierror)
  call MPI_COMM_RANK(MPI_COMM_WORLD, process_Rank, ierror)
  
  print *, 'Hello World from process: ', process_Rank, 'of ', size_Of_Cluster

  call cmateig(array_size, elapsed, 0)

  call MPI_FINALIZE(ierror)
end program main
