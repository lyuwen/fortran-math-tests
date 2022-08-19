# fortran-math-tests

[![Makefile CI](https://github.com/lyuwen/fortran-math-tests/actions/workflows/makefile.yml/badge.svg)](https://github.com/lyuwen/fortran-math-tests/actions/workflows/makefile.yml)

## Compilation

In order to compiler the testing programs, a ``Makefile.in`` files needs to be prepared.
There are several templates in the ``arch`` directory for references.
The main goal there is to set the correct Fortran compiler, linker, archive manager and the linking flags for Lapack and Blas libraries.


## Example GNU

```bash
ln -s arch/Makefile.in.gnu Makefile.in
make -j4 all
make test-all
```
