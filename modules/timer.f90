subroutine now(time)
  implicit none
  integer, parameter :: dp=kind(1.0d0)
  real, intent(inout) :: time
  integer :: values(8)

  call date_and_time(values=values)
  time = values(5)
  time = values(6) + time * 60.0
  time = values(7) + time * 60.0
  time = real(values(8)) / 1000.0 + time
end subroutine now
