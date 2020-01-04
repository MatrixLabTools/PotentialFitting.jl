module visualize

using ..potentials, ..fit
using Plots, PotentialCalculation, Bio3DView, Interact


export min_distance,
       plot_potential,
       plot_compare,
       scan_compare,
       scan_vizualize,
       visualize_points,
       visualize_point_bio3dview


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
plot_potential(points, mpp::MoleculePairPotential; emax=100, unit="cm^-1",
                        leg=false, size=(800,400), font=font(20))

Plots potential

# Arguments
- `points`  : array of [`Cluster`](@ref) where potential is plotted
- `mpp::MoleculePairPotential`  : potential
- `emax=100`  : maximum energy in plot - cut all values with energy greater
- `unit="cm^-1"`  : energy unit
- `leg=false`     : draw legend
- `size=(800,400)`   : size of picture
- `font=font(20)`    : font size
"""
function plot_potential(points, mpp::MoleculePairPotential; emax=100, unit="cm^-1",
                        leg=false, size=(800,400), font=font(20))
    E = energy_to.(mpp.(points), unit)
    r = min_distance(mpp, points)
    i = E .< emax
    plot(r[i], E[i],
         xlabel = "Min distance   [Å]",
         ylabel = "Energy   ["*unit*"]",
         label = "Fitted", size=size, tickfont=font)
end


"""
plot_compare(points, energy, mpp::MoleculePairPotential...; emax=100, unit="cm^-1",
                      leg=false, size=(800,400), font=font(20))

Compares fitted energy to calculated one.

# Arguments
- `points`  : array of [`Cluster`](@ref) where potential is plotted
- `energy`  : calculated energy
- `mpp::MoleculePairPotential...`  : potentials to be fitted
- `emax=100`  : maximum energy in plot - cut all values with energy greater
- `unit="cm^-1"`  : energy unit
- `leg=false`     : draw legend
- `size=(800,400)`   : size of picture
- `font=font(20)`    : font size
"""
function plot_compare(points, energy, mpp::MoleculePairPotential...; emax=100, unit="cm^-1",
                      leg=false, size=(800,400), font=font(20))
    Ecal = energy_to.(energy, unit)
    r = min_distance(mpp[1], points)
    i = Ecal .< emax
    out=plot(r[i], Ecal[i], xlabel="Min Distance  [Å]", ylabel="Energy   [$unit]",  label="Calculated",
         leg=leg, size=size, tickfont=font, seriestype=:scatter)

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
visualize_point_bio3dview(point::Cluster)

Visualize point using [Bio3DView](https://github.com/jgreener64/Bio3DView.jl).
Can be used wit IJulia and on html
"""
function visualize_point_bio3dview(point::Cluster;  html=false)
    s=sprint(print_xyz,point)
    style= Style("sphere")
    viewstring(s,"xyz",style=style, html=html)
end


"""
scan_compare(points,energy, mppe...; emax=100, unit="cm^-1",
                      leg=false, fsize=(800,400))

Use [`Interact`](https://juliagizmos.github.io/Interact.jl/stable/) to view
potentials ineractively on different points.

Visualization is done on collumn vise.

# Arguments
- `points`  : array of points, first dimension is displayd while second can be chosen
- `energy`  : array of reference energy, first dimension is displayd while second can be chosen
- `mppe...` : [`MoleculePairPotential`](@ref) which are plotted
- `emax=100`  : maximum energy in plot - cut all values with energy greater
- `unit="cm^-1"`  : energy unit
- `leg=false`     : draw legend
- `size=(800,400)`   : size of picture
"""
function scan_compare(points,energy, mppe...; emax=100, unit="cm^-1",
                      leg=false, fsize=(800,400))
    @assert size(points) == size(energy) "points and energy need to have same size"
    e = energy_from(emax,unit)
    s=size(points)
    units = Observable(["cm^-1", "kcal/mol", "kJ/mol", "eV", "K", "hartree"])
    wdg = dropdown(units, label="Energy unit")
    display(wdg)

    plt = @manipulate for col in slider(1:s[2], label="Collumn")
        plot_compare(points[:,col],energy[:,col], mppe..., emax=energy_to(e,wdg[]), unit=wdg[], leg=leg, size=fsize)
    end
    plt
end


"""
scan_vizualize(points; i=4)

Visualize geometry of points interactively using [`Interact`](https://juliagizmos.github.io/Interact.jl/stable/)


# Arguments
- `points`  : array of points, first dimension is displayd while second can be chosen for index manipulation
- `i=4`     : row index at with visialization is done
"""
function scan_vizualize(points; i=4)
    s = size(points)
    plt = @manipulate for col in slider(1:s[2], label="Collumn")
        if length(points[:,col]) >= i
            visualize_point_bio3dview(points[i,col])
        else
            visualize_point_bio3dview(points[1,col])
        end
    end
    plt
end

end #module
