# Usage

To calculate potential energy surface refer to [PotentialCalculation](https://github.com/tjjarvinen/PotentialCalculation.jl).Ones you have potential energy calculated you can open
it for fitting by using

```@example 1
using PotentialCalculation
using PotentialFitting

# There is an example potential in test/data directory
fname=normpath(joinpath(dirname(pathof(PotentialFitting)),"../test", "data", "test.jld"))

# Load potential
data=load_data_file(fname)
```

## Setting up Molecules

Next part in defining topology for the potential. This is started by creating two
molecules. The information is in the loaded file.

```@example 1
m1=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster1"].atoms)
m2=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster2"].atoms)

show(m1) # hide
show(m2) # hide
```

If neede atoms can be flagged as identical.

```@example 1
# Atoms 2 and 3 are identical
makeidentical!(m1, (2,3))
```

## Potential Topology

Next we need to define topology for the potential.

```@example 1
mpp = MoleculePairPotential(m1,m2, LJ())
```

### Finetuning Potential

Alternatively potential can be tuned complitely by adding potentials one by one.

```@example 1
# Array where topology is saved
topo=[]

#We can push potential to to this array one at the time
push!(topo,
      PairPotentialTopology{LJ}(PairTopologyIndices(1,1))
     )
nothing # hide
```


If needed we can specify which atoms should be treated as identical, by adding
information for it  in the topology.

```@example 1
# Atoms 2 and 3 of molecule 1 have same potential to to atom 1 of molecule 2
push!(topo,
      PairPotentialTopology{LJ}([PairTopologyIndices(2,1), PairTopologyIndices(3,1)])
     )
nothing # hide
```


If default form of potential is not enough it can be tuned, by giving it as an input.

```@example 1
push!(topo,
      PairPotentialTopology{GeneralPowers}(GeneralPowers(-6,-12), PairTopologyIndices(4,1))
     )
push!(topo,
     PairPotentialTopology{GeneralPowers}(GeneralPowers(-6,-8, -10, -12), PairTopologyIndices(4,1))
    )
nothing # hide
```

Here we used general polynomial potential ```GeneralPowers``` to make customized
polynomic potential.

We can now create potential.

```@example 1
mpp1=MoleculePairPotential(m1,m2)
mpp1.topology = topo

show(mpp1)
```

## Preparing Data for Fitting

To do fitting itself we need to prepare fit data.

```@example 1
fdata = FitData(mpp, data["Points"], data["Energy"])
nothing # hide
```

At this point we can add weights to data.

```@example 1
# If energy is more than 1500 cm⁻¹ weigth is zero
setweight_e_more!(fdata, 0, 1500)

# If energy is less than 80 cm⁻¹ weigth is 4
setweight_e_less!(fdata,4,80)
nothing # hide
```

## Fitting Potential

We also need to create fitting model. At the current moment only linear models
can be used. Here we take normal linear regression, but any linear model suported
by ScikitLearn can be used.

```@example 1
import Pkg; Pkg.add("ScikitLearn") # hide
using ScikitLearn
@sk_import linear_model: LinearRegression

model = LinearRegression()
```



To do fitting itself.

```@example 1
fit_potential!(model, mpp, fdata)
```

## Inspecting Fitted Potential

You can inspect the fit by calculating RMSD.

```@example 1
# Unit is hartrees
rmsd(data["Points"], data["Energy"], mpp)
```



Alternatively you can visualize the fit with various methods.

```@example 1
plot_compare(data["Points"][:,1], data["Energy"][:,1], mpp, leg=true)
```



For more visualizations take a look for
- [`plot_compare`](@ref)
- [`scan_compare`](@ref)
- [`scan_vizualize`](@ref)
- [`visualize_points`](@ref)
