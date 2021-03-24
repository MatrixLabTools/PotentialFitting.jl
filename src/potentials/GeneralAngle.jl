
# NOTE distance in potentials is ångströms when fitting.
# But bohrs when CP2K calculates them. So that is why there is
# 0.52917721090 -terms in few places.


"""
GeneralAngle <: AbstractClusterPotential

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
mutable struct GeneralAngle <: AbstractClusterPotential
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


function potential_variables(potential::GeneralAngle,
                            cluster::AbstractCluster, indices)
    # Convert from Å to bohr
    r = distances(cluster, indices[1], indices[2]) ./ 0.52917721090
    θ = cluster_angle(cluster, indices[1], indices[2], indices[3])
    rr = r.^potential.ppowers
    cθ = cos(θ).^potential.cpowers
    out = [  x .* cθ for x in rr ]
    return vcat(out...)'
end

function get_potential!(potential::GeneralAngle, constants...)
    @assert length(constants) == length(potential.constants)
    for i in eachindex(constants)
        potential.constants[i] = constants[i]
    end
end

function (p::GeneralAngle)(r::Number,α::Number)
    c = cos.(α)
    cp = c.^p.cpowers
    rp = (r./0.52917721090).^p.ppowers
    sum(p.constants .* (cp * rp'))
end
