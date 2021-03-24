

abstract type AbstractPotential end

"""
    AbstractClusterPotential <: AbstractPotential

Potentials between groups of atoms
"""
abstract type AbstractClusterPotential <: AbstractPotential end

"""
    AbstractPairPotential  <: AbstractPotential

Potential that depends only on distance between two atoms
"""
abstract type AbstractPairPotential  <: AbstractPotential end




abstract type AbstractPotentialTopology end

abstract type AbstractPairPotentialTopology{T<:AbstractPairPotential} <: AbstractPotentialTopology end

abstract type AbstractClusterPotentialTopology{T<:AbstractClusterPotential} <: AbstractPotentialTopology end


"""
PairPotentialTopology{T} <: AbstractPairPotentialTopology{T}

Container that maps a pair potential to respective atoms.

# Fields
- `indices::Vector{Tuple{Int, Int}}`: Stores information of atom pair(s) between which the potentilal exist
- `potential::T`: Potential structure
"""
struct PairPotentialTopology{T} <: AbstractPairPotentialTopology{T}
    potential::T
    indices::Vector{Tuple{Int, Int}}
    PairPotentialTopology(p::T, i, j) where T<:AbstractPairPotential = new{T}(p, [(i,j)])
    PairPotentialTopology(p::T, indices::AbstractVector{Tuple{Int, Int}} ) where T<:AbstractPairPotential = new{T}(p, indices )
end


"""
(p::PairPotentialTopology)(r)

Returns potential for given distance.
"""
(p::PairPotentialTopology)(r) = p.potential(r)


"""
(p::PairPotentialTopology)(c::AbstractCluster)

Returns potential for given cluster.
"""
function (p::PairPotentialTopology)(c::AbstractCluster)
    sum( [ p(distances(c, i, j)) for (i,j) in p.indices ] )
end


"""
(p::PairPotentialTopology)(c1::AbstractCluster, c2::AbstractCluster)

Returns potential for given cluster pair. Index for atom 2 is expected to be in cluster `c2`.
"""
function (p::PairPotentialTopology)(c1::AbstractCluster, c2::AbstractCluster)
    sum([p(distances(c1, j, c2, j)) for (i,j) in p.indeces ])
end



"""
ClusterPotentialTopology{T} <: AbstractClusterPotentialTopology{T}

Container that maps a cluster potential to respective atoms.

# Fields
- `potential::T`:
- `indices::Vector{Vector{Int}}`: Stores information of atoms between which the potentilal exist
"""
struct ClusterPotentialTopology{T} <: AbstractClusterPotentialTopology{T}
    potential::T
    indices::Vector{Vector{Int}}
    function ClusterPotentialTopology(p::T,i...) where T<:AbstractClusterPotential
        new{T}(p, [collect(i)] )
    end
    function ClusterPotentialTopology(p::T,i::AbstractMatrix) where T<:AbstractClusterPotential
        new{T}(p,[x for x in eachcol(i)])
    end
end


function (p::ClusterPotentialTopology)(c::AbstractCluster)
    sum(calculate_potential(p.potential, c, i) for i in p.indices)
end


"""
calculate_potential(potential::AbstractPotential, cluster::AbstractCluster, indices)

Calculates energy from given potential.
**Needs to be implemented for each potential.**

# Arguments
- `potential::AbstractPairPotential`  : potential
- `cluster::AbstractCluster`          : molecule cluster
- `indices`                           : indices for atoms that represent potential
"""
function calculate_potential(potential::AbstractPairPotential, cluster::AbstractCluster, indices)
    r = distances(cluster, indices[1], indices[2])
    return potential(r)
end


"""
    get_potential!(potential, terms)

Function that sets potential term after potential has been fitted.
That is this function transforms fitted term to potential terms.
**Needs to be implemented for each potential.**

# Arguments
- `potential` : used potential
- `terms`     : terms from fitting method
"""
function get_potential!(potential::AbstractPotential, terms)
    error("get_potential! not implemented for $(typof(potential))")
end


"""
    MoleculePairPotential{T<:AbstractPairPotential} <: AbstractClusterPotential

Structure to hold potential information between two molecules
"""
mutable struct MoleculePairPotential
    "Molecule 1"
    mol1::MoleculeIdenticalInformation{AtomOnlySymbol}
    "Molecule 2"
    mol2::MoleculeIdenticalInformation{AtomOnlySymbol}
    "Holds potential (index 1) and indexes for atoms (index 2)"
    topology::Vector{AbstractPotentialTopology}
    function MoleculePairPotential(mol1::AbstractMolecule,mol2::AbstractMolecule, potential::AbstractPotential)
        topology = Vector{PairPotentialTopology}()
        l = length(mol1)
        for i1 in mol1.identical.identical
            for i2 in mol2.identical.identical
                push!(topology, PairPotentialTopology(deepcopy(potential),[(i,l+j) for i in i1 for j in i2 ]) )
            end
        end
        @debug "mol1" mol1.identical.identical
        new(mol1, mol2, topology )
    end
    function MoleculePairPotential(mol1::AbstractMolecule,mol2::AbstractMolecule)
        new(mol1, mol2, Vector{AbstractPotentialTopology}())
    end
end


(mpp::MoleculePairPotential)(c::AbstractCluster) = sum( [t(c) for t in mpp.topology] )
(mpp::MoleculePairPotential)(c1::AbstractCluster, c2::AbstractCluster) = mpp(c1+c2)


function Base.show(io::IO, mpp::MoleculePairPotential; energy_unit="cm^-1")
    println(io, "Molecule Pair Potential")
    println(io, "Molecule 1 has $(length(mpp.mol1)) atoms ($(length(mpp.mol1.identical.identical)) unique) ")
    println(io, "Molecule 2 has $(length(mpp.mol2)) atoms ($(length(mpp.mol2.identical.identical)) unique) \n")
    println(io, "Potential topology:\n")
    m=MoleculeIdenticalInformation{AtomOnlySymbol}(vcat(mpp.mol1.atoms,mpp.mol2.atoms))
    for x in mpp.topology
        for y in x.indices
            show(io, x.potential, energy_unit=energy_unit)
            for z in y
                print(io, " :  ", z, m.atoms[z].id)
            end
            print(io,"\n")
        end
    end
end



"""
potential_variables(mpp::MoleculePairPotential, points)

Used to transform cluster data to fittable form.

# Arguments
- `mpp::MoleculePairPotential` : potential to be fitted
- `points` : array for clusters


# Returns
Array holding an array for each potential term in `mpp.topology` that can the be used for fitting.
"""
function potential_variables(mpp::MoleculePairPotential, points)
    out =[]
    for x in mpp.topology
        tmp=[]
        for y in x.indices
            push!(tmp,vcat(map(z->  potential_variables(x.potential, z, y), points)...) )
        end
        push!(out,+(tmp...))
    end
    return out
end
