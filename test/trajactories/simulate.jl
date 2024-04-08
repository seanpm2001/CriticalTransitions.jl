@testset "fitzhugh_nagumo" begin
    p = [1.0, 3.0, 1.0, 1.0, 1.0, 0.0] # Parameters (ϵ, β, α, γ, κ, I)
    σ = 0.18 # noise strength

    # StochSystem
    sys = StochSystem(fitzhugh_nagumo, p, zeros(2), σ)

    # Calculate fixed points
    ds = CoupledODEs(sys)
    box = intervals_to_box([-2, -2], [2, 2])
    eqs, eigs, stab = fixedpoints(ds, box)

    # Store the two stable fixed points
    fp1, fp2 = eqs[stab]
    @test fp1 == - fp2

    # can it run test
    sim = simulate(sys, fp1, dt = 0.01, tmax = 1e3)
end # @testset "Tutorial"