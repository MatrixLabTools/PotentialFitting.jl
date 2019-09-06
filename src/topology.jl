module topology

using ..potentials
using PotentialCalculation

export AbstractTopology,
       AbstractPairTopology,
       AbstractClusterTopology,
       AbstractPotentialTopology,
       PairTopology,
       MultiPairTopology,
       ClusterToplogy,
       PotentialTopology

abstract type AbstractTopology end
abstract type AbstractPairTopology <: AbstractTopology end
abstract type AbstractClusterTopology <: AbstractTopology end

abstract type AbstractPotentialTopology end

struct PairTopology <: AbstractPairTopology
    ind::Tuple{Int, Int}
    PairTopology(i,j) = new((i,j))
    PairTopology(x) = new(x)
end

mutable struct MultiPairTopology <: AbstractPairTopology
    ind::Vector{Tuple{PairTopology}}
    MultiPairTopology() = new([])
    function MultiPairTopology(pt)
        new([])
    end
end

mutable struct ClusterTopology <: AbstractClusterTopology
    ind::Vector{Int}
end

mutable struct PotentialTopology <: AbstractPotentialTopology
    topology::Vector{Tuple{AbstractTopology,AbstractPotential}}
    PotentialTopology() = new([])
end

Base.show(io::IO, p::PairTopology) = print(io, "PairTopology ", length(p), " pairs")
Base.show(io::IO, p::ClusterTopology) = print(io, "PairTopology ", length(p), " pairs")

Base.length(t::PairTopology) = length(p.ind)
Base.length(t::ClusterTopology) = length(p.ind)
Base.length(t::PotentialTopology) = length(p.topology)

Base.getindex(p::AbstractTopology, i) = p.ind[:,i]
Base.getindex(p::PairTopology, i) = p.ind[i]
Base.getindex(p::PotentialTopology, i) = p.topology[i]

Base.setindex!(p::AbstractTopology, x, i) = p.ind[:,i] = x
Base.setindex!(p::PairTopology, x, i) = p.ind[i] = x
Base.setindex!(p::PotentialTopology, x, i) = p.topology[i] = x

function Base.push!(p::PairTopology, x::Tuple{Int, Int})
    push!(p.ind, x)
    p
end

function Base.push!(p::PotentialTopology, x::Tuple{AbstractTopology, AbstractPotential})
    push!(p.topology, x)
    p
end

(p::PairTopology)(rc::AbstractMatrix) = [ rc[:,j] .- rc[:,i] for (i,j) in p.ind]
(p::PairTopology)(c::AbstractCluster) = p(c.xyz)

end #module
