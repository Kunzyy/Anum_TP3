#=
main:
- Julia version: 1.5.3
- Author: mathd
- Date: 2021-02-17
=#


include("assemblage_CSR.jl")
include("assemblage_full.jl")
include("grad_meth_CSR.jl")
include("grad_meth_full.jl")
include("conj_grad_meth_CSR.jl")
include("conj_grad_meth_full.jl")
include("matrixCSR.jl")

#=

indc = [1 2 4 1 4 1 2 3 4]
data = [3 1 2 4 3 1 2 3 1]
indpl = [1 4 6 8 10]
X = [2 1 1 0]
b = [4 5 1 3]
maxiter = 10
tol = 1e-6
A = [3 1 0 2; 4 0 0 3; 1 2 0 0; 0 0 3 1]
=#


N = 5
jeuParam = 2
X = zeros(Float64, N^2-1)
maxiter = 10*(N^2-1)
tol = 1e-10

data, indc, indpl, b = assemblage_CSR(N, jeuParam)
A, b = assemblage_full(N, jeuParam)

data = data'
indc = indc'
indpl = indpl'
b = b'
X = X'

println(indc)
println(indpl)
println(data)
println(b)

#=
#Attention pour la full on utilise un X et un b vertical mais pour la parse un horizontal
@time(println(grad_meth_CSR(data,indc,indpl,b,X,maxiter,tol)))
println("Function 1 ok")

@time (println(grad_meth_full(A,b',X',maxiter,tol)))
println("Function 2 ok")

@time(println(conj_grad_meth_CSR(data,indc,indpl,b,X,tol)))
println("Function 3 ok")

@time(println(conj_grad_meth_full(A,b',X',tol)))
println("Function 4 ok")=#

X = grad_meth_CSR(data,indc,indpl,b,X,maxiter,tol)

println(A*X')

