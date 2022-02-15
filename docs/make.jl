using MicroscopyTools, Documenter 

 # set seed fixed for documentation
DocMeta.setdocmeta!(MicroscopyTools, :DocTestSetup, :(using MicroscopyTools); recursive=true)
makedocs(modules = [MicroscopyTools], 
         sitename = "MicroscopyTools.jl", 
         pages = Any[
            "MicroscopyTools.jl" => "index.md",
            "Binning" => "binning.md",
         ]
        )

deploydocs(repo = "github.com/JuliaMicroscopy/MicroscopyTools.jl.git", devbranch="main")
