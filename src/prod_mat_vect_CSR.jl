#=
main:
- Julia version: 1.5.2
- Author: mathd
- Date: 2021-02-16
=#

#=
include("matrixCSR.jl")

#A = [3 1 0 2; 4 0 0 3; 1 2 0 0; 0 0 3 1]
#Réponse : A*X = [7 ; 8 ; 4 ; 3]

#indc = [1 2 4 1 4 1 2 3 4]
#data = [3 1 2 4 3 1 2 3 1]
#indpl = [1 4 6 8 10]
X = [2 1 1 0]

data, indc, indpl , m , n , A = matrixCSR(A) #On récupère les résultats transposés
print("Matrice : ", A , "\nSize de A : ", m , "x", n, "\ndata : ", data , " | indpl : " , indpl , " | indc : " , indc , "\n")
@time(prod_mat_vect_CSR(4,indpl , indc,data, X))
@time(result(X))

function result(X)
    result = A*X'
    #println("Résultat matrice normale : " , result)
end

=#

function prod_mat_vect_CSR(n , indpl , indc , data, X)
    compt = 1
    V = zeros(n)
    temp = 0
    for i = 1:size(indpl,2)
        start = indpl[i]
        if i == size(indpl,2)
            finish = size(data,2)
        else
            finish = indpl[i+1]-1
        end

        for j = start:finish
            r= indc[j]
            temp = temp + data[j]*X[r]
        end
        V[i] = temp
        temp = 0
    end
    #print("Résultat fonction matrice sparse : ", V , "\n")
    return V'
end



