#=
assemblage_full:
- Julia version: 1.5.3
- Author: Nicolas
- Date: 2021-02-18
=#

include("assemblage_CSR.jl")

function assemblage_full(N, jeuParam)

    DATA, INDC, INDPL, b = assemblage_CSR(N, jeuParam)

    NN = size(INDPL,1) # NN = N^2-1

    A = zeros(Int64, NN, NN)

    # size(A,1) = size(INDC,1)
    nbreData = size(DATA,1)

    compt = 1
    i = 1

    for k in 1:nbreData
        j = INDC[k]
        A[i,j] = DATA[k]
        compt += 1

        if INDPL[i+1] == compt
            i += 1
        end
    end

    return A, b
end