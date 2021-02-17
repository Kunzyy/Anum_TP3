#=
conj_grad_meth_full:
- Julia version: 1.5.3
- Author: mathd
- Date: 2021-02-17
=#

using LinearAlgebra
function conj_grad_meth_full(A,b,X,tol)
    k=0
    n = size(b) #vecteur vertical donc il ne retourne qu'un seul argument de taille
    grad_x= A*X-b #(nxn)*(nx1) - (nx1) => (nx1)
    d = - grad_x #d(nx1)
    while k < n[1] #Car il converge au plus en n itérés
        num = -d'*grad_x #(nx1)'*(nx1) => scal
        den = d'* (A*d) #(nx1)'* ((nxn)*(nx1)) =>scal
        alpha = num[1]/den[1] #num et den sont des scalaires mais il sont renvoyés sous forme d'un array 1x1'
        X = X + alpha*d

        if norm(grad_x) < tol
            return X
        end

        #Nouvelle direction
        grad_xnew = A*X -b #(nx1)

        bheta = norm(grad_xnew,2)/norm(grad_x,2)

        d = -grad_xnew + bheta * d #(nx1) + scal * (nx1) => (nx1)'
        grad_x = grad_xnew #Pour redémarrer la boucle il faut remettre le nouveau grad dans le gradient de base
        k +=1
    end

    return X
end

X = [2 ;1 ;1 ;0]
b = [4 ; 5 ; 1 ; 3]
maxiter = 10
tol = 1e-6
A = [3 1 0 2; 4 0 0 3; 1 2 0 0; 0 0 3 1]

@time(println(conj_grad_meth_full(A,b,X,tol)))