module potentials

export AbstractPotential, AbstractClusterPotential, AbstractPairPotential,
       LennardJones, MoleculePairPotential, index_transformation, r_to_potential,
       add_identicals, get_potential, print_potential

using PotentialCalculation

abstract type AbstractPotential end
abstract type AbstractClusterPotential <: AbstractPotential end
abstract type AbstractPairPotential  <: AbstractPotential end

mutable struct LennardJones <: AbstractPairPotential
    C6::Float64
    C12::Float64
    LennardJones() = new(0.0,0.0)
    LennardJones(c6,c12) = new(c6,c12)
end

#Number of parameters - not used atm
Base.length(t::Type{LennardJones}) = 2
Base.length(l::LennardJones) = 2


mutable struct Buckingham <: AbstractPairPotential
    A::Float64
    B::Float64
    C::Float64
    Buckingham() = new(0.0, 0.0, 0.0)
    Buckingham(A,B,C) = new(A,B,C)
end


function readable_potential(p::LennardJones)
    ϵ = energy_to(p.C6^2/(4*p.C12), "cm-1")
    σ = (p.C12/p.C6)^(1/6)
    return "ϵ=$(ϵ), σ=$(σ)"
end

function safe_readable_potential(p::LennardJones)
    return "C6=$(p.C6), C12=$(p.C12)"
end

mutable struct MoleculePairPotential{T<:AbstractPairPotential} <: AbstractClusterPotential
    mol1::MoleculeIdenticalInformation{AtomOnlySymbol}
    mol2::MoleculeIdenticalInformation{AtomOnlySymbol}
    potential::Array{T,2}
    function MoleculePairPotential{T}(mol1::AbstractMolecule,mol2::AbstractMolecule) where T<:AbstractPairPotential
        tmp = T()
        new(mol1,mol2,fill(tmp,(length(mol1),length(mol2))))
    end
end


function print_potential(io::IO, mpp::MoleculePairPotential{T}, opt=1) where {T}
    if opt == 1
        pot = safe_readable_potential.(mpp.potential)
    else
        pot = readable_potential.(mpp.potential)
    end
    println(io, "Molecule Pair Potential {$(T)}")
    println(io, "Molecule 1 has $(length(mpp.mol1)) atoms")
    println(io, "Molecule 2 has $(length(mpp.mol2)) atoms")
    println(io, "Potential parameters are:")
    for x in 1:size(pot)[1]
        for y in 1:size(pot)[2]
            print(io, pot[x,y], "  ")
            print(io, mpp.mol1.atoms[x].id, " - ")
            print(io, mpp.mol2.atoms[y].id, "   indexes")
            print(io, "($(x), $(y))" , "\n")
        end
        #print(io, "\n")
    end
end

function Base.show(io::IO, mpp::MoleculePairPotential{T}) where {T}
    print_potential(io, mpp)
end

#Update for different potentials
function r_to_potential(ptype::Type{LennardJones}, r)
    return [r.^-6,r.^-12]
end

function e_to_potential(ptype::Type{LennardJones}, e)
    return e
end


function r_to_potential(ptype::Type{Buckingham}, r)
    return [r, log.(r)]
end


function e_to_potential(ptype::Type{Buckingham}, e)
    return log.(e)
end

function index_transformation(mpp::MoleculePairPotential)
    l1 = length(mpp.mol1)
    l2 = length(mpp.mol2)
    li = l1 * l2
    lj = length(mpp.mol1.identical.identical) * length(mpp.mol2.identical.identical)
    vi = [ 0 for x in 1:li ]
    vj = [Set{Int}() for x in 1:lj ]

    n = 1
    for s in mpp.mol2.identical.identical
        for s1 in mpp.mol1.identical.identical
            s2 = l1 .* s .- l1
            tmp = [ s1 .+ x for x in s2  ]
            union!(vj[n], tmp...)
            n += 1
        end
    end

    for i in 1:lj
        for x in vj[i]
            vi[x] = i
        end
    end
    return Dict("forward" => vj, "backward" => vi  )
end

#Used to add potential terms for identical atoms
#id should be form index_transformation "forward"
#r has potental terms that need to be combined
function add_identicals(r, id)
    s = size(r)
    l = length(id)
    out = zeros((s[1],l))
    for i in 1:l
        for j in id[i]
            out[:,i] += r[:,j]
        end
    end
    return out
end

#This need to be made for every potental
function get_potential(ptype::Type{LennardJones}, a, b)
    lh = Int(length(a)/2)
    C6 =  -1 .* a[1:lh]
    C12 = a[lh+1:end]
    return LennardJones.(C6,C12)
end

end #module
