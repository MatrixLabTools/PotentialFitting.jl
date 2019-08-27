var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "#PoentialFitting.jl-1",
    "page": "Home",
    "title": "PotentialFitting.jl Documentation",
    "category": "section",
    "text": ""
},

{
    "location": "#Package-Features-1",
    "page": "Home",
    "title": "Package Features",
    "category": "section",
    "text": "Define new potentials easily\nFit potential using methods provided by ScikitLearn"
},

{
    "location": "#Functions-1",
    "page": "Home",
    "title": "Functions",
    "category": "section",
    "text": "CurrentModule = PotentialFitting"
},

{
    "location": "#PotentialFitting.visualize.min_distance-Tuple{MoleculePairPotential,Any}",
    "page": "Home",
    "title": "PotentialFitting.visualize.min_distance",
    "category": "method",
    "text": "min_distance(mpp::MoleculePairPotential, points)\n\nGives minimum distance of molecules in mpp on given points. Used to help plotting.\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.visualize.plot_compare-Tuple{Any,Any,Vararg{MoleculePairPotential,N} where N}",
    "page": "Home",
    "title": "PotentialFitting.visualize.plot_compare",
    "category": "method",
    "text": "plot_compare(points, energy, mpp::MoleculePairPotential...; emax=100, unit=\"cm^-1\",                       leg=false, size=(800,400), font=font(20))\n\nCompares fitted energy to calculated one.\n\nArguments\n\npoints  : array of Cluster where potential is plotted\nenergy  : calculated energy\nmpp::MoleculePairPotential...  : potentials to be fitted\nemax=100  : maximum energy in plot - cut all values with energy greater\nunit=\"cm^-1\"  : energy unit\nleg=false     : draw legend\nsize=(800,400)   : size of picture\nfont=font(20)    : font size\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.visualize.plot_potential-Tuple{Any,MoleculePairPotential}",
    "page": "Home",
    "title": "PotentialFitting.visualize.plot_potential",
    "category": "method",
    "text": "plot_potential(points, mpp::MoleculePairPotential; emax=100, unit=\"cm^-1\",                         leg=false, size=(800,400), font=font(20))\n\nPlots potential\n\nArguments\n\npoints  : array of Cluster where potential is plotted\nmpp::MoleculePairPotential  : potential\nemax=100  : maximum energy in plot - cut all values with energy greater\nunit=\"cm^-1\"  : energy unit\nleg=false     : draw legend\nsize=(800,400)   : size of picture\nfont=font(20)    : font size\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.visualize.scan_compare-Tuple{Any,Any,Vararg{Any,N} where N}",
    "page": "Home",
    "title": "PotentialFitting.visualize.scan_compare",
    "category": "method",
    "text": "scan_compare(points,energy, mppe...; emax=100, unit=\"cm^-1\",                       leg=false, fsize=(800,400))\n\nUse Interact to view potentials ineractively on different points.\n\nVisualization is done on collumn vise.\n\nArguments\n\npoints  : array of points, first dimension is displayd while second can be chosen\nenergy  : array of reference energy, first dimension is displayd while second can be chosen\nmppe... : MoleculePairPotential which are plotted\nemax=100  : maximum energy in plot - cut all values with energy greater\nunit=\"cm^-1\"  : energy unit\nleg=false     : draw legend\nsize=(800,400)   : size of picture\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.visualize.scan_vizualize-Tuple{Any}",
    "page": "Home",
    "title": "PotentialFitting.visualize.scan_vizualize",
    "category": "method",
    "text": "scan_vizualize(points; i=4)\n\nVisualize geometry of points interactively using Interact\n\nArguments\n\npoints  : array of points, first dimension is displayd while second can be chosen\ni=4     : row index at with visialization is done\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.visualize.visualize_point_bio3dview-Tuple{Cluster}",
    "page": "Home",
    "title": "PotentialFitting.visualize.visualize_point_bio3dview",
    "category": "method",
    "text": "visualizepointbio3dview(point::Cluster)\n\nVisualize point using Bio3DView. Can be used wit IJulia and on html\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.visualize.visualize_points-Tuple{Any}",
    "page": "Home",
    "title": "PotentialFitting.visualize.visualize_points",
    "category": "method",
    "text": "visualize_points(points; stdout=devnull, stderr=devnull, command=\"vmd\")\n\nVisualize using external program.\n\n\n\n\n\n"
},

