#=
main:
- Julia version: 1.5.2
- Author: mathd
- Date: 2021-02-16
=#
include("matrixCSR.jl")
import Pkg

#print("Test")

A = [3 1 0 2; 4 0 0 3; 1 2 0 0; 0 0 3 1]
#Réponse : A*X = [7 ; 8 ; 4 ; 3]

# indc = [1 2 4 1 4 1 2 3 4]
#data = [3 1 2 4 3 1 2 3 1]
#indpl = [1 4 6 8 10]
X = [2 1 1 0]

function prod_mat_vect_CSR(n , indpl , indc , data, X)
    compt = 1
    V = zeros(n)
    temp = 0
    indplm , indpln = size(indpl)
    for i = 1:indpln
    start = indpl[i]
    finish = indpl[i+1]-1
        for j = start:finish
            r= indc[j]
            temp = temp + data[j]*X[r]
        end
        V[i] = temp
        temp = 0
    end
    print(V)
end

function result(X)
    result = A*X'
    print(result)
end


data, indc, indpl , m , n , A = matrixCSR(A) #On récupère les résultats transposés
print("Matrice : ", A , "\nSize : ", m , "x", n, "\ndata : ", data , " | indpl : " , indpl , " | indc : " , indc , "\n")
@time(prod_mat_vect_CSR(4,indpl , indc,data, X))
@time(result(X))