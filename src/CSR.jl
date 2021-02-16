#=
TP3:
- Julia version: 1.5.3
- Author: Nicolas
- Date: 2021-02-16
=#

import Pkg

Pkg.add("LinearAlgebra")

using LinearAlgebra

B = [[3,-1,0,0,0] [-1,4,-1,0,0] [0,-1,4,-1,0] [0,0,-1,4,-1] [0,0,0,-1,3]]
Id5 = Matrix(1I, 5, 5)
Z = zeros((5,5))

A = Int[vcat(B, -Id5, Z) vcat(-Id5, B, -Id5) vcat(Z, -Id5, B)]

println(size(A))
println(A)