{
    "location": "#Visualize-1",
    "page": "Home",
    "title": "Visualize",
    "category": "section",
    "text": "Modules = [PotentialFitting.visualize]\nOrder   = [:function, :type, :macro]"
},

{
    "location": "#PotentialFitting.fit.fit_potential!-Tuple{Any,MoleculePairPotential,FitData}",
    "page": "Home",
    "title": "PotentialFitting.fit.fit_potential!",
    "category": "method",
    "text": "fit_potential!(model, mpp::MoleculePairPotential, fdata::FitData)\n\nFits potential using given model\n\nArguments\n\nmodel                       : ScikitLearn model\nmpp::MoleculePairPotential  : potential\nfdata::FitData              : data used in fitting\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.fit.predict_potential-Tuple{Any,MoleculePairPotential,Any,Any}",
    "page": "Home",
    "title": "PotentialFitting.fit.predict_potential",
    "category": "method",
    "text": "predict_potential(model, mpp::MoleculePairPotential, cluster1, cluster2)\n\nUses model to predict potential on given cluster points\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.fit.predict_potential-Tuple{Any,MoleculePairPotential,Any}",
    "page": "Home",
    "title": "PotentialFitting.fit.predict_potential",
    "category": "method",
    "text": "predict_potential(model, mpp::MoleculePairPotential, points)\n\nUses model to predict potential on given points\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.fit.rmsd-Tuple{Any,Any,MoleculePairPotential}",
    "page": "Home",
    "title": "PotentialFitting.fit.rmsd",
    "category": "method",
    "text": "rmsd(points, energy, mpp::MoleculePairPotential; emax=0, unit=\"cm^-1\")\n\nCalculates root mean square error for potential mpp.\n\nAtributes\n\npoints                      : points where potential is tested\nenergy                      : referece energy for given points\nmpp::MoleculePairPotential  : potential\nemax=0                      : cut points where energy is larger than this\nunit=\"cm^-1\"                : unit for emax\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.fit.setweight_e_less!",
    "page": "Home",
    "title": "PotentialFitting.fit.setweight_e_less!",
    "category": "function",
    "text": "setweightemore!(data::FitData, w, e; unit=\"cm-1\")\n\nSets weigth when energy is more than given one.\n\nArguments\n\ndata::FitData  : data where weigth is adjusted\nw              : new weigth\ne              : energy\nunit=\"cm-1\"    : energy unit\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.fit.setweight_e_more!-Tuple{FitData,Any,Any}",
    "page": "Home",
    "title": "PotentialFitting.fit.setweight_e_more!",
    "category": "method",
    "text": "setweightemore!(data::FitData, w, e; unit=\"cm-1\")\n\nSets weigth when energy is more than given one.\n\nArguments\n\ndata::FitData  : data where weigth is adjusted\nw              : new weigth\ne              : energy\nunit=\"cm-1\"    : energy unit\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.fit.FitData",
    "page": "Home",
    "title": "PotentialFitting.fit.FitData",
    "category": "type",
    "text": "FitData\n\nStructure to help potential parameters fitting.\n\nFields\n\nvariables : variables\nE         : energy\nw         : weights\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.fit.give_as_potential-Tuple{Any,Any}",
    "page": "Home",
    "title": "PotentialFitting.fit.give_as_potential",
    "category": "method",
    "text": "giveaspotential(T, data)\n\nReturns MoleculePairPotential{T} from given data that must have \"c1_molecule\" and \"c2_molecule\" fields\n\n\n\n\n\n"
},

