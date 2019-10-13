# Running molecular dynamics

## Fitting Potential

First fit potential. In this example we fit potential for trans-formic acid
and argon.
```@example md
using PotentialDB
r = defaultregistry()
data = loadpotential(r, "4")
```

```@example md
using PotentialFitting, PotentialCalculation

m1=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster1"].atoms)
m2=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster2"].atoms)

mpp = MoleculePairPotential(m1,m2, GeneralPowers(-6,-7,-8,-9,-10,-11,-12))
```

```@example md
fdata = FitData(mpp, data["Points"], data["Energy"])

setweight_e_more!(fdata, 0.1, 1000)
setweight_e_more!(fdata, 0.01, 5000)
setweight_e_less!(fdata, 2, -50)
setweight_e_less!(fdata, 4, -75)
setweight_e_less!(fdata, 16, -100);
```

```@example md
using ScikitLearn
@sk_import linear_model: LinearRegression

model = LinearRegression()
```

```@example md
fit_potential!(model, mpp, fdata)
```

```@example md
rmsd(data["Points"], data["Energy"], mpp, emax=-10)
```

To inspect the potential we can use use
```@example md
plot_compare(data["Points"][:,30], data["Energy"][:,30], mpp, leg=true)
```

`scan_compare`-command is also available and usually much faster to visualize the fit.
```@example md
scan_compare(data["Points"], data["Energy"], mpp)
```

If you found a place in the potential that is not well fitted and want to know
where it is, you can visualize it. There are two options
- `scan_vizualize` Uses [Bio3DView](https://github.com/jgreener64/Bio3DView.jl) and needs IJulia (Jupyter notebook) or [Blink](https://github.com/JuliaGizmos/Blink.jl) to work.
- `visualize_points` This calls external progam (defaults to VMD) for visualizations. Does not work with IJulia.

```julia
visualize_points(data["Points"][:,32])
```

## Prepare CP2K input files
