# Install

To install hit start Julia and hit "]" to enter pkg REPL and type

```julia
pkg> registry add https://github.com/MatrixLabTools/PackageRegistry
pkg> add PotentialFitting
```

Installation should proceed without errors. But there is a small change that
some errors arise related to scikitlearn. To fix there make sure you have
scikitlearn installed and that python can find it. Then you need to build
PyCall again, to make it use python that can import scikitlearn.
