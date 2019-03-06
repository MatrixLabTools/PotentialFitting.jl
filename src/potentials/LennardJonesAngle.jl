module lennardjonesangle

using ..potentials
using PotentialCalculation

export LennardJonesAngle,
       LJA

mutable struct LennardJonesAngle{T} <: AbstractPairPotential
    C6:: T
    C6a:: T
    C12:: T
    C12a:: T
    LennardJonesAngle{T}() where {T} = new(0.0, 0.0, 0.0, 0.0)
    LennardJonesAngle{T}(c6,c12) where {T} = new(c6, 0.0, c12, 0.0)
    LennardJonesAngle{T}(c6, c6a, c12, c12a) where{T} = new(c6, c6a, c12, c12a)
end

LJA = LennardJonesAngle{Float64}

function Base.show(io::IO, potential::LennardJonesAngle; energy_unit="cm^-1")
    if potential.C6 > 0 && potential.C12 > 0 && false
        ϵ = energy_to(potential.C6^2/(4*potential.C12), energy_unit)
        σ = (potential.C12/potential.C6)^(1/6)
        print(io, "$(typeof(potential)),  ϵ=$(ϵ) $(energy_unit), σ=$(σ) Å")
    else
        print(io, "$(typeof(potential)),  C6=$(potential.C6)+$(potential.C6a)*cosθ, C12=$(potential.C12)+$(potential.C12a)*cosθ")
    end
end

function potentials.calculate_potential(cluster1::Cluster, cluster2::Cluster,
                           potential::LennardJonesAngle, indices::PairTopologyIndices)
    r = distances(cluster1, indices.first[1], cluster2, indices.second[1])
    θ = cluster_angle(cluster1, indices.first[1], indices.first[2], cluster2, indices.second[1])
    r6 = r^-6
    r12 = r6^2
    return (potential.C12 + cos(θ)*potential.C12a )*r12 - (potential.C6 + cos(θ)*potential.C6a)*r6
end

function potentials.clusters_to_potential_variables(ptype::Union{Type{LennardJonesAngle{T}}, Type{LennardJonesAngle}},
                            c1::Cluster, c2::Cluster, indices::PairTopologyIndices) where{T}
    r=distances(c1, indices.first[1] ,c2, indices.second[1])
    θ = cluster_angle(c1, indices.first[1], indices.first[2], c2, indices.second[1])
    r6 = r^-6
    r12 = r6^2
    return [r6 cos(θ)*r6  r12 cos(θ)*r12]
end


function potentials.get_potential!(potential::LennardJonesAngle, x6, x6a, x12, x12a)
    potential.C6 = -x6
    potential.C6a = -x6a
    potential.C12 = x12
    potential.C12a = x12a
    potential
end


end  # module lennardjonesangle
