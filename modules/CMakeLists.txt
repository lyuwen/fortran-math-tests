### setup project ###
cmake_minimum_required(VERSION 3.9)

project(fortran-math-tests/libmodules
  VERSION 1.0
  DESCRIPTION "fortran-math-tests/libmodules.a Fortran Package"
  LANGUAGES C Fortran
)

# Safety net
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(
    FATAL_ERROR
      "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there.\n"
  )
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

if(${CMAKE_VERSION} VERSION_LESS "3.18.0")
  add_compile_options("-cpp")
else()
  set_source_files_properties(
              random.f90 timer.f90
    PROPERTIES Fortran_PREPROCESS ON
    )
endif()
add_compile_definitions(USE_DGEMM)

add_library(modules STATIC
            random.f90 timer.f90
            )

file(RELATIVE_PATH rel ${CMAKE_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR})
if (rel STREQUAL "")
  set(rel ".")
endif()
set(PROGRAM_PERMISSIONS_DEFAULT
    OWNER_WRITE OWNER_READ OWNER_EXECUTE
    GROUP_READ GROUP_EXECUTE
    WORLD_READ WORLD_EXECUTE)
install(
  TARGETS modules
  ARCHIVE
  DESTINATION ${rel}
  PERMISSIONS ${PROGRAM_PERMISSIONS_DEFAULT}
  )
