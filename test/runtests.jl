using Test
using PotentialFitting
using PotentialCalculation

using ScikitLearn

@sk_import linear_model: LinearRegression



data=load_data_file(normpath(joinpath(dirname(pathof(PotentialFitting)),"../test", "data", "test.jld")))

m1=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster1"].atoms)
m2=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster2"].atoms)

topo=[]
push!(topo, PairPotentialTopology(LennardJones(),1,6))
push!(topo, PairPotentialTopology(LennardJones(), 5,6))
push!(topo, PairPotentialTopology(GeneralPowers(),4,6))
push!(topo, PairPotentialTopology(LennardJones(),2,6))
push!(topo, ClusterPotentialTopology(GeneralAngle([-6, -12], [0, 1]), 1,3,6))

mpp1=MoleculePairPotential(m1,m2, LennardJones())
mpp=MoleculePairPotential(m1,m2)

mpp.topology = topo

fdata = FitData(mpp, data["Points"], data["Energy"])


model = LinearRegression()

setweight_e_more!(fdata, 0, 1500)
setweight_e_less!(fdata,4,80)
setweight_e_less!(fdata,16,120)

fit_potential!(model, mpp, fdata)
rmsd(data["Points"],data["Energy"],mpp)

pl = plot_compare(data["Points"][:,1], data["Energy"][:,1], mpp);
