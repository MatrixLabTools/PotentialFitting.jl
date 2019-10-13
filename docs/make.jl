using Documenter
using PotentialFitting, PotentialCalculation

makedocs(sitename="PotentialFitting.jl",
         pages=["Home" => "index.md",
                "Usage" => "use.md",
                "Example use case" => "exampleusecase.md"]

)

deploydocs(
    repo = "github.com/MatrixLabTools/PotentialFitting.jl.git",
)
