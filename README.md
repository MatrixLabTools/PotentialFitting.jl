# PotentialFitting.jl

[![Build Status](https://travis-ci.org/MatrixLabTools/PotentialFitting.jl.svg?branch=master)](https://travis-ci.org/MatrixLabTools/PotentialFitting.jl) [![codecov](https://codecov.io/gh/MatrixLabTools/PotentialFitting.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/MatrixLabTools/PotentialFitting.jl)

[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://MatrixLabTools.github.io/PACKAGE_NAME.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://MatrixLabTools.github.io/PotentialFitting.jl/dev/)

The aim here is to make a tool to fit (and calculate) non-bonding potential between 2 molecules.
The fitted potential can then be used to do QM/MM molecular dynamics.

This package consist of two separe packages [PotentialCalculation](https://github.com/MatrixLabTools/PotentialCalculation.jl) and [PotentialFitting](https://github.com/MatrixLabTools/PotentialFitting.jl).
This separation was made so that potential calculation package does not need to
pull visualization packages.

To install use
```julia
pkg> registry add https://github.com/MatrixLabTools/PackageRegistry
pkg> add PotentialFitting
```
