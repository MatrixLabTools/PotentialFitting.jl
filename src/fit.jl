module fit

export FitData,
       Fitter,
       fit_potential!,
       give_fittable_x,
       give_predictable_x,
       predict_potential,
       rmsd,
       setweight_e_less!,
       setweight_e_more!


using ScikitLearn
using ..potentials, PotentialCalculation
using Statistics:std


@sk_import linear_model: LinearRegression

"""
    FitData

Structure to help potential parameters fitting.

# Fields
- `variables` : variables
- `E`         : energy
- `w`         : weights
"""
mutable struct FitData
    "Variables"
    variables
    "Energy"
    E
    "Weights"
    w
    function FitData(mpp, cluster1, cluster2, energy)
        #TODO add methid to take account identical atoms
        new( potential_variables(mpp,cluster1,cluster2) , vcat(energy...) , ones(length(energy)))
    end
    function FitData(mpp,points,energy)
        new( potential_variables(mpp,points) , vcat(energy...) , ones(length(energy)))
    end
end


"""
give_as_potential(T, data)

Returns MoleculePairPotential{T} from given data that must have `"c1_molecule"`
and `"c2_molecule"` fields
"""
function give_as_potential(T, data)
    return MoleculePairPotential{T}(data["c1_molecule"],data["c2_molecule"])
end


"""
setweight_e_more!(data::FitData, w, e; unit="cm-1")

Sets weigth when energy is more than given one.

# Arguments
- `data::FitData`  : data where weigth is adjusted
- `w`              : new weigth
- `e`              : energy
- `unit="cm-1"`    : energy unit
"""
function setweight_e_more!(data::FitData, w, e; unit="cm-1")
    ec = energy_from(e, unit)
    data.w[data.E .> ec] .= w
end


"""
setweight_e_more!(data::FitData, w, e; unit="cm-1")

Sets weigth when energy is more than given one.

# Arguments
- `data::FitData`  : data where weigth is adjusted
- `w`              : new weigth
- `e`              : energy
- `unit="cm-1"`    : energy unit
"""
function setweight_e_less!(data::FitData, w, e, unit="cm-1")
    ec = energy_from(e, unit)
    data.w[data.E .< ec] .= w
end


"""
fit_potential!(model, mpp::MoleculePairPotential, fdata::FitData)

Fits potential using given model

# Arguments
- `model`                       : ScikitLearn model
- `mpp::MoleculePairPotential`  : potential
- `fdata::FitData`              : data used in fitting
"""
function fit_potential!(model, mpp::MoleculePairPotential, fdata::FitData)
    r = hcat(fdata.variables...)
    fit!(model, r, fdata.E, fdata.w)
    tl =  [ size(v)[2]  for v in fdata.variables ]
    ir=[]
    i = 1
    for x in tl
        push!(ir, i:i+x-1)
        i += x
    end
    for i in eachindex(ir)
        get_potential!(mpp.topology[i].potential, model.coef_[ir[i]]...)
    end
    mpp
end


"""
predict_potential(model, mpp::MoleculePairPotential, points)

Uses `model` to predict potential on given points
"""
function predict_potential(model, mpp::MoleculePairPotential, points)
    l1 = length(mpp.mol1)
    l2 = length(mpp.mol2)
    c1 = map(x->x[1:l1],  points)
    c2 = map(x->x[l1+1:l1+l2],  points)
    return predict_potential(moldel, mpp, c1, c2)
end

"""
predict_potential(model, mpp::MoleculePairPotential, cluster1, cluster2)

Uses `model` to predict potential on given cluster points
"""
function predict_potential(model, mpp::MoleculePairPotential, cluster1, cluster2)
    r = hcat(potential_variables(mpp,cluster1,cluster2)...)
    return predict(model, r)
end


"""
rmsd(points, energy, mpp::MoleculePairPotential; emax=0, unit="cm^-1")

Calculates root mean square error for potential `mpp`.

# Atributes
- `points`                      : points where potential is tested
- `energy`                      : referece energy for given points
- `mpp::MoleculePairPotential`  : potential
- `emax=0`                      : cut points where energy is larger than this
- `unit="cm^-1"`                : unit for `emax`
"""
function rmsd(points, energy, mpp::MoleculePairPotential; emax=0, unit="cm^-1")
    @assert size(points) == size(energy) "points and energy need to have same size"
    e = energy_from(emax,unit)
    i = energy .< e
    ec = mpp.(points)
    return std(ec[i]-energy[i])
end


end #module
