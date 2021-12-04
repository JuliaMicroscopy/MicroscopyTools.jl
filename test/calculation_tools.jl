@testset "Calculation Tools" begin
    @testset "Test radial_mean" begin 
        a = rr((10,10)) .< 5.0
        (rm, ax) = MicroscopyTools.radial_mean(a)
        @test rm[1] ≈ 1.0
        @test rm[5] ≈ 1.0
        @test rm[6] ≈ 0.0
        @test ax[1] == 0.5
        @test ax[end] == 7.5
    end

    @testset "Δ_phase" begin 
        @test MicroscopyTools.Δ_phase([1,1im,-1,-1im,1], 1) ≈ -pi/2 .* ones(4)
    end


    @testset "moment projection" begin
        @test MicroscopyTools.moment_proj([1 3; 2 4], 2, pdims = (1,)) == [0.25 0.25] 
        @test MicroscopyTools.moment_proj_normed([1 3; 2 4], 2, pdims = (1,)) == [0.5 0.5]
    end
end
