using Documenter
using PotentialFitting, PotentialCalculation, ScikitLearn

makedocs(sitename="PotentialFitting.jl",
         pages=["Home" => "index.md",
                "Usage" => "use.md"]

)

deploydocs(
    repo = "github.com/MatrixLabTools/PotentialFitting.jl.git",
)
