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
jeuParam = 1
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

println("indc : ",indc)
println("indpl : ",indpl)
println("data : ",data)
println("b : " , b)


println("\nMéthode du gradient CSR : ")
@time(X1 = grad_meth_CSR(data,indc,indpl,b',X',maxiter,tol))
println("X = " , X1 )
b1 = A*X1
println("Grad_CSR b = ",b1)
println("Erreur sur b : ", abs.(b-b1'))

println("\nMéthode du gradient full : ")
@time (X2 = grad_meth_full(A,b',X',maxiter,tol))
println("X = " , X2)
b2 = A*X2
println("Grad_full b = ",b2)
println("Erreur sur b : ", abs.(b-b2'))

println("\nMéthode du gradient conjugué CSR : ")
@time(X3 = conj_grad_meth_CSR(data,indc,indpl,b',X',tol))
println("X = " , X3)
b3 = A*X3
println("Grad_conj_CSR b = ",b3)
println("Erreur sur b : ", abs.(b-b3'))

println("\nMéthode du gradient conjugué full : ")
@time(X4 = conj_grad_meth_full(A,b',X',tol))
println("X = " , X4)
b4 = A*X4
println("Grad_conj_full b = ", b4)
println("Erreur sur b : ", abs.(b-b4'))





