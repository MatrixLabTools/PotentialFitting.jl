module lennardjones

using ..potentials
using PotentialCalculation


export LennardJones,
       LJ



mutable struct LennardJones{T} <: AbstractPairPotential
    C6::T
    C12::T
    LennardJones{T}() where{T} = new(0.0,0.0)
    LennardJones{T}(c6,c12) where{T} = new(c6,c12)
end

LJ = LennardJones{Float64}


function Base.show(io::IO, potential::LennardJones; energy_unit="cm^-1")
    if potential.C6 > 0 && potential.C12 > 0
        ϵ = energy_to(potential.C6^2/(4*potential.C12), energy_unit)
        σ = (potential.C12/potential.C6)^(1/6)
        print(io, "$(typeof(potential)),  ϵ=$(ϵ) $(energy_unit), σ=$(σ) Å")
    else
        print(io, "$(typeof(potential)),  C6=$(potential.C6), C12=$(potential.C12)")
    end
end


function potentials.calculate_potential(cluster1::Cluster, cluster2::Cluster,
                           potential::LennardJones, indices::PairTopologyIndices)
    r = distances(cluster1, indices.first[1], cluster2, indices.second[1])
    r6 = r^-6
    r12 = r6^2
    return potential.C12*r12 - potential.C6*r6
end


function potentials.clusters_to_potential_variables(ptype::Union{Type{LennardJones{T}}, Type{LennardJones}},
                            c1::Cluster, c2::Cluster, indeces::PairTopologyIndices) where{T}
    r=distances(c1, indeces.first[1] , c2, indeces.second[1])
    return [r^-6 r^-12]
end

function potentials.get_potential!(potential::LennardJones, x6, x12)
    potential.C6 = -x6
    potential.C12 = x12
    potential
end


end #module
