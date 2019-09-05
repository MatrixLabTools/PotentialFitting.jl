using Documenter
using PotentialFitting, PotentialCalculation
import Pkg; Pkg.add("ScikitLearn")

makedocs(sitename="PotentialFitting.jl",
         pages=["Home" => "index.md",
                "Usage" => "use.md"]

)

deploydocs(
    repo = "github.com/tjjarvinen/PotentialFitting.jl.git",
)
