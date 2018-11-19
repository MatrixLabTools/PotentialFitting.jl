module PotentialFitting

using PotentialCalculation, ScikitLearn

export AbstractPotential, AbstractClusterPotential, AbstractPairPotential,
       LennardJones, MoleculePairPotential, index_transformation, r_to_potential,
       add_identicals, get_potential, print_potential,
       fit_potential!,
       Fitter, FitData, setweight_e_more!, setweight_e_less!, give_fittable_x,
       give_predictable_x, predict_potential,
       plot_calculated_by_index, plot_compare_by_index, points_from, write_to_xyz,
       visualize_points, visualize_data_points, vizualize_by_energy_diff



include("potentials.jl")
include("fit.jl")
include("visualize.jl")


using .potentials
using .fit
using .visualize


greet() = print("Hello World!")

end # module