{
    "location": "#Fit-1",
    "page": "Home",
    "title": "Fit",
    "category": "section",
    "text": "Modules = [PotentialFitting.fit]\nOrder   = [:function, :type, :macro]"
},

{
    "location": "#PotentialFitting.potentials.calculate_potential-Tuple{Cluster,Cluster,Any,PairTopologyIndices}",
    "page": "Home",
    "title": "PotentialFitting.potentials.calculate_potential",
    "category": "method",
    "text": "calculate_potential(cluster1::Cluster, cluster2::Cluster,                            potential, indics::PairTopologyIndices)\n\nCalculates energy from given potential. Needs to be implemented for each potential.\n\nArguments\n\ncluster1::Cluster  : first molecule\ncluster2::Cluster  : second molecule\npotential          : potential\nindics::PairTopologyIndices   : indices for atoms that represent potential\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.calculate_potential-Tuple{MoleculePairPotential,Any}",
    "page": "Home",
    "title": "PotentialFitting.potentials.calculate_potential",
    "category": "method",
    "text": "calculate_potential(mpp::MoleculePairPotential, points)\n\nCalculates potential energy for given points. Returns them as an array of same size as points\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.calculate_potential-Tuple{MoleculePairPotential,Cluster,Cluster}",
    "page": "Home",
    "title": "PotentialFitting.potentials.calculate_potential",
    "category": "method",
    "text": "calculate_potential(mpp::MoleculePairPotential, cluster1::Cluster, cluster2::Cluster)\n\nCalculates potential energy\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.get_potential!-Tuple{Any,Any}",
    "page": "Home",
    "title": "PotentialFitting.potentials.get_potential!",
    "category": "method",
    "text": "get_potential!(potential, terms)\n\nFunction that sets potential term after potential has been fitted. That is this function transforms fitted term to potential terms. Needs to be implemented for each potential.\n\nArguments\n\npotential : used potential\nterms     : terms from fitting method\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.potential_variables-Tuple{MoleculePairPotential,Any,Any}",
    "page": "Home",
    "title": "PotentialFitting.potentials.potential_variables",
    "category": "method",
    "text": "potential_variables(mpp::MoleculePairPotential, cluster1, cluster2)\n\nUsed to transform cluster data to fittable form.\n\nArguments\n\nmpp::MoleculePairPotential : potential to be fitted\ncluster1 : array for clusters\ncluster2 : array for clusters\n\nReturns\n\nArray holding an array for each potential term in mpp.topology that can the be used for fitting.\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.potential_variables-Tuple{MoleculePairPotential,Any}",
    "page": "Home",
    "title": "PotentialFitting.potentials.potential_variables",
    "category": "method",
    "text": "potential_variables(mpp::MoleculePairPotential, points)\n\nUsed to transform cluster data to fittable form.\n\nArguments\n\nmpp::MoleculePairPotential : potential to be fitted\ncluster1 : array for clusters\n\nReturns\n\nArray holding an array for each potential term in mpp.topology that can the be used for fitting.\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.AbstractClusterPotential",
    "page": "Home",
    "title": "PotentialFitting.potentials.AbstractClusterPotential",
    "category": "type",
    "text": "AbstractClusterPotential <: AbstractPotential\n\nPotentials between groups of atoms\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.AbstractPairPotential",
    "page": "Home",
    "title": "PotentialFitting.potentials.AbstractPairPotential",
    "category": "type",
    "text": "AbstractPairPotential  <: AbstractPotential\n\nPotential that depends only on distance between two atoms\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.MoleculePairPotential",
    "page": "Home",
    "title": "PotentialFitting.potentials.MoleculePairPotential",
    "category": "type",
    "text": "MoleculePairPotential{T<:AbstractPairPotential} <: AbstractClusterPotential\n\nStructure to hold potential information between two molecules\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.PairPotentialTopology",
    "page": "Home",
    "title": "PotentialFitting.potentials.PairPotentialTopology",
    "category": "type",
    "text": "PairPotentialTopology{T}\n\nPotential topology for pair of molecules. Complite potential can be described by several on these structures.\n\nFields\n\npotential::T : potential\nindices::Vector{PairTopologyIndices}  : indices for atoms that have this potential\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.PairTopologyIndices",
    "page": "Home",
    "title": "PotentialFitting.potentials.PairTopologyIndices",
    "category": "type",
    "text": "PairTopologyIndices\n\nHold information of atom indices for potential calculations.\n\nFields\n\nfirst::Vector{Int64} : indices for first molecule\nsecond::Vector{Int64} : indices for second molecule\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.potentials.clusters_to_potential_variables-Tuple{Any,Cluster,Cluster,PairTopologyIndices}",
    "page": "Home",
    "title": "PotentialFitting.potentials.clusters_to_potential_variables",
    "category": "method",
    "text": "clusterstopotential_variables(potential, c1::Cluster, c2::Cluster, indeces::PairTopologyIndices)\n\nReturns data in a form that can be used to fit potential (linearly). That is as an array of terms. Example for Lennard Jones potential this is [r^-6 r^-12]. Needs to be implemented for each potential.\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.lennardjones.LJ",
    "page": "Home",
    "title": "PotentialFitting.lennardjones.LJ",
    "category": "type",
    "text": "LJ\n\nAcronym for LennardJones{Float64}\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.lennardjones.LennardJones",
    "page": "Home",
    "title": "PotentialFitting.lennardjones.LennardJones",
    "category": "type",
    "text": "LennardJones{T} <: AbstractPairPotential\n\nHolds constants for Lennard-Jones potential     E = C12/R^12 - C6/R^6\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.generalpowers.GeneralPowers",
    "page": "Home",
    "title": "PotentialFitting.generalpowers.GeneralPowers",
    "category": "type",
    "text": "GeneralPowers\n\nGeneral potential with customizable powers.\n\nFields\n\nconstants::Vector{Float64} : potential constants\npowers::Vector{Int}        : powers for radius\n\n\n\n\n\n"
},

