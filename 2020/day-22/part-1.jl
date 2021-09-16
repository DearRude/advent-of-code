function play!(player_a::Array{Int}, player_b::Array{Int})
    pl_cd = [popfirst!(player_a), popfirst!(player_b)]
    pl_cd[1] > pl_cd[2] ? append!(player_a, pl_cd) : append!(player_b, reverse(pl_cd))
end

input = readlines("input.txt")
pl_a, pl_b = parse.(Int, input[2:26]), parse.(Int, input[29:end])

while length(pl_a) > 0 && length(pl_b) > 0; play!(pl_a, pl_b) end
fin = append!(pl_a, pl_b)
[idx*val for (idx, val)=fin|>reverse|>enumerate] |> sum |> println
