module PotentialFitting

using PotentialCalculation, ScikitLearn

export AbstractPotential,
       AbstractClusterPotential,
       AbstractPairPotential,
       calculate_potential,
       get_potential!,
       MoleculePairPotential,
       PairPotentialTopology,
       PairTopologyIndices,
       potential_variables,
       PotentialTopology,

       FitData,
       Fitter,
       fit_potential!,
       give_fittable_x,
       give_predictable_x,
       predict_potential,
       setweight_e_less!,
       setweight_e_more!,

       min_distance,
       plot_potential,
       plot_compare,
       visualize_points,

       LennardJones,
       LJ



include("potentials.jl")
include("fit.jl")
include("visualize.jl")
include("potentials/LennardJones.jl")



using .potentials
using .fit
using .visualize
using .lennardjones


end # module
