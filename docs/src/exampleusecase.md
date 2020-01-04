# Running molecular dynamics

This is an example workflow for doing the whole calculation, exept calculating
potential itself that has been explained else where.

## Fitting Potential

First we need to fit a potential. In this example we fit a potential for trans-formic acid
and argon. [PotentialDB](https://github.com/MatrixLabTools/PotentialDB.jl) has
precalculated data than we can use for fitting the potential.

```@example md
using PotentialDB
r = defaultregistry()
data = loadpotential(r, "4")
```

The fitting procedure is the same as explained in [Usage](@ref) section.

First we create potential for fitting.

```@example md
using PotentialFitting, PotentialCalculation

m1=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster1"].atoms)
m2=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster2"].atoms)

mpp = MoleculePairPotential(m1,m2, GeneralPowers(-6,-7,-8,-9,-10,-11,-12))
```

Then we prepare fitting data and apply some constrains. The reason why we applying
constrains is that our potential is under fitting. You can verify this, by taking
constrains off and comparing to constrained potential, or by changins the constrains
considerably.
```@example md
fdata = FitData(mpp, data["Points"], data["Energy"])

setweight_e_more!(fdata, 0.1, 1000)
setweight_e_more!(fdata, 0.01, 5000)
setweight_e_less!(fdata, 2, -50)
setweight_e_less!(fdata, 4, -75)
setweight_e_less!(fdata, 16, -100);

nothing # hide
```

Then we prepare fitting tools for fitting. Linear regression is most likely good
enough. But you can also try support vector machines or ridge regression etc.

```@example md
using ScikitLearn
@sk_import linear_model: LinearRegression

model = LinearRegression(fit_intercept=false)
```

Fitting potential.
```@example md
fit_potential!(model, mpp, fdata)
```

Check root mean square deviation for potential.
```@example md
rmsd(data["Points"], data["Energy"], mpp, emax=-10)
```
!!! note "Note"
    We are under fitting our potential, so we can safely compare the potential
    to the data we used for fitting. But it would be a good idea to confirm this,
    by comparing to some data that was not used for fitting.


To inspect the potential we can use use `plot_compare` which will calculate
potential for given points. Here we visualize one line from potential.
```@eval md
#plot_compare(data["Points"][:,30], data["Energy"][:,30], mpp, leg=true)
using Plots
x = linspace(-π, π)
y = sin(x)

plot(x, y, color = "red")
savefig("plot.svg")

nothing
```
![](plot.svg)

`scan_compare`-command is also available and usually much faster to visualize
the fit.
```@example md
scan_compare(data["Points"], data["Energy"], mpp, leg=true)
```

If you found a place in the potential that is not well fitted and want to know
where it is, you can visualize it. There are two options
- `scan_vizualize` Uses [Bio3DView](https://github.com/jgreener64/Bio3DView.jl) and needs IJulia (Jupyter notebook) or [Blink](https://github.com/JuliaGizmos/Blink.jl) to work.
- `visualize_points` This calls external progam (defaults to VMD) for visualizations. Does not work with IJulia.

To call them use
```julia
scan_visualize_points(data["Points"])

# Visualize line 32 using vmd
visualize_points(data["Points"][:,32], command="vmd")
```

## Prepare CP2K input files

To start CP2K input we first prepare
