using MicroscopyTools, Documenter 

 # set seed fixed for documentation
DocMeta.setdocmeta!(MicroscopyTools, :DocTestSetup, :(using MicroscopyTools); recursive=true)
makedocs(modules = [MicroscopyTools], 
         sitename = "MicroscopyTools.jl", 
         pages = Any[
            "MicroscopyTools.jl" => "index.md",
            "Binning" => "binning.md",
            "Calculation Tools" => "calculation_tools.md",
            "Grid Generation" => "grid_generation.md",
         ]
        )

deploydocs(
    repo = "git@github.com:JuliaMicroscopy/MicroscopyTools.jl.git",
    branch = "gh-pages",
    devbranch = "main",
    target = "build",
    deploy_config = Documenter.GitHubActions(),
)
