module PotentialFitting

using Reexport
using ScikitLearn
@reexport using PotentialCalculation

export AbstractPotential,
       AbstractClusterPotential,
       AbstractPairPotential,
       calculate_potential,
       get_potential!,
       MoleculePairPotential,
       PairPotentialTopology,
       ClusterPotentialTopology,
       PairTopologyIndices,
       potential_variables,
       PotentialTopology,

       FitData,
       Fitter,
       fit_potential!,
       give_fittable_x,
       give_predictable_x,
       predict_potential,
       rmsd,
       setweight_e_less!,
       setweight_e_more!,

       min_distance,
       plot_potential,
       plot_compare,
       scan_compare,
       scan_visualize,
       visualize_points,
       visualize_point_bio3dview,

       LennardJones,
       GeneralPowers,
       GeneralAngle



include("potentials.jl")
include("fit.jl")
include("visualize.jl")
include("potentials/LennardJones.jl")
include("potentials/GeneralPowers.jl")
include("potentials/GeneralAngle.jl")





using .potentials
using .fit
using .visualize
using .lennardjones
using .generalpowers
using .generalangle




end # module
