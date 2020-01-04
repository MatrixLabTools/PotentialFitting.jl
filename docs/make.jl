using Documenter
using PotentialFitting, PotentialCalculation

makedocs(sitename="PotentialFitting.jl",
         pages=["Home" => "index.md",
                "Fitting Potential" => "use.md",
                "Example use case" => "exampleusecase.md"]

)

deploydocs(
    repo = "github.com/MatrixLabTools/PotentialFitting.jl.git",
)
