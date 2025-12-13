# MicroscopyTools.jl

A collection of performant tools suited for processing of Microscopy data such as 
- binning of gridded data by integer factors
- generation of scanning grids
- momentum projections (useful for blinking data)
- soft thresholding functions that are differentiable

Please check the documentation for currently available functionality.

Since such functions are useful in the context of other packages or scripts, they are
bundled up here.

| **Documentation**                       | **Build Status**                          | **Code Coverage**               |
|:---------------------------------------:|:-----------------------------------------:|:-------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][CI-img]][CI-url] | [![][codecov-img]][codecov-url] |


## Installation
The package is officially registered and can be installed with
```
julia> ]add MicroscopyTools
```




[docs-dev-img]: https://img.shields.io/badge/docs-dev-pink.svg
[docs-dev-url]: https://JuliaMicroscopy.github.io/MicroscopyTools.jl/dev/

[docs-stable-img]: https://img.shields.io/badge/docs-stable-darkgreen.svg
[docs-stable-url]:  https://JuliaMicroscopy.github.io/MicroscopyTools.jl/stable/

[CI-img]: https://github.com/JuliaMicroscopy/MicroscopyTools.jl/actions/workflows/ci.yml/badge.svg
[CI-url]: https://github.com/JuliaMicroscopy/MicroscopyTools.jl/actions/workflows/ci.yml

[codecov-img]: https://codecov.io/gh/JuliaMicroscopy/MicroscopyTools.jl/branch/main/graph/badge.svg?token=9CBLT9MAML
[codecov-url]: https://codecov.io/gh/JuliaMicroscopy/MicroscopyTools.jl
