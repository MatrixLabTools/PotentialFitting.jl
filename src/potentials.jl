module potentials

export AbstractPotential,
       AbstractClusterPotential,
       AbstractPairPotential,
       calculate_potential,
       get_potential!,
       MoleculePairPotential,
       PairPotentialTopology,
       PairTopologyIndices,
       potential_variables,
       PotentialTopology

using PotentialCalculation




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



"""
PairTopologyIndices

Hold information of atom indices for potential calculations.

# Fields
- `first::Vector{Int64}` : indices for first molecule
- `second::Vector{Int64}` : indices for second molecule
"""
struct PairTopologyIndices
    first::Vector{Int64}
    second::Vector{Int64}
    PairTopologyIndices(first::AbstractVector{Int64}, second::AbstractVector{Int64}) =  new(first, second)
    PairTopologyIndices(first, second) =  new(collect(first), collect(second))
    PairTopologyIndices(first::Integer, second::Integer) = new(Int64[first], Int64[second])
    PairTopologyIndices(first, second::Integer) = new(collect(first), Int64[second])
    PairTopologyIndices(first::Integer, second) = new(Int64[first], collect(second))
end

"""
PairPotentialTopology{T}

Potential topology for pair of molecules.
Complite potential can be described by several on these structures.

# Fields
- `potential::T` : potential
- `indices::Vector{PairTopologyIndices}`  : indices for atoms that have this potential
"""
mutable struct PairPotentialTopology{T}
    potential::T
    indices::Vector{PairTopologyIndices}
    PairPotentialTopology{T}(potential::T, ind::PairTopologyIndices) where {T} = new(potential,  [ind])
    PairPotentialTopology{T}(potential::T, ind::AbstractVector{PairTopologyIndices}) where {T} = new(potential,  ind)
    PairPotentialTopology{T}(ind::PairTopologyIndices) where {T} = new(T(),  [ind])
    PairPotentialTopology{T}(ind::AbstractVector{PairTopologyIndices}) where {T} = new(T(),  ind)
end



"""
calculate_potential(cluster1::Cluster, cluster2::Cluster,
                           potential, indics::PairTopologyIndices)

Calculates energy from given potential.
**Needs to be implemented for each potential.**

# Arguments
- `cluster1::Cluster`  : first molecule
- `cluster2::Cluster`  : second molecule
- `potential`          : potential
- `indics::PairTopologyIndices`   : indices for atoms that represent potential
"""
function calculate_potential(cluster1::Cluster, cluster2::Cluster,
                           potential, indics::PairTopologyIndices)
    error("calculate_potential has not been defined for type $(typeof(potential))")
end


"""
clusters_to_potential_variables(potential, c1::Cluster, c2::Cluster, indeces::PairTopologyIndices)

Returns data in a form that can be used to fit potential (linearly).
That is as an array of terms. Example for Lennard Jones potential this is `[r^-6 r^-12]`.
**Needs to be implemented for each potential.**
"""
function clusters_to_potential_variables(potential, c1::Cluster, c2::Cluster, indeces::PairTopologyIndices)
    error("clusters_to_potential_variables has not been defined for ptype = $(ptype)")
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
function get_potential!(potential, terms)
    error("get_potential! not implemented for $(typof(potential))")
end


"""
    MoleculePairPotential{T<:AbstractPairPotential} <: AbstractClusterPotential

Structure to hold potential information between two molecules
"""
mutable struct MoleculePairPotential <: AbstractClusterPotential
    "Molecule 1"
    mol1#::MoleculeIdenticalInformation{AtomOnlySymbol}
    "Molecule 2"
    mol2#::MoleculeIdenticalInformation{AtomOnlySymbol}
    "Holds potentila (index 1) and indexes for atoms (index 2)"
    topology::Vector{PairPotentialTopology}
    function MoleculePairPotential(mol1::AbstractMolecule,mol2::AbstractMolecule, potType)
        topology = Vector{PairPotentialTopology}()
        for i1 in mol1.identical.identical
            for i2 in mol2.identical.identical
                push!(topology, PairPotentialTopology{potType}([PairTopologyIndices(i,j) for i in i1 for j in i2 ]) )
            end
        end
        @debug "mol1" mol1.identical.identical
        new(mol1, mol2, topology  )
    end
    function MoleculePairPotential(mol1::AbstractMolecule,mol2::AbstractMolecule)
        new(mol1, mol2, Vector{PairPotentialTopology}[])
    end
end


function Base.show(io::IO, mpp::MoleculePairPotential; energy_unit="cm^-1")
    println(io, "Molecule Pair Potential")
    println(io, "Molecule 1 has $(length(mpp.mol1)) atoms ($(length(mpp.mol1.identical.identical)) unique) ")
    println(io, "Molecule 2 has $(length(mpp.mol2)) atoms ($(length(mpp.mol2.identical.identical)) unique) \n")
    println(io, "Potential topology:\n")
    for x in mpp.topology
        for y in x.indices
            show(io, x.potential, energy_unit=energy_unit)
            print(io, " :  ", y.first, " - ", y.second, " : ")
            for f in y.first
                print(io, mpp.mol1.atoms[f].id, " ")
            end
            print(io, "- ")
            for s in y.second
                print(io, mpp.mol2.atoms[s].id, " ")
            end
            print(io,"\n")
        end
    end
end


"""
calculate_potential(mpp::MoleculePairPotential, cluster1::Cluster, cluster2::Cluster)

Calculates potential energy
"""
function calculate_potential(mpp::MoleculePairPotential, cluster1::Cluster, cluster2::Cluster)
    out = 0.0
    for t in mpp.topology
        out += sum(map(x-> calculate_potential(cluster1, cluster2, t.potential, x), t.indices))
    end
    return out
end

"""
calculate_potential(mpp::MoleculePairPotential, points)

Calculates potential energy for given points. Returns them as an array of same size as points
"""
function calculate_potential(mpp::MoleculePairPotential, points)
    l1 = length(mpp.mol1)
    l2 = length(mpp.mol2)
    c1 = map(x->x[1:l1],  points)
    c2 = map(x->x[l1+1:l1+l2],  points)
    return map(x->calculate_potential(mpp,x[1:l1],x[l1+1:l1+l2]), points)
end

"""
potential_variables(mpp::MoleculePairPotential, cluster1, cluster2)

Used to transform cluster data to fittable form.

# Arguments
- `mpp::MoleculePairPotential` : potential to be fitted
- `cluster1` : array for clusters
- `cluster2` : array for clusters

# Returns
Array holding an array for each potential term in `mpp.topology` that can the be used for fitting.
"""
function potential_variables(mpp::MoleculePairPotential, cluster1, cluster2)
    @assert size(cluster1) == size(cluster2)
    out =[]
    for x in mpp.topology
    tmp=[]
        for y in x.indices
            push!(tmp,vcat(map(z->  clusters_to_potential_variables(x.potential, z[1], z[2], y), zip(cluster1,cluster2))...) )
        end
    push!(out,+(tmp...))
    end
    return out
end

"""
potential_variables(mpp::MoleculePairPotential, points)

Used to transform cluster data to fittable form.

# Arguments
- `mpp::MoleculePairPotential` : potential to be fitted
- `cluster1` : array for clusters


# Returns
Array holding an array for each potential term in `mpp.topology` that can the be used for fitting.
"""
function potential_variables(mpp::MoleculePairPotential, points)
    l1=length(mpp.mol1)
    l2=length(mpp.mol2)
    c1 = map(x->x[1:l1], points)
    c2 = map(x->x[l1+1:l1+l2], points)
    return potential_variables(mpp,c1,c2)
end


end #module
