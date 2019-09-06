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

function potentials.calculate_potential(cluster1::Cluster, cluster2::Cluster,
                           potential::GeneralPowers, indices::PairTopologyIndices)
    # Convert from Å to bohr
    r = distances(cluster1, indices.first[1], cluster2, indices.second[1]) ./ 0.52917721090

    rip = map(x->r^x, potential.powers)
    return sum( rip .* potential.constants )
end


function potentials.clusters_to_potential_variables(potential::GeneralPowers,
                            c1::Cluster, c2::Cluster, indeces::PairTopologyIndices) where{T}
    # Convert from Å to bohr
    r= distances(c1, indeces.first[1] , c2, indeces.second[1]) ./ 0.52917721090
    return map(x->r^x, potential.powers)'
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
