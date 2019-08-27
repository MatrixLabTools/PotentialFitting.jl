# Usage

To calculate potential energy surface refer to [PotentialCalculation](https://github.com/tjjarvinen/PotentialCalculation.jl).Ones you have potential energy calculated you can open
it for fitting by using

```@example 1
import PotentialCalculation
import PotentialFitting

# There is a example potential in test/data directory
fname=normpath(joinpath(dirname(pathof(PotentialFitting)),"../test", "data", "test.jld"))

# Load potential
data=load_data_file(fname)
```


Next part in defining topology for the potential. This is started by creating two
molecules. The information is in the loaded file.

```@example 1

m1=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster1"].atoms)
m2=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster2"].atoms)

show(m1) # hide
show(m2) # hide
```



Next we need to define topology for the potential.

```@example 1

# Array where topology is saved
topo=[]

#We can push potential to to this array one at the time
push!(topo,
      PairPotentialTopology{LJ}(PairTopologyIndices(1,1))
     )

```

Here we used Lennard Jones potential with symbol ```JL```

If needed we can specify which atoms should be treated as identical, by adding
information for it  in the topology.

```@example 1

# Atoms 2 and 3 of molecule 1 have same potential to to atom 1 of molecule 2
push!(topo,
      PairPotentialTopology{LJ}([PairTopologyIndices(2,1), PairTopologyIndices(3,1)])
     )

```

If default form of potential is not enough it can be tuned, by giving it as an input

```@example 1

push!(topo,
      PairPotentialTopology{GeneralPowers}(GeneralPowers(-6,-12), PairTopologyIndices(4,1))
     )
push!(topo,
     PairPotentialTopology{GeneralPowers}(GeneralPowers(-6,-8, -10, -12), PairTopologyIndices(4,1))
    )
 ```

 Here we used general polynomial potential ```GeneralPowers``` to make customized
 polynomic potential.
