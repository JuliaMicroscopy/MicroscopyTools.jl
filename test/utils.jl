@testset "Utils" begin

    @testset "Test soft_theta" begin 
        x = -1:0.1:1
        @test eltype(MicroscopyTools.soft_theta.(Float32.(x))) == Float32
        @test MicroscopyTools.soft_theta.(x, Ref(13.1)) ≈ 1 ./ (1 .+exp.(-2 .*13.1 .*x))
        @test MicroscopyTools.soft_theta_pw(0.01) == 1.0
        @test typeof(MicroscopyTools.soft_theta_pw(0.01f0)) == Float32
        @test MicroscopyTools.soft_theta_pw(-0.01) == 0.0
        @test MicroscopyTools.soft_theta_pw(-0.0) ≈ 0.5
        @test MicroscopyTools.soft_theta_pw(1/3.0, 1.0) ≈ 0.75
    end
    
    @testset "Test soft_delta" begin 
        
        T = Float64
        f(x, k) = one(T) / (k * √(T(π))) * exp(-abs2(x / k))

        x = -1:0.1:1
        @test eltype(MicroscopyTools.soft_delta.(Float32.(x))) == Float32
        @test MicroscopyTools.soft_delta.(x, Ref(13.1)) ≈ f.(x, 13.1) 


        @test typeof(MicroscopyTools.soft_delta_pw(0.01f0)) == Float32
        @test MicroscopyTools.soft_delta_pw(0.01f0) == 0.0
        @test MicroscopyTools.soft_delta_pw(-0.01) == 0.0
        @test MicroscopyTools.soft_delta_pw(-0.0) ≈ 1.0
        @test MicroscopyTools.soft_delta_pw(1/3.0, 1.0) ≈ 0.75
    end

end
