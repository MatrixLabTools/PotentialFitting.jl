using Documenter
using PotentialFitting

makedocs(sitename="PotentialFitting.jl",
         pages=["Home" => "index.md"]

)

deploydocs(
    repo = "github.com/tjjarvinen/PotentialFitting.jl.git",
)
