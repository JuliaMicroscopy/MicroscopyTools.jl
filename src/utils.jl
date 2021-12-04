"""
    soft_theta(val, eps=0.1) = (val .> eps) ? 1.0 : ((val .< -eps) ? 0.0 : (1.0 .- cos((val .+ eps).*(pi/(2*eps))))./2) # to make the threshold differentiable

this is a version of the theta function that uses a soft transition and is differentialble.

Arguments:
+ val: value to compare with zero
+ eps: hardness of the step function (spanning from -eps to eps)
"""
soft_theta(val, eps=0.01) = (val .> eps) ? 1.0 : ((val .< -eps) ? 0.0 : (1.0 .- cos.((val .+ eps).*(pi/(2*eps))))./2.0) # to make the threshold differentiable

"""
    soft_delta(val, eps=0.1) = (val .> eps) ? 1.0 : ((val .< -eps) ? 0.0 : (1.0 .- cos((val .+ eps).*(pi/(2*eps))))./2) # to make the threshold differentiable

this is a smooth version of the theta function that uses a soft peak and is differentialble.
The sum is not normalized but the value at val is one.

Arguments:
val: value to compare with zero
eps: hardness of the step function (spanning from -eps to eps)
"""
soft_delta(val, eps=0.01) = (abs2.(val) .> abs2.(eps)) ? 0.0 : (1.0 .+ cos.(val.*(pi/eps)))./2.0 # to make the threshold differentiable

"""
    exp_decay(t,τ, eps=0.1) 

an exponential decay starting at zero and using a soft threshold.
Note that this function can be applied to multiple decay times τ simulataneously, yielding multiple decays stacked along the second dimension
"""
exp_decay(t,τ, eps=0.01) = soft_theta.(t,eps) .* exp.( - (t ./ transpose(τ)))


"""
    multi_exp_decay(t,amps, τs, eps=0.1) 

a sum of exponential decays starting at t==zero and using a soft threshold.

Arguments:
+ t: time series to apply this to
+ amps: individual amplitudes as a vector
+ τs : individual lifetimes as a vector
+ eps: width of the soft edge
"""
multi_exp_decay(t, amps, τs, eps=0.01) = sum(transpose(amps).*exp_decay(t, τs, eps), dims=2)[:,1] 








"""
    pack(myTuple::Tuple, do_fit)

This packs a tuple of values into a vector which is normalized per direction and returns an unpack function which reverts this.
This tool is useful for fit routines.

returns the packed tuples (with a position being true in do_fit) as a vector and the unpack algorithm as a closure.
"""
function pack(myTuple::Tuple, do_fit; rel_scale=nothing, dtype=Float64)
    scales = []
    vec = dtype[]
    lengths = Int[]
    for (t,f) in zip(myTuple,do_fit)
        if !isnothing(rel_scale)
            scale = sum(t)/length(t) .* rel_scale
        else
            scale = 1.0
        end
        if f
            push!(scales, scale)
            vec = cat(vec, t ./ scale, dims=1)
            push!(lengths, length(t))
        else # save the constant
            push!(scales, t)
            push!(lengths, length(t))
        end
    end

    function unpack(vec)
        res = ()
        pos = 1
        for (l,s,f) in zip(lengths,scales, do_fit)
            if f
                vals = vec[pos:pos+l-1] .* s
                pos += l
            else
                vals = s
            end
            res = (res..., vals)
        end
        return res
    end
    
    return Vector{dtype}(vec), unpack # Vector{Int}(lengths), Vector{Float64}(scales) 
end



