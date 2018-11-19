module fit

export Fitter, FitData, setweight_e_more!, setweight_e_less!, give_fittable_x,
       fit_potential!, give_predictable_x, predict_potential

using ScikitLearn
using ..potentials, PotentialCalculation


@sk_import linear_model: LinearRegression


mutable struct FitData
    R
    E
    w
    function FitData(R,E,w)
        if length(E) != length(w)
            error("FitData - E and w have different lengths $(length(E)) vs. $(length(w))")
        end
        new(R,E,w)
    end
    function FitData(data)
        r = give_radius(data,true)
        e = give_energy(data,true)
        w = ones(size(e))
        new(r,e,w)
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



function give_predictable_x(mpp::MoleculePairPotential, r)
    t = typeof(mpp).parameters[1]
    idt = index_transformation(mpp)
    rtmp = r_to_potential(t,r)
    rt = map( x ->  add_identicals(x, idt["forward"]), rtmp)
    return hcat(rt...)
end


"""
    give_fittable_x(mpp::MoleculePairPotential, fdata::FitData)

Transforms data to form that can be fitted to given potential
"""
function give_fittable_x(mpp::MoleculePairPotential, fdata::FitData)
    return give_predictable_x(mpp, fdata.R)
end

function fit_potential!(model, mpp::MoleculePairPotential, fdata::FitData)
    t = typeof(mpp).parameters[1]  #Potential type
    r = give_fittable_x(mpp, fdata)
    fit!(model, r, fdata.E, fdata.w)
    pot = get_potential(t, model[:coef_], model[:intercept_])
    idt = index_transformation(mpp)
    tmp=Array{t}(undef,length(idt["backward"]))
    for i in eachindex(tmp)
        tmp[i] = pot[idt["backward"][i]]
    end
    tmp=reshape(tmp, size(mpp.potential))
    mpp.potential .= tmp
    #TODO Finish one...
    mpp
end


function predict_potential(model, mpp::MoleculePairPotential, r)
    rp = give_predictable_x(mpp, r)
    return predict(model, rp)
end




end #module
