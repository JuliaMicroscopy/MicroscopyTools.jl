using BenchmarkTools, MicroscopyTools

function f(x)
    @info "Random data with size $(size(x))"
    print("Tullio: ")
    @btime bin2($x)
    print("CartesianIndices: ")
    @btime bin($x, (2,2))
end

function main()
    @info "Binning by (2,2)"
    x = randn(Float32, (256, 512))
    f(x)

    x = randn(Float32, (8192, 7113))
    f(x)

    x = randn((97, 32))
    f(x)

    x = randn((3097, 113, 32))
    f(x)
    
    x = randn((23, 31, 8))
    f(x)

    x = randn(Float32, (3097, 4096, 32))
    f(x)
    
    return 
end

main()