{
    "location": "#PotentialFitting.generalpowers.@GeneralPowers-Tuple{Any,Vararg{Any,N} where N}",
    "page": "Home",
    "title": "PotentialFitting.generalpowers.@GeneralPowers",
    "category": "macro",
    "text": "@GeneralPowers(indices, i...)\n\nUsed to simplify potential generation. Generates GeneralPowers potential and topology for it.\n\nExamples\n\njulia> @GeneralPowers (1,1) -6 -12\nPairPotentialTopology{GeneralPowers}(C(-6)=0.0  C(-12)=0.0  , PairTopologyIndices[PairTopologyIndices([1], [1])])\n\n\n\n\n\n"
},

{
    "location": "#Potentials-1",
    "page": "Home",
    "title": "Potentials",
    "category": "section",
    "text": "Modules = [PotentialFitting.potentials, PotentialFitting.lennardjones, PotentialFitting.generalpowers]\nOrder   = [:function, :type, :macro]"
},

{
    "location": "use/#",
    "page": "Usage",
    "title": "Usage",
    "category": "page",
    "text": ""
},

{
    "location": "use/#Usage-1",
    "page": "Usage",
    "title": "Usage",
    "category": "section",
    "text": "To calculate potential energy surface refer to PotentialCalculation.Ones you have potential energy calculated you can open it for fitting by usingusing PotentialCalculation\nusing PotentialFitting\n\n# There is an example potential in test/data directory\nfname=normpath(joinpath(dirname(pathof(PotentialFitting)),\"../test\", \"data\", \"test.jld\"))\n\n# Load potential\ndata=load_data_file(fname)"
},

