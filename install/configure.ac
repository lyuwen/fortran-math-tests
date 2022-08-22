#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([fortran-math-tests], [0.0.1])

AC_CONFIG_MACRO_DIR([m4])

# m4_pattern_allow([m4_ifval])

# Checks for programs.
AC_PROG_FC
AM_PROG_AR

# LT_INIT([shared])
# LT_INIT([enable-shared, enable-static])
# LT_LANG([Fortran 77])
# LT_PATH_LD
AS_IF([test "$LD"], [LD="$LD"], [LD="$FC"])
AC_SUBST(LD, "$LD")


# Checks for libraries.
# FIXME: Replace 'main' with a function in '-lblas':
# AC_CHECK_LIB([blas], [DGEMM])
# FIXME: Replace 'main' with a function in '-llapack':
# AC_CHECK_LIB([lapack], [ZHEEVD])

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.
AX_CHECK_COMPILE_FLAG([-heap-arrays], [FFLAGS="$FFLAGS -heap-arrays"])
AX_CHECK_COMPILE_FLAG([-no-wrap-margin], [FFLAGS="$FFLAGS -no-wrap-margin"])
AX_CHECK_COMPILE_FLAG([-O3], [FFLAGS="$FFLAGS -O3"])

# Checks for library functions.
# ACX_MKL([], [echo "No MKL Found"])
AX_LAPACK()
# AX_BLAS()

AC_CONFIG_FILES([Makefile.in:install/Makefile.in.ac])
AC_OUTPUT
