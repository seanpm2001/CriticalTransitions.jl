# CriticalTransitions.jl

[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://juliadynamics.github.io/CriticalTransitions.jl/dev/)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://juliadynamics.github.io/CriticalTransitions.jl/stable/)
[![Tests](https://github.com/JuliaDynamics/CriticalTransitions.jl/actions/workflows/ci.yml/badge.svg)](github.com/JuliaDynamics/CriticalTransitions.jl/actions/workflows/ci.yml)

[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![JET](https://img.shields.io/badge/%E2%9C%88%EF%B8%8F%20tested%20with%20-%20JET.jl%20-%20red)](https://github.com/aviatesk/JET.jl)


A Julia package for the numerical investigation of **noise- and rate-induced transitions in dynamical systems**.

Building on [DynamicalSystems.jl](https://juliadynamics.github.io/DynamicalSystems.jl/stable/) and [DifferentialEquations.jl](https://diffeq.sciml.ai/stable/), this package aims to provide a toolbox for dynamical systems under time-dependent forcing, with a focus on tipping phenomena and metastability.
## Usage
See [package documentation](https://juliadynamics.github.io/CriticalTransitions.jl/stable/).

## Example: Bistable FitzHugh-Nagumo model
```julia
using CriticalTransitions

function fitzhugh_nagumo(u, p, t)
    x, y = u
    ϵ, β, α, γ, κ, I = p

    dx = (-α * x^3 + γ * x - κ * y + I) / ϵ
    dy = -β * y + x

    return SA[dx, dy]
end

# System parameters
p = [1., 3., 1., 1., 1., 0.]
noise_strength = 0.02

# Define stochastic system
sys = CoupledSDEs(fitzhugh_nagumo, id_func, zeros(2), p, noise_strength)

# Get stable fixed points
fps, eigs, stab = fixedpoints(sys, [-2,-2], [2,2])
fp1, fp2 = fps[stab]

# Generate noise-induced transition from one fixed point to the other
path, times, success = transition(sys, fp1, fp2)

# ... and more, check out the documentation!
```

---

Developers: Reyk Börner, Ryan Deeley, Raphael Römer and Orjan Ameye

Thanks to Jeroen Wouters, Calvin Nesbitt, Tobias Grafke, George Datseris and Oliver Mehling

This work is part of the [CriticalEarth](https://www.criticalearth.eu) project.
