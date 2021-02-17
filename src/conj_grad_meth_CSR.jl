#=
conj_grad_meth_CSR:
- Julia version: 1.5.3
- Author: mathd
- Date: 2021-02-17
=#

include("prod_mat_vect_CSR.jl")
using LinearAlgebra

function conj_grad_meth_CSR(data,indc, indpl,b,X,tol)
    k=0
    m,n = size(b)
    grad_x= prod_mat_vect_CSR(n , indpl , indc , data, X)-b #(1xn) - (1xn) => (1xn)
    d = - grad_x #d(1xn)
    while k < maxiter
        num = -d*grad_x'
        den = d* (prod_mat_vect_CSR(n , indpl , indc , data, d))'
        alpha = num[1]/den[1] #num et den sont des scalaires mais il sont renvoyés sous forme d'un array 1x1'
        X = X + alpha*d

        if norm(grad_x) < tol
            return X
        end

        #Nouvelle direction
        grad_xnew = prod_mat_vect_CSR(n , indpl , indc , data, X)-b

        bheta = norm(grad_xnew,2)/norm(grad_x,2)

        d = -grad_xnew + bheta * d #(1xn) + scal * (1xn) => (1xn)'
        grad_x = grad_xnew #Pour redémarrer la boucle il faut remettre le nouveau grad dans le gradient de base
        k +=1
    end

    return X
end


indc = [1 2 4 1 4 1 2 3 4]
data = [3 1 2 4 3 1 2 3 1]
indpl = [1 4 6 8 10]
X = [2 1 1 0]
b = [4 5 1 3]
maxiter = 10
tol = 1e-6
@time(println(conj_grad_meth_CSR(data,indc,indpl,b,X,tol)))