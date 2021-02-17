#=
grad_meth_CSR:
- Julia version: 1.5.3
- Author: mathd
- Date: 2021-02-17
=#
include("prod_mat_vect_CSR.jl")
using LinearAlgebra

function grad_meth_CSR(data,indc,indpl,b,X,maxiter,tol)
    k = 0
    m,n = size(b) #Normalement la matrice doit avoir la même taille que b
    alpha = 0
    d=-(prod_mat_vect_CSR(n , indpl , indc , data, X)-b) #attention il faut mettre la taille de la matrice nxn

    while k < maxiter
        num = (-d*(prod_mat_vect_CSR(n , indpl , indc , data, X)-b)')
        den = d* (prod_mat_vect_CSR(n , indpl , indc , data, d))'
        alpha = num[1]/den[1]
        Xnew = X + (alpha*d)
        d = -(prod_mat_vect_CSR(n , indpl , indc , data, Xnew)-b)


        if norm(X-Xnew) < tol
            X = Xnew
            break
        end

        X = Xnew
        k +=1
    end
end

indc = [1 2 4 1 4 1 2 3 4]
data = [3 1 2 4 3 1 2 3 1]
indpl = [1 4 6 8 10]
X = [2 1 1 0]
b = [4 5 1 3]
maxiter = 10
tol = 1e-6
grad_meth_CSR(data,indc,indpl,b,X,maxiter,tol)