{
    "location": "use/#Setting-up-Molecules-1",
    "page": "Usage",
    "title": "Setting up Molecules",
    "category": "section",
    "text": "Next part in defining topology for the potential. This is started by creating two molecules. The information is in the loaded file.m1=MoleculeIdenticalInformation{AtomOnlySymbol}(data[\"cluster1\"].atoms)\nm2=MoleculeIdenticalInformation{AtomOnlySymbol}(data[\"cluster2\"].atoms)\n\nshow(m1) # hide\nshow(m2) # hideIf neede atoms can be flagged as identical.# Atoms 2 and 3 are identical\nmakeidentical!(m1, (2,3))"
},

{
    "location": "use/#Potential-Topology-1",
    "page": "Usage",
    "title": "Potential Topology",
    "category": "section",
    "text": "Next we need to define topology for the potential.mpp = MoleculePairPotential(m1,m2, LJ())"
},

{
    "location": "use/#Finetuning-Potential-1",
    "page": "Usage",
    "title": "Finetuning Potential",
    "category": "section",
    "text": "Alternatively potential can be tuned complitely by adding potentials one by one.# Array where topology is saved\ntopo=[]\n\n#We can push potential to to this array one at the time\npush!(topo,\n      PairPotentialTopology{LJ}(PairTopologyIndices(1,1))\n     )\nnothing # hideIf needed we can specify which atoms should be treated as identical, by adding information for it  in the topology.# Atoms 2 and 3 of molecule 1 have same potential to to atom 1 of molecule 2\npush!(topo,\n      PairPotentialTopology{LJ}([PairTopologyIndices(2,1), PairTopologyIndices(3,1)])\n     )\nnothing # hideIf default form of potential is not enough it can be tuned, by giving it as an input.push!(topo,\n      PairPotentialTopology{GeneralPowers}(GeneralPowers(-6,-12), PairTopologyIndices(4,1))\n     )\npush!(topo,\n     PairPotentialTopology{GeneralPowers}(GeneralPowers(-6,-8, -10, -12), PairTopologyIndices(4,1))\n    )\nnothing # hideHere we used general polynomial potential GeneralPowers to make customized polynomic potential.We can now create potential.mpp1=MoleculePairPotential(m1,m2)\nmpp1.topology = topo\n\nshow(mpp1)"
},

{
    "location": "use/#Preparing-Data-for-Fitting-1",
    "page": "Usage",
    "title": "Preparing Data for Fitting",
    "category": "section",
    "text": "To do fitting itself we need to prepare fit data.fdata = FitData(mpp, data[\"Points\"], data[\"Energy\"])\nnothing # hideAt this point we can add weights to data.# If energy is more than 1500 cm⁻¹ weigth is zero\nsetweight_e_more!(fdata, 0, 1500)\n\n# If energy is less than 80 cm⁻¹ weigth is 4\nsetweight_e_less!(fdata,4,80)\nnothing # hide"
},

{
    "location": "use/#Fitting-Potential-1",
    "page": "Usage",
    "title": "Fitting Potential",
    "category": "section",
    "text": "We also need to create fitting model. At the current moment only linear models can be used. Here we take normal linear regression, but any linear model suported by ScikitLearn can be used.import Pkg; Pkg.add(\"ScikitLearn\") # hide\nusing ScikitLearn\n@sk_import linear_model: LinearRegression\n\nmodel = LinearRegression()To do fitting itself.fit_potential!(model, mpp, fdata)"
},

{
    "location": "use/#Inspecting-Fitted-Potential-1",
    "page": "Usage",
    "title": "Inspecting Fitted Potential",
    "category": "section",
    "text": "You can inspect the fit by calculating RMSD.# Unit is hartrees\nrmsd(data[\"Points\"], data[\"Energy\"], mpp)Alternatively you can visualize the fit with various methods.plot_compare(data[\"Points\"][:,1], data[\"Energy\"][:,1], mpp, leg=true)For more visualizations take a look forplot_compare\nscan_compare\nscan_vizualize\nvisualize_points"
},

]}
