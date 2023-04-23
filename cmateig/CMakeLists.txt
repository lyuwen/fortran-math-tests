### setup project ###
cmake_minimum_required(VERSION 3.9)

set(base_name cmateig)
project(${base_name}
  VERSION 1.0
  DESCRIPTION "${base_name} Fortran Program"
  LANGUAGES C Fortran
)

# Safety net
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(
    FATAL_ERROR
      "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.\n"
  )
endif()

include(CTest)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_Fortran_FLAGS_DEBUG "-g")
set(CMAKE_Fortran_FLAGS_RELEASE "-O3")

include(CheckFortranCompilerFlag)
check_fortran_compiler_flag("-heap-arrays" FHEAPARRAYS)
if(${FHEAPARRAYS})
  message(STATUS "Compiler flag -heap-arrays is supported.")
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -heap-arrays")
endif()
check_fortran_compiler_flag("-no-wrap-margin" FNOWRAPMARGIN)
if(${FNOWRAPMARGIN})
  message(STATUS "Compiler flag -no-wrap-margin is supported.")
  set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -no-wrap-margin")
endif()

# Lapack Package
find_package(BLAS REQUIRED)
set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${BLAS_LINKER_FLAGS}")

# Lapack Package
find_package(LAPACK REQUIRED)
set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${LAPACK_LINKER_FLAGS}")

if (NOT TARGET modules)
  message(STATUS "Add libmodules.a subdirectory.")
  add_subdirectory(../modules modules EXCLUDE_FROM_ALL)
endif()

if(${CMAKE_VERSION} VERSION_LESS "3.18.0")
  add_compile_options("-cpp")
else()
  set_source_files_properties(
    run_${base_name}.f90 ${base_name}.f90 prun_${base_name}.f90
    PROPERTIES Fortran_PREPROCESS ON
    )
endif()

list(APPEND ARRSIZES 10 100 1000 2000 5000 10000)
foreach(arrsize IN LISTS ARRSIZES)
  message(STATUS "Array Size = ${arrsize}")
  add_executable(${base_name}-${arrsize}
    run_${base_name}.f90 ${base_name}.f90
    )
  add_executable(parallel-${base_name}-${arrsize}
    prun_${base_name}.f90 ${base_name}.f90
    )
  target_compile_definitions(${base_name}-${arrsize} PRIVATE ARRSIZE=${arrsize})
  target_compile_definitions(parallel-${base_name}-${arrsize} PRIVATE ARRSIZE=${arrsize})
  add_test(NAME Test_${base_name}_${arrsize}
           COMMAND ${base_name}-${arrsize})
  add_test(NAME Test_parallel_${base_name}_${arrsize}
           COMMAND ${base_name}-${arrsize})
  target_link_libraries(${base_name}-${arrsize} PRIVATE "${BLAS_LIBRARIES}" "${LAPACK_LIBRARIES}" modules)
  target_link_libraries(parallel-${base_name}-${arrsize} PRIVATE "${BLAS_LIBRARIES}" "${LAPACK_LIBRARIES}" modules)
  list(APPEND EXETARGETS ${base_name}-${arrsize})
  list(APPEND EXETARGETS parallel-${base_name}-${arrsize})
endforeach()

message(STATUS "Targets to build = ${EXETARGETS}")

file(RELATIVE_PATH rel ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR})
if (rel STREQUAL "")
  set(rel ".")
endif()
install(
  TARGETS ${EXETARGETS}
  RUNTIME
  DESTINATION ${rel}
  )
