using BenchmarkTools, MicroscopyTools

function bin_3(arr::AbstractArray{T, N}, factors=ntuple(x -> 2, Val(N))) where {T, N}
    # old size
    sz = size(arr)
    # new size
    sn = sz .÷ factors
    s2 = ntuple(i -> isodd(i) ? factors[(i+1)/2] : sn[i/2], Val(2 * N)) 

    dims = ntuple(i -> 2 * i - 1, Val(N))
    reshape(sum(reshape(arr,s2),dims=dims),sn)
end


function f(x)
    @info "Random data with size $(size(x))"
    print("Tullio: ")
    @btime bin2($x)
    print("CartesianIndices: ")
    @btime bin($x, (2,2))
    print("RH: ")
    @btime bin_3($x, (2,2))
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
