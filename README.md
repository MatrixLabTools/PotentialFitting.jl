# PotentialFitting.jl

| **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][CI-img]][CI-url] [![][codecov-img]][codecov-url] |


The aim here is to make a tool to fit (and calculate) non-bonding potential
between 2 molecules.The fitted potential can then be used to do QM/MM
molecular dynamics.

This package consist of two separe packages [PotentialCalculation](https://github.com/MatrixLabTools/PotentialCalculation.jl)
and [PotentialFitting](https://github.com/MatrixLabTools/PotentialFitting.jl).
This separation was made so that potential calculation package does not need to
pull visualization packages.

To install use
```julia
pkg> registry add https://github.com/MatrixLabTools/PackageRegistry
pkg> add PotentialFitting
```

Note that you might need to install [ScikitLearn](https://scikit-learn.org) manually


[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://MatrixLabTools.github.io/PotentialFitting.jl/dev/

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://MatrixLabTools.github.io/PotentialFitting.jl/stable

[CI-img]: https://github.com/MatrixLabTools/PotentialFitting.jl/workflows/CI/badge.svg
[CI-url]: https://github.com/MatrixLabTools/PotentialFitting.jl/actions?query=workflow%3ACI

[codecov-img]: https://codecov.io/gh/MatrixLabTools/PotentialFitting.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/MatrixLabTools/PotentialFitting.jl
