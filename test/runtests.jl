using Test
using PotentialFitting
using PotentialCalculation
using PotentialDB

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

@testset "Fit" begin
    r = defaultregistry()
    data = loadpotential(r, "7")

    m1=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster1"].atoms)
    m2=MoleculeIdenticalInformation{AtomOnlySymbol}(data["cluster2"].atoms)
    mpp = MoleculePairPotential(m1,m2, GeneralPowers(-6,-8,-10,-12,-7,-9,-11))


    fdata = FitData(mpp, data, data)
    setweight_e_more!(fdata, 0.1, 1000)
    setweight_e_more!(fdata, 0.01, 5000)
    setweight_e_less!(fdata, 2, -50)
    setweight_e_less!(fdata, 4, -75)
    setweight_e_less!(fdata, 16, -100)

    model = LinearRegression(fit_intercept=false)
    fit_potential!(model, mpp, fdata)

    @test rmsd(data["Points"], data["Energy"], mpp, emax=-10) < 10
end
