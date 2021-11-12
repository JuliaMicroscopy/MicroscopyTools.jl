using BenchmarkTools, MicroscopyTools

function main()

    x = randn((3097, 113, 32))
    @warn "random data with size $(size(x))"
    @btime bin2($x)
    @btime bin($x, (2,2))

    
    @warn "random data with size $(size(x))"
    x = randn((3097, 1113))
    @btime bin2($x)
    @btime bin($x, (2,2))
end

main()
