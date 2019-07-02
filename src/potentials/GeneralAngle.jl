module generalangle

using ..potentials
using PotentialCalculation

export GeneralAngle


"""
GeneralAngle <: AbstractPairPotential

General potential with customizable powers for both radial polynomials and cosθ.

# Fields
- `constants::Array{Float64,2}` : constants
- `ppowers::Vector{Int}`        : powers for radial polynomials
- `cpowers::Vector{Int}`        : powers for cosθ

To create potential use:
```julia
GeneralAngle(ppowers::AbstractVector{Int}, cpowers::AbstractVector{Int})
```
"""
mutable struct GeneralAngle <: AbstractPairPotential
    constants::Array{Float64,2}
    "Powers for radial polynomials"
    ppowers::Vector{Int}
    "Powers for cosθ"
    cpowers::Vector{Int}
    function GeneralAngle(ppowers::AbstractVector{Int}, cpowers::AbstractVector{Int})
        new(zeros(length(cpowers), length(ppowers)), ppowers, cpowers)
    end
end


function Base.show(io::IO, potential::GeneralAngle; energy_unit="cm^-1")
    print(io, "GeneralAngle constants: ",potential.constants)
end


function potentials.calculate_potential(cluster1::Cluster, cluster2::Cluster,
                           potential::GeneralAngle, indices::PairTopologyIndices)
    # Convert from Å to bohr
    r = distances(cluster1, indices.first[1], cluster2, indices.second[1]) ./ 0.52917721090
    if length(indices.first) > length(indices.second)
        θ = cluster_angle(cluster1, indices.first[2], indices.first[1], cluster2, indices.second[1])
    else
        θ = cluster_angle(cluster2, indices.second[2], indices.second[1], cluster1, indices.first[1])
    end
    rr = r.^potential.ppowers
    cθ = cos(θ).^potential.cpowers
    out = 0.0
    for i in 1:length(rr)
        out += sum(potential.constants[:,i] .* cθ * rr[i])
    end
    return out
end


function potentials.clusters_to_potential_variables(potential::GeneralAngle,
                            c1::Cluster, c2::Cluster, indices::PairTopologyIndices)
    # Convert from Å to bohr
    r = distances(c1, indices.first[1], c2, indices.second[1]) ./ 0.52917721090
    if length(indices.first) > length(indices.second)
        θ = cluster_angle(c1, indices.first[2], indices.first[1], c2, indices.second[1])
    else
        θ = cluster_angle(c2, indices.second[2], indices.second[1], c1, indices.first[1])
    end
    rr = r.^potential.ppowers
    cθ = cos(θ).^potential.cpowers
    out = [  x .* cθ for x in rr ]
    return vcat(out...)'
end

function potentials.get_potential!(potential::GeneralAngle, constants...)
    @assert length(constants) == length(potential.constants)
    for i in eachindex(constants)
        potential.constants[i] = constants[i]
    end
end

end  # module generalangle.jl
