function play!(player_a::Array{Int}, player_b::Array{Int})
    pl_cd = [popfirst!(player_a), popfirst!(player_b)]
    pl_cd[1] > pl_cd[2] ? append!(player_a, pl_cd) : append!(player_b, reverse(pl_cd))
end

function ans(pl_a, pl_b)
    game!(pl_a, pl_b)
    fin = append!(pl_a, pl_b)
    sum([key * val for (key, val) in fin |> reverse |> enumerate])
end

function game!(p1, p2, stack = 1)
    winner = i = 0
    ps_gam_a = ps_gam_b = Set()
    while true
        i += 1
        p1 ∈ ps_gam_a && p2 ∈ ps_gam_b && (winner = 1; break) ||
        push!(ps_gam_a, copy(p1)); push!(ps_gam_b, copy(p2))
        if p1[begin] < length(p1) && p2[begin] < length(p2)
            l1 = popfirst!(p1)
            l2 = popfirst!(p2)
            w = game!(copy(p1[begin:l1]), copy(p2[begin:l2]), stack + 1)
            if w == 1
                push!(p1, l1)
                push!(p1, l2)
            elseif w == 2
                push!(p2, l2)
                push!(p2, l1)
            end
        else
            p1[begin] > p2[begin] && ( winner = 1 )
            p2[begin] > p1[begin] && ( winner = 2 )
            if winner == 1
                push!(p1, popfirst!(p1))
                push!(p1, popfirst!(p2))
            elseif winner == 2
                push!(p2, popfirst!(p2))
                push!(p2, popfirst!(p1))
            end
            (length(p1) == 0 || length(p2) == 0) && break
        end
    end
    return winner
end

input = readlines("input.txt")
pl_a, pl_b = parse.(Int, input[2:26]), parse.(Int, input[29:end])

ans(pl_a, pl_b) |> println