module generalpowers

using ..potentials
using PotentialCalculation


export GeneralPowers, @GeneralPowers


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

function potentials.calculate_potential(potential::GeneralPowers, cluster::AbstractCluster, indices)
    # Convert from Å to bohr
    r = distances(cluster, indices[1], indices[2]) ./ 0.52917721090
    return potential(r)
end


function potentials.potential_variables(potential::GeneralPowers,
                            cluster::AbstractCluster, indices)
    # Convert from Å to bohr
    r= distances(cluster, indices[1], indices[2]) ./ 0.52917721090
    return [r.^x for x in potential.powers]'
end


function potentials.get_potential!(potential::GeneralPowers, constants...)
    @assert length(constants) == length(potential.constants)  "length of constants with GeneralJones potential do not match"
    potential.constants .= constants
end


"""
    @GeneralPowers(indices, i...)

Used to simplify potential generation. Generates [`GeneralPowers`](@ref) potential
and topology for it.

# Examples
```jldoctest; setup = :(using PotentialFitting.generalpowers, PotentialFitting.potentials )
julia> @GeneralPowers (1,1) -6 -12
PairPotentialTopology{GeneralPowers}(C(-6)=0.0  C(-12)=0.0  , PairTopologyIndices[PairTopologyIndices([1], [1])])
```
"""
macro GeneralPowers(indices, i...)
    return :(PairPotentialTopology{GeneralPowers}(GeneralPowers($(i)...),PairTopologyIndices($(indices)...)))
end


(p::GeneralPowers)(r) = sum([a.*r.^b for (a,b) in zip(p.constants, p.powers) ])


end #module
