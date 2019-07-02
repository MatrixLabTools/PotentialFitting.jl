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
    "text": "min_distance(mpp::MoleculePairPotential, points)\n\nGives minimum distance of molecules in mpp on given points\n\n\n\n\n\n"
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
    "location": "#PotentialFitting.visualize.visualize_point_bio3dview-Tuple{PotentialCalculation.clusters.Cluster}",
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
    "location": "#Potentials-1",
    "page": "Home",
    "title": "Potentials",
    "category": "section",
    "text": "Modules = [PotentialFitting.potentials, PotentialFitting.generaljones]\nOrder   = [:function, :type, :macro]"
},

]}
