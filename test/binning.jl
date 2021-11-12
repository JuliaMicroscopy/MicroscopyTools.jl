
@testset "Binning" begin
    @test bin([1 2 3 4; 5 6 7 8], (2, 2)) == [14 22]
    @test bin(ones((4, 4)), (2, 4)) ≈ [8.0; 8.0]
    @test bin([1, 2, 3, 4, 5], (2,)) == [3, 7]
    @test bin(ones((2, 2, 2)), (2,)) ≈ ones((1, 2,2)) .* 2 
    @test bin(ones((2, 2, 2)), (2,)) == bin(ones((2, 2, 2)), (2, 1, 1))



    x = randn(Float32, (11, 4, 5))
    r2 = bin(x, (1, 3, 2)) 
    @tullio r[i,j,k] := x[i, 3j, 2k] + x[i, 3j-1, 2k] + x[i, 3j-2, 2k] + x[i, 3j, 2k-1] + x[i, 3j-1, 2k-1] + x[i, 3j-2, 2k-1] 

    @test typeof(r2) == typeof(r)


    x_3D = randn((11, 10, 3))
    @test MicroscopyTools.bin2(x_3D) ≈ bin(x_3D, (2,2))
    x_2D = randn((11, 10))
    @test MicroscopyTools.bin2(x_2D) ≈ bin(x_2D, (2,2))


    x = [1 2 3 4; 5 6 7 8]
    @test bin2(x) ≈ bin(x, (2,2))
end
