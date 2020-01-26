using Documenter
using PotentialFitting, PotentialCalculation

makedocs(sitename="PotentialFitting.jl",
         pages=["Home" => "index.md",
                "Manual" => Any[
                    "Fitting Potential" => "use.md",
                    "Example Use Case" => "exampleusecase.md",

                ],
                "Reference" => "reference.md"
         ]

)

deploydocs(
    repo = "github.com/MatrixLabTools/PotentialFitting.jl.git",
)
