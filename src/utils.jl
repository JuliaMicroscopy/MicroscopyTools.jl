export soft_delta, soft_delta_pw, soft_theta, soft_theta_pw

"""
    soft_theta(x::T, k=T(1)) where T

This is a version of the theta function that uses a soft transition and is differentiable.
It is implemented as `1 / (1+exp(-2 * k * x))`.
A larger `k` makes the edge harder.
"""
function soft_theta(x::T, k=1) where T
    one(T) / (one(T) + exp(-T(2)*k*x)) 
end

"""
    soft_theta_pw(x::T, ϵ=T(0.01)) where T

A different version of the soft theta. Uses a `cos` instead of `exp` functions.
Furthermore, is piecewise defined.
A smaller `e` makes the edge harder.
"""
function soft_theta_pw(x::T, ϵ=T(0.01)) where T
    if x .> ϵ
        one(T) 
    elseif x .< -ϵ
        zero(T) 
    else
        (one(T) - cos((x + ϵ) * (T(π) / (T(2)*ϵ)))) / T(2) 
    end
end


"""
    soft_delta(x::T, k=T(1)) where T

This is a smooth version of the delta function that uses a soft peak and is differentiable.
Based on a Gauss function.
A larger `k` makes the edge harder.
"""
function soft_delta(x::T, k=T(1)) where T
    one(T) / (k * √(T(π))) * exp(-abs2(x / k))
end


"""
    soft_delta_pw(x::T, ϵ=T(1)) where T

This is a smooth version of the delta function that uses a soft peak and is differentiable.
Based on a Gauss function.
A larger `k` makes the edge harder.
"""
function soft_delta_pw(x::T, ϵ=T(0.01)) where T
    if abs(x) > abs(ϵ)
        zero(T)
    else
        (one(T) + cos(x * (T(π) / ϵ))) / 2
    end
end
