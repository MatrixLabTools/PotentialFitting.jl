module visualize

using ..potentials, ..fit
using Plots, PotentialCalculation


export min_distance,
       plot_potential,
       plot_compare,
       visualize_points



function min_distance(mpp::MoleculePairPotential, points)
    l1 = length(mpp.mol1)
    l2 = length(mpp.mol2)
    return map(x-> minimum(distances(x[1:l1],x[l1+1:l1+l2])), points)
end


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

end #module
