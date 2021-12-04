@testset "Grid generation" begin
    
    @testset "Regular pattern" begin

        @test collect(MicroscopyTools.regular_pattern((4, 4), offset = -1, step = 2)) == [(-1, -1) (-1, 1); (1, -1) (1, 1)]

        @test collect(MicroscopyTools.regular_pattern((4, 4), step = 2)) == [(1, 1) (1, 3); (3, 1) (3, 3)]

        @test collect(MicroscopyTools.regular_pattern((3, 3))) == [(1, 1) (1, 2) (1, 3); (2, 1) (2, 2) (2, 3); (3, 1) (3, 2) (3, 3)]

    end

end
