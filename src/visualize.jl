module visualize

using ..potentials, ..fit
using ScikitLearn, Plots, Dates, PotentialCalculation, Statistics


export plot_calculated_by_index, plot_compare_by_index, points_from, write_to_xyz,
       visualize_points, visualize_data_points, vizualize_by_energy_diff




function plot_calculated(r,e; emax=100, unit="cm-1")
    et = energy_to.(e, unit)
    i = et .< emax
    plot(r[i], et[i],
         xlabel = "Min distance   [Å]",
         ylabel = "Energy   ["*unit*"]",
         label = "Calculated")
end


function plot_compare(r, ec, ep; emax=100, unit="cm-1", leg=false, size=(800,400), font=font(20))
    ect = energy_to.(ec,unit)
    ept = energy_to.(ep,unit)
    i = ect .< emax
    plot(r[i], ect[i], xlabel="Min Distance  [Å]", ylabel="Energy   [$unit]",  label="Calculated",
         leg=leg, size=size, tickfont=font, seriestype=:scatter)
    plot!(r[i], ept[i], label="Fit", tickfont=font)
end


function plot_calculated_by_index(r, e, i...; emax=100, unit="cm-1", scatter=true)
    rt = hcat(r[i...]...)'
    et = e[i...]
    if scatter
        plot_calculated(minimum(rt,dims=2), et, emax=emax, unit=unit,seriestype=:scatter)
    else
        plot_calculated(minimum(rt,dims=2), et, emax=emax, unit=unit)
    end
end


function plot_compare_by_index(model, mpp::MoleculePairPotential, r, e, i...;
                               emax=100, unit="cm-1", size=(800,400), font = font(20),
                               leg=false)
    rt = hcat(r[i...]...)'
    ec = e[i...]
    ep = predict_potential(model, mpp, rt)
    plot_compare(minimum(rt,dims=2), ec, ep, emax=emax, unit=unit, size=size, font=font, leg=leg)
end

function points_from(data, i...)
    if length(i) > 0
        tmp = data["points"][i...]
    else
        tmp = data["points"]
    end
    m = vcat(data["c1_molecule"].atoms..., data["c2_molecule"].atoms...)
    c = similar(tmp, Cluster{AtomOnlySymbol})
    for j in eachindex(tmp)
        c[j] = Cluster{AtomOnlySymbol}(tmp[j].xyz, m)
    end
    return c
end

function write_to_xyz(c ; id="vizualize-traj_", location="/tmp")
    fname = location * "/" * id * sprint(print, now()) * ".xyz"
    @info "Printing to file: $(fname)"
    open(fname, "w") do f
        for i in eachindex(c)
            print_xyz(f, c[i])
        end
    end
    return fname
end


function visualize_data_points(data, i... ; id="vizualize-traj_", location="/tmp",
                          delfile=true, command="vmd")
    p = points_from(data,i...)
    visualize_points(p)
end

function visualize_points(p;  id="vizualize-traj_", location="/tmp",
                              delfile=true, command="vmd")
    fname = write_to_xyz(p, id=id, location=location)
    run(`$(command) $(fname)`)
    if delfile
        run(`rm $(fname)`)
        @info "tmp file: \"$(fname)\" deleted"
    end
end


function vizualize_by_energy_diff(model,data, mpp::MoleculePairPotential, ediff;
                                  more=true, takeabs=true, elim=0.0, unit="cm-1")
    r = give_radius(data, true)
    e = give_energy(data, true)
    p = points_from(data, :)
    ep = predict_potential(model, mpp, r)
    i_tmp = e .< energy_from(elim, "cm-1")
    p = p[i_tmp]
    ed = e[i_tmp] .- ep[i_tmp]
    if takeabs
        ed = abs.(ed)
    end
    if more
        i = ed .> energy_from(ediff, "cm-1")
    else
        i = ed .< energy_from(ediff, "cm-1")
    end
    visualize_points(p[i])
    return std(ed)
end


end #module
