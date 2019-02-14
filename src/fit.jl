module fit

export FitData,
       Fitter,
       fit_potential!,
       give_fittable_x,
       give_predictable_x,
       predict_potential,
       setweight_e_less!,
       setweight_e_more!


using ScikitLearn
using ..potentials, PotentialCalculation


@sk_import linear_model: LinearRegression

"""
    FitData

Structure to help potential parameters fitting.
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
end


function give_as_potential(T, data)
    return MoleculePairPotential{T}(data["c1_molecule"],data["c2_molecule"])
end


function setweight_e_more!(data::FitData, w, e, unit="cm-1")
    ec = energy_from(e, unit)
    data.w[data.E .> ec] .= w
end


function setweight_e_less!(data::FitData, w, e, unit="cm-1")
    ec = energy_from(e, unit)
    data.w[data.E .< ec] .= w
end



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
        get_potential!(mpp.topology[i].potential, model[:coef_][ir[i]]...)
    end
    mpp
end


function predict_potential(model, mpp::MoleculePairPotential, points)
    l1 = length(mpp.mol1)
    l2 = length(mpp.mol2)
    c1 = map(x->x[1:l1],  points)
    c2 = map(x->x[l1+1:l1+l2],  points)
    return predict_potential(moldel, mpp, c1, c2)
end

function predict_potential(model, mpp::MoleculePairPotential, cluster1, cluster2)
    r = hcat(potential_variables(mpp,cluster1,cluster2)...)
    return predict(model, r)
end



end #module
