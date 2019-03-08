module visualize

using ..potentials, ..fit
using Plots, PotentialCalculation, Bio3DView


export min_distance,
       plot_potential,
       plot_compare,
       visualize_points,
       visualize_point_bio3dview


"""
min_distance(mpp::MoleculePairPotential, points)

Gives minimum distance of molecules in `mpp` on given points
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
    E = energy_to.(calculate_potential(mpp, points), unit)
    r = min_distance(mpp, points)
    i = E .< emax
    plot(r[i], E[i],
         xlabel = "Min distance   [Å]",
         ylabel = "Energy   ["*unit*"]",
         label = "Fitted")
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
        Efit = energy_to.(calculate_potential(x, points), unit)
        plot!(r[i], Efit[i], label="Fit", tickfont=font)
    end
    out
end

"""
visualize_points(points; stdout=devnull, stderr=devnull, command="vmd")

Visualize using external program.

# Arguments
- `points`  : array of [`Cluster`](@ref) where potential is plotted

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

Visualize point using bio3dview.
Can be used wit IJulia and on html
"""
function visualize_point_bio3dview(point::Cluster)
    s=sprint(print_xyz,point)
    style= Style("sphere")
    viewstring(s,"xyz",style=style)
end

end #module
