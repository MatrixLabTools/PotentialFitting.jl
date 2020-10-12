
using Interact,
      Plots,
      PotentialCalculation


"""
    min_distance(mpp::MoleculePairPotential, points)

Gives minimum distance of molecules in `mpp` on given points.
Used to help plotting.
"""
function min_distance(mpp::MoleculePairPotential, points)
    l1 = length(mpp.mol1)
    l2 = length(mpp.mol2)
    return map(x-> minimum(distances(x[1:l1],x[l1+1:l1+l2])), points)
end

"""
    min_distance(points, c1::AbstractCluster, c2::AbstractCluster)

Minimum without needing fitted potential.
"""
function min_distance(points, c1::AbstractCluster, c2::AbstractCluster)
    l1 = length(c1)
    l2 = length(c2)
    return map(x-> minimum(distances(x[1:l1],x[l1+1:l1+l2])), points)
end


"""
    plot_potential(points, mpp::MoleculePairPotential; emax=100, unit="cm^-1",
                        leg=false, figsize=(800,400), font=font(20))

Plots potential

# Arguments
- `points`  : array of [`Cluster`](@ref) where potential is plotted
- `mpp::MoleculePairPotential`  : potential

# Keywords
- `emax=100`  : maximum energy in plot - cut all values with energy greater
- `unit="cm^-1"`        : energy unit
- `leg=false`           : draw legend
- `figsize=(800,400)`   : size of picture
- `font=font(20)`       : font size
"""
function plot_potential(points, mpp::MoleculePairPotential; emax=100, unit="cm^-1",
                        leg=false, figsize=(800,400), font=font(20))
    E = energy_to.(mpp.(points), unit)
    r = min_distance(mpp, points)
    i = E .< emax
    plot(r[i], E[i],
         xlabel = "Min distance   [Å]",
         ylabel = "Energy   ["*unit*"]",
         label = "Fitted", size=figsize, tickfont=font)
end

"""
    plot_potential(pes::Dict; emax=100, unit="cm^-1", figsize=(800,400), font=font(20))

Plots calculated potential

# Arguments
- `pes::Dict`     : PES in Dict from that can be get with `load_data_file` command

# Keywords
- `emax=100`      : maximum energy in plot - cut all values with energy greater
- `unit="cm^-1"`        : energy unit
- `figsize=(800,400)`   : size of picture
- `font=font(20)`       : font size
"""
function plot_potential(pes::Dict; emax=100, unit="cm^-1", figsize=(800,400), font=font(20))
    @assert haskey(pes, "Energy")
    @assert haskey(pes, "Points")
    @assert haskey(pes, "cluster1")
    @assert haskey(pes, "cluster2")
    E = energy_to.(pes["Energy"], unit)
    r = min_distance(pes["Points"], pes["cluster1"], pes["cluster2"])
    s = size(E, 2)
    plt = @manipulate for col in slider(1:s, label="Collumn")
        i = E[:,col] .< emax
        plot(r[:,col][i], E[:,col][i];
              size=figsize,
              font=font,
              leg=false,
              seriestype=:scatter,
              xlabel = "Min distance   [Å]",
              ylabel = "Energy   [$unit]")
    end
    plt
end


"""
    plot_compare(points, energy, mpp::MoleculePairPotential...; emax=100, unit="cm^-1",
                      leg=false, size=(800,400), font=font(20))

Compares fitted energy to calculated one.

# Arguments
- `points`  : array of [`Cluster`](@ref) where potential is plotted
- `energy`  : calculated energy
- `mpp::MoleculePairPotential...`  : potentials to be fitted

# Keywords
- `emax=100`  : maximum energy in plot - cut all values with energy greater
- `unit="cm^-1"`  : energy unit
- `leg=false`     : draw legend
- `size=(800,400)`   : size of picture
- `font=font(20)`    : font size
"""
function plot_compare(points, energy, mpp::MoleculePairPotential...; emax=100, unit="cm^-1",
                      leg=false, figsize=(800,400), font=font(20))
    Ecal = energy_to.(energy, unit)
    r = min_distance(mpp[1], points)
    i = Ecal .< emax
    out=plot(r[i], Ecal[i], xlabel="Min Distance  [Å]", ylabel="Energy   [$unit]",  label="Calculated",
         leg=leg, size=figsize, tickfont=font, seriestype=:scatter)

    for x in mpp
        Efit = energy_to.(x.(points), unit)
        plot!(r[i], Efit[i], label="Fit", tickfont=font)
    end
    out
end


"""
visualize_points(points; stdout=devnull, stderr=devnull, command="vmd")

Visualize using external program.
"""
function visualize_points(points; stdout=devnull, stderr=devnull, command="vmd")
    fname = tempname()*".xyz"
    open(fname,"w+") do f
        for x in points
            print_xyz(f, x)
        end
    end
    run(pipeline(`$(command) $(fname)`, stdout=stdout, stderr=stderr))
    rm(fname)
end


"""
scan_compare(points,energy, mppe...; emax=100, unit="cm^-1",
                      leg=false, figsize=(800,400))

Use [`Interact`](https://juliagizmos.github.io/Interact.jl/stable/) to view
potentials ineractively on different points.

Visualization is done on collumn vise.

# Arguments
- `points`  : array of points, first dimension is displayd while second can be chosen
- `energy`  : array of reference energy, first dimension is displayd while second can be chosen
- `mppe...` : [`MoleculePairPotential`](@ref) which are plotted

# Keywords
- `emax=100`  : maximum energy in plot - cut all values with energy greater
- `unit="cm^-1"`  : energy unit
- `leg=false`     : draw legend
- `figsize=(800,400)`   : size of picture
"""
function scan_compare(points,energy, mppe...; emax=100, unit="cm^-1",
                      leg=false, figsize=(800,400))
    @assert size(points) == size(energy) "points and energy need to have same size"
    e = energy_from(emax,unit)
    s=size(points)
    units = Observable(["cm^-1", "kcal/mol", "kJ/mol", "eV", "K", "hartree"])
    wdg = dropdown(units, label="Energy unit")
    display(wdg)

    plt = @manipulate for x in wdg, col in slider(1:s[2], label="Collumn")
        plot_compare(points[:,col],energy[:,col], mppe..., emax=energy_to(e,x), unit=x, leg=leg, size=figsize)
    end
    plt
end
