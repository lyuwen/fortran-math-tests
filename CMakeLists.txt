### setup project ###
cmake_minimum_required(VERSION 3.9)

project(fortran-math-tests
  VERSION 1.0
  DESCRIPTION "Fortran-Math-Tests Fortran Package"
  LANGUAGES C Fortran
)

# Safety net
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(
    FATAL_ERROR
      "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.\n"
  )
endif()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# Lapack Package
find_package(BLAS REQUIRED)
set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${BLAS_LINKER_FLAGS}")

# Lapack Package
find_package(LAPACK REQUIRED)
set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${LAPACK_LINKER_FLAGS}")

add_compile_definitions(USE_DGEMM)
add_compile_definitions(LOOP=10)

message(STATUS "Add libmodules.a subdirectory.")
add_subdirectory(modules)
message(STATUS "Add cmateig subdirectory.")
add_subdirectory(cmateig)
message(STATUS "Add matinv subdirectory.")
add_subdirectory(matinv)

add_executable(run_tests
  run_tests.f90 cmateig/cmateig.f90 matinv/matinv.f90
  )

include(CTest)
add_test(NAME Run_Tests
         COMMAND run_tests)

set_source_files_properties(
  run_tests.f90 cmateig/cmateig.f90 matinv/matinv.f90
  PROPERTIES Fortran_PREPROCESS ON
  )


target_link_libraries(run_tests PRIVATE "${BLAS_LIBRARIES}" "${LAPACK_LIBRARIES}" modules)
# target_link_libraries(run_tests PRIVATE "${LAPACK_LIBRARIES}")
# target_link_libraries(run_tests modules)


file(RELATIVE_PATH rel ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR})
if (rel STREQUAL "")
  set(rel ".")
endif()
install(
  TARGETS run_tests
  RUNTIME
  DESTINATION ${rel}
  )
