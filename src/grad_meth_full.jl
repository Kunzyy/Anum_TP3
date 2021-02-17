#=
grad_meth_full:
- Julia version: 1.5.3
- Author: mathd
- Date: 2021-02-17
=#

using LinearAlgebra

function grad_meth_full(A,b,X,maxiter,tol)
    #X est un vecteur vertical (nx1)
    #A est une matrice (nxn)
    k=0
    alpha = 0
    d= -(A*X-b) #A(nxn) * X(nx1) et b(nx1) => d(nx1)
    while k < maxiter
        #Calcul du pas
        num = -d'*(A*X-b)
        den = d'*(A*d)
        println(num , "  ",den)

        alpha = num[1]/den[1]

        #Nouvel itéré
        Xnew = X + alpha*d #X(nx1) + alpha*d (nx1) => Xnew(nx1)

        #Nouvelle direction
        d = -(A*Xnew - b)

        if norm(X-Xnew) < tol
            X = Xnew
            break
        end

        k+=1
        X = Xnew
    end
    return X
end

X = [2 ;1 ;1 ;0]
b = [4 ; 5 ; 1 ; 3]
maxiter = 10
tol = 1e-6
A = [3 1 0 2; 4 0 0 3; 1 2 0 0; 0 0 3 1]

