#=
assemblage_CSR:
- Julia version: 1.5.3
- Author: Nicolas
- Date: 2021-02-16
=#

include("getNENNL.jl")

#Jeu de paramètres (i)
rho_i(x, y) = 1
u0_i(x) = 1
u1_i(x) = 2

#Jeu de paramètres (ii)
rho_ii(x, y) = 1
u0_ii(x) = 1 + x^2
u1_ii(x) = 2 - x^2

#Jeu de paramètres (iii)
rho_iii(x, y) = 1 + 100 * (x + y)
u0_iii(x) = 1
u1_iii(x) = 2


function assemblage_CSR(N, jeuParam)

    if jeuParam == 1
        rho = rho_i
        u0 = u0_i
        u1 = u1_i
    end

    if jeuParam == 2
        rho = rho_ii
        u0 = u0_ii
        u1 = u1_ii
    end

    if jeuParam == 3
        rho = rho_iii
        u0 = u0_iii
        u1 = u1_iii
    end

    DATA = Float64[]
    INDC = Int64[]
    INDPL = Int64[1]

    ##################################
    #Génération du vecteur INDPL
    NENNL = getNENNL(N)

    for i in 2:(N^2-1)
        indpl = INDPL[i-1] + NENNL[i-1]
        push!(INDPL, indpl)
    end

    ##################################
    #Génération des vecteurs INDC et DATA

    for k in 1:N-1
        for j in 0:N
            # Voisin du dessous
            x = j
            y = k-1

            if y != 0
                # Si y = 0, on se trouve sur les bords bas du système, donc c'est un voisin isolant et on ne le traite pas
                indc = x + 1 + (y-1)*(N+1)
                push!(INDC, indc)

                data = -rho(x,y-1/2)
                push!(DATA, data)
            end

            # Voisin de gauche
            x = j-1
            y = k

            if x != -1
                # Si x = -1, on sort du système par la gauche, donc on ne le traite pas
                indc = x + 1 + (y-1)*(N+1)
                push!(INDC, indc)

                data = -rho(x-1/2,y)
                push!(DATA, data)
            end

            # Point courant
            x = j
            y = k

            # Pas de condition
            indc = x + 1 + (y-1)*(N+1)
            push!(INDC, indc)

            # Si il se retrouve sur le bord gauche
            if x == 0
                data = rho(x-1/2,y) + rho(x+1/2,y) + rho(x,y+1/2)
            #Si il se retrouve sur le bord droit
            elseif x == N
                data = rho(x,y-1/2) + rho(x-1/2,y) + rho(x+1/2,y)
            else
                data = rho(x,y-1/2) + rho(x-1/2,y) + rho(x+1/2,y) + rho(x,y+1/2)
            end

            push!(DATA, data)

            # Voisin de droite
            x = j+1
            y = k

            if x != N+1
                # Si x = N+1, on sort du système par la droite, donc on ne le traite pas
                indc = x + 1 + (y-1)*(N+1)
                push!(INDC, indc)

                data = -rho(x+1/2,y)
                push!(DATA, data)
            end

            # Voisin du dessus
            x = j
            y = k+1

            if y != N
                # Si y = N, on se trouve sur les bords hauts du système, donc c'est un voisin isolant et on ne le traite pas
                indc = x + 1 + (y-1)*(N+1)
                push!(INDC, indc)

                data = -rho(x,y+1/2)
                push!(DATA, data)
            end
        end
    end

    ##################################
    #Génération du vecteur b grâce aux expressions de u0 et u1
    b = Int[]
    #Ligne u0
    for i in 0:N
        push!(b, u0(i))
    end

    #Centre du système
    for i in 1:N-3
        for j in 1:N+1
            push!(b, 0)
        end
    end

    #Ligne u1
    for i in 0:N
        push!(b, u1(i))
    end

    return DATA, INDC, INDPL, b
end