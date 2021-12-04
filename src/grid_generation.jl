"""
    regular_pattern(sz; offset=0, step=1)

Returns a generator with tuples that point to a regular grid pattern.

 ### Arguments:
+ `sz`: size of the underlaying array for which to generate the regular pattern
+ `offset`: offset of the first position. Can be tuple or scalar.
+ `step`: step between the indices. Can be tuple or scalar.


 ## Examples
```jldoctest
julia> MicroscopyTools.regular_pattern((3,3))
Base.Generator{CartesianIndices{2, Tuple{Base.OneTo{Int64}, Base.OneTo{Int64}}}, MicroscopyTools.var"#46#47"{Int64, Int64}}(MicroscopyTools.var"#46#47"{Int64, Int64}(1, 1), CartesianIndex{2}[CartesianIndex(1, 1) CartesianIndex(1, 2) CartesianIndex(1, 3); CartesianIndex(2, 1) CartesianIndex(2, 2) CartesianIndex(2, 3); CartesianIndex(3, 1) CartesianIndex(3, 2) CartesianIndex(3, 3)])

julia> collect(MicroscopyTools.regular_pattern((3,3)))
3×3 Matrix{Tuple{Int64, Int64}}:
 (1, 1)  (1, 2)  (1, 3)
 (2, 1)  (2, 2)  (2, 3)
 (3, 1)  (3, 2)  (3, 3)

julia> collect(MicroscopyTools.regular_pattern((3,3), step=2))
2×2 Matrix{Tuple{Int64, Int64}}:
 (1, 1)  (1, 3)
 (3, 1)  (3, 3)

julia> collect(MicroscopyTools.regular_pattern((3,3), step=2, offset=-1))
2×2 Matrix{Tuple{Int64, Int64}}:
 (-1, -1)  (-1, 1)
 (1, -1)   (1, 1)
```
"""
function regular_pattern(sz; offset=1, step=1) # zero-based
    return (offset .+step.*(Tuple(pos).-1) 
            for pos in CartesianIndices(1 .+ (((sz.-1)) .÷ step)))
end



"""
    get_scan_pattern([T=Float64,] sz, pitch=1, step=1; flatten_scan_dims=false)

Generates a scan pattern in N dimensions based on scanning an array of size `sz`
with a scan pitch of `pitch` and stepping by `step`.
The result is an array with `2*length(sz)` dimensions.
Note that the scan needs to be commensurate, implying that `pitch` is an integer multiple of `step`.
"""
function get_scan_pattern(dtype::DataType, sz, pitch=1, step=1; flatten_scan_dims=false)
    if any(pitch .% step .!= 0)
        error("Scan pitch needs to be commensurate with scan step")
    end

    sz = Tuple(sz)
    pitch = Tuple(step)
    step = Tuple(step)

    scan_sz = pitch .÷ step;
    res = zeros(dtype, (sz..., scan_sz...))
    for scan_pos in regular_pattern(scan_sz)
        for pos in regular_pattern(sz, step=step.*scan_pos, offset=pitch)
            res[pos..., scan_pos...] = one(dtype)
        end
    end
    if flatten_scan_dims
        return flatten_trailing_dims(res, length(sz)+1);
    else
        return res
    end
end

function get_scan_pattern(sz, pitch=1, step=1; flatten_scan_dims=false)
    MicroscopyTools.get_scan_pattern(Float64, sz, pitch, step, 
                                     flatten_scan_dims=flatten_scan_dims)
end
