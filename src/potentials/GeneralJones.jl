module generaljones

using ..potentials
using PotentialCalculation


export GeneralJones, @GeneralJones


"""
GeneralJones

General potential with customizable powers.

# Fields
- `constants::Vector{Float64}` : potential constants
- `powers::Vector{Int}`        : powers for radius
"""
mutable struct GeneralJones
    constants::Vector{Float64}
    powers::Vector{Int}
    GeneralJones() = new([0.0, 0.0], [-6, -12])
    GeneralJones(i...) = new(zeros(length(i)), collect(i))
    GeneralJones(ur::UnitRange{Integer}) = new(zeros(length(ur)), collect(ur))
end


function Base.show(io::IO, potential::GeneralJones; energy_unit="cm^-1")
    for (c,p) in zip(potential.constants, potential.powers)
        print(io, "C($(p))=$(c)  ")
    end
end

function potentials.calculate_potential(cluster1::Cluster, cluster2::Cluster,
                           potential::GeneralJones, indices::PairTopologyIndices)
    r = distances(cluster1, indices.first[1], cluster2, indices.second[1])

    rip = map(x->r^x, potential.powers)
    r6 = r^-6
    r12 = r6^2
    return sum( rip .* potential.constants )
end


function potentials.clusters_to_potential_variables(potential::GeneralJones,
                            c1::Cluster, c2::Cluster, indeces::PairTopologyIndices) where{T}
    r=distances(c1, indeces.first[1] , c2, indeces.second[1])
    return map(x->r^x, potential.powers)'
end


function potentials.get_potential!(potential::GeneralJones, constants...)
    @assert length(constants) == length(potential.constants)  "length of constants with GeneralJones potential do not match"
    potential.constants .= constants
end


"""
    @GeneralJones(indices, i...)

Used to simplify potential generation. Genrates [`GeneralJones`](@ref) potential
and topology for it.

# Examples
```jldoctest; setup = :(using PotentialFitting.generaljones, PotentialFitting.potentials )
julia> @GeneralJones (1,1) -6 -12
PairPotentialTopology{GeneralJones}(C(-6)=0.0  C(-12)=0.0  , PairTopologyIndices[PairTopologyIndices([1], [1])])
```
"""
macro GeneralJones(indices, i...)
    return :(PairPotentialTopology{GeneralJones}(GeneralJones($(i)...),PairTopologyIndices($(indices)...)))
end

end #module
