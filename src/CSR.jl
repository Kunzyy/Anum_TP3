#=
TP3:
- Julia version: 1.5.3
- Author: Nicolas
- Date: 2021-02-16
=#

include("matrixCSR.jl")
include("assemblage_CSR.jl")

import Pkg
Pkg.add("LinearAlgebra")
using LinearAlgebra

B = [[3,-1,0,0,0] [-1,4,-1,0,0] [0,-1,4,-1,0] [0,0,-1,4,-1] [0,0,0,-1,3]]
Id5 = Matrix(1I, 5, 5)
Z = zeros((5,5))

A = Int[vcat(B, -Id5, Z) vcat(-Id5, B, -Id5) vcat(Z, -Id5, B)]

a,b,c = matrixCSR(A)

println(a)
println(b)
println(c)




