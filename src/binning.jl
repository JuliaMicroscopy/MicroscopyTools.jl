export bin, bin2


"""
    bin(arr, binning)

Bins a `arr` by the factors given in `binning`.

For efficient 2 binning, see [`bin2`](@ref bin2).


# Examples
## Simple Usage
```jldoctest
julia> bin([1 2 3 4; 5 6 7 8], (2, 2))
1×2 Matrix{Int64}:
 14  22

julia> bin(ones((4, 4)), (2, 4))
2×1 Matrix{Float64}:
 8.0
 8.0

julia> bin([1,2,3,4,5], (2,))
2-element Vector{Int64}:
 3
 5
```

## You can leave out trailing 1s
```jldoctest
julia> bin(ones((2,2,2)), (2,))
1×2×2 Array{Float64, 3}:
[:, :, 1] =
 2.0  2.0

[:, :, 2] =
 2.0  2.0

julia> bin(ones((2,2,2)), (2,)) == bin(ones((2,2,2)), (2,1,1))
true
```
"""
function bin(arr::AbstractArray{T, N}, binning::NTuple{M, Int}) where {T, N, M}
    # an tuple indicating the binning in each dimnension
    # fill with 1s of binning only specifies a few dimensions
    binning = (binning..., ntuple(x -> 1, Val(N - M))...)  

    # output array
    # largest size which is possible according to binning
    out = similar(arr, size(arr) .÷ binning)

    out_indices = CartesianIndices(out) 
    z = zero(T)
    neighbours = CartesianIndices(binning)
    # iterate over the indices of the out put array
    #@inbounds and @simd make it faster
    @inbounds @simd for inds in out_indices
        # now we start to sum within binning
        s = z
        # sum all neighbours
        base_inds = binning .* Tuple(inds) .+ 1
        for neighbour in neighbours 
            pos = base_inds .- Tuple(neighbour) 
            s += arr[pos...]
        end
        # assign the sum
        out[inds] = s
    end
    return out
end


# was slightly slower with function barrier
# Function barrier.
# """
# function _bin_loop!(out::AbstractArray{T, N}, 
#                     arr::AbstractArray{T, N}, 
#                     binning::NTuple{N, Int}) where {T, N}
## end


"""
    bin2(arr)


Essentially calls `bin(arr, (2,2))`.
However, works only for `Union{AbstractArray{T, 2}, AbstractArray{T, 3}} where T`
since we use specialized methods of Tullio for that.

# Examples
```jldoctest
julia> x = [1 2 3 4; 5 6 7 8]
2×4 Matrix{Int64}:
 1  2  3  4
 5  6  7  8

julia> bin2(x)
1×2 Matrix{Int64}:
 14  22

julia> bin2(x) ≈ bin(x, (2,2))
true
```
"""
function bin2(arr::AbstractArray{T, 2}) where T
    @tullio out[i, j] := arr[2i, 2j] +  arr[2i - 1, 2j] + arr[2i - 1, 2j - 1] + arr[2i, 2j - 1]
end

function bin2(arr::AbstractArray{T, 3}) where T
    @tullio out[i, j, k] := arr[2i, 2j, k] +  arr[2i - 1, 2j, k] + arr[2i - 1, 2j - 1, k] + arr[2i, 2j - 1, k]
end
