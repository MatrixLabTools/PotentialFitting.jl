using Test
using PotentialFitting
using PotentialCalculation

using ScikitLearn

@sk_import linear_model: LinearRegression



data=load_data_file(normpath(joinpath(dirname(pathof(PotentialFitting)),"../test", "data", "test.jld")))

m1=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster1"].atoms)
m2=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster2"].atoms)

topo=[]
push!(topo, PairPotentialTopology{LJ}([PairTopologyIndices(1,1)]))
push!(topo, PairPotentialTopology{LJ}(LJ(), [PairTopologyIndices(5,1)]))
push!(topo, PairPotentialTopology{LJ}([PairTopologyIndices(4,1)]))
push!(topo, PairPotentialTopology{LJA}([PairTopologyIndices((2,4),1)]))
push!(topo, PairPotentialTopology{LJA}(LJA(), PairTopologyIndices((3,1),1)))

mpp1=MoleculePairPotential(m1,m2, LJ)
mpp=MoleculePairPotential(m1,m2)

mpp.topology = topo

fdata = FitData(mpp, data["Points"], data["Energy"])


model = LinearRegression()

setweight_e_more!(fdata, 0, 1500)
setweight_e_less!(fdata,4,80)
setweight_e_less!(fdata,16,120)

fit_potential!(model, mpp, fdata)

pl = plot_compare(data["Points"][:,1], data["Energy"][:,1], mpp);
