
"""
    LennardJones <: AbstractPairPotential

Holds constants for Lennard-Jones potential
    E = C12/R^12 - C6/R^6
"""
mutable struct LennardJones <: AbstractPairPotential
    C6::Float64
    C12::Float64
    LennardJones() = new(0.0,0.0)
    LennardJones(c6,c12) = new(c6,c12)
end



function Base.show(io::IO, potential::LennardJones; energy_unit="cm^-1")
    if potential.C6 > 0 && potential.C12 > 0
        ϵ = energy_to(potential.C6^2/(4*potential.C12), energy_unit)
        σ = (potential.C12/potential.C6)^(1/6)
        print(io, "$(typeof(potential)),  ϵ=$(ϵ) $(energy_unit), σ=$(σ) Å")
    else
        print(io, "$(typeof(potential)),  C6=$(potential.C6), C12=$(potential.C12)")
    end
end


function potential_variables(potential::LennardJones,
                             c::AbstractCluster, indices)
    r=distances(c, indices[1], indices[2])
    return [r^-6 r^-12]
end

function get_potential!(potential::LennardJones, x6, x12)
    potential.C6 = -x6
    potential.C12 = x12
    return potential
end


function (p::LennardJones)(r::Number)::Float64
    r6 = r^-6
    muladd(r6, p.C12, -p.C6) * r6
end
