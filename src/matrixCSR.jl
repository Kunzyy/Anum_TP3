#=
matrixCSR:
- Julia version: 1.5.3
- Author: Nicolas
- Date: 2021-02-16
=#

function matrixCSR(A)

    M,N = size(A)


    DATA = Int[]
    INDC = Int[]
    INDPL = Int[1]

    for i in 1:M
        for j in 1:N
            if A[i,j] != 0
                append!(DATA, [A[i,j]])
                append!(INDC, [j])
            end
        end

        indpl = size(INDC,1) + 1
        append!(INDPL, [indpl])
    end

    return DATA', INDC', INDPL', M , N , A
end