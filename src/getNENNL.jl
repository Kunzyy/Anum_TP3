#=
getNENNL:
- Julia version: 1.5.3
- Author: Nicolas
- Date: 2021-02-18
=#

function getNENNL(N)
    # Nombre d'éléments non-nuls par ligne
    NENNL = Int[]

    LigneBord = Int[3]
    for i in 1:N-1
        append!(LigneBord, [4])
    end
    append!(LigneBord, [3])

    LigneCentre = Int[4]
    for i in 1:N-1
        append!(LigneCentre, [5])
    end
    append!(LigneCentre, [4])

    #Remplissage de NENNL
    append!(NENNL, LigneBord)
    for i in 1:N-3
        append!(NENNL, LigneCentre)
    end
    append!(NENNL, LigneBord)

    return NENNL'
end