# PotentialFitting.jl

[![Build Status](https://travis-ci.org/tjjarvinen/PotentialFitting.jl.svg?branch=master)](https://travis-ci.org/tjjarvinen/PotentialFitting.jl) [![codecov](https://codecov.io/gh/tjjarvinen/PotentialFitting.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/tjjarvinen/PotentialFitting.jl)

[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://tjjarvinen.github.io/PotentialFitting.jl/dev/)

Package is in working state and should be usable for most of the intended use
cases.

The aim here is to make a tool to fit (and calculate) non-bonding potential between 2 molecules.
The fitted potential can then be used to do QM/MM molecular dynamics.

This package consist of two separe packages [PotentialCalculation](https://github.com/tjjarvinen/PotentialCalculation.jl) and [PotentialFitting](https://github.com/tjjarvinen/PotentialFitting.jl).
This separation was made so that potential calculation package does not need to
pull visualization packages.
