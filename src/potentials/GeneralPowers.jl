
# NOTE distance in potentials is ångströms when fitting.
# But bohrs when CP2K calculates them. So that is why there are
# 0.52917721090 -terms in few places.


"""
GeneralPowers

General potential with customizable powers.

# Fields
- `constants::Vector{Float64}` : potential constants
- `powers::Vector{Int}`        : powers for radius
"""
mutable struct GeneralPowers <: AbstractPairPotential
    constants::Vector{Float64}
    powers::Vector{Int}
    GeneralPowers() = new([0.0, 0.0], [-6, -12])
    GeneralPowers(i...) = new(zeros(length(i)), collect(i))
    GeneralPowers(ur::UnitRange{Integer}) = new(zeros(length(ur)), collect(ur))
end


function Base.show(io::IO, potential::GeneralPowers; energy_unit="hartree")
    for (c,p) in zip(potential.constants, potential.powers)
        print(io, "r^$(p)  ")
    end
    print(io, " *** ")
    for (c,p) in zip(potential.constants, potential.powers)
        print(io, "$(c)  ")
    end
end


function potential_variables(potential::GeneralPowers,
                            cluster::AbstractCluster, indices)
    # Convert from Å to bohr
    r = distances(cluster, indices[1], indices[2]) ./ 0.52917721090
    return [r.^x for x in potential.powers]'
end


function get_potential!(potential::GeneralPowers, constants...)
    @assert length(constants) == length(potential.constants)  "length of constants with GeneralJones potential do not match"
    return potential.constants .= constants
end


function (p::GeneralPowers)(r::Number)::Float64
    y = 0.0
    rr = r/0.52917721090 # r is in Å and potential is in bohr
    for (a,b) in zip(p.constants, p.powers)
        y += a*rr^b
    end
    return y
end
