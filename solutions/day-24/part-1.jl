function cardinal_to_dir(s)
    s == "e"  && return CartesianIndex( 2, 0)
    s == "w"  && return CartesianIndex(-2, 0)
    s == "ne" && return CartesianIndex( 1, 1)
    s == "sw" && return CartesianIndex(-1,-1)
    s == "se" && return CartesianIndex( 1,-1)
    s == "nw" && return CartesianIndex(-1, 1)
end


directions = map(readlines("input.txt")) do line
    [cardinal_to_dir(m.match) for m=eachmatch(r"(?<!s)e|se|sw|(?<!s)w|nw|ne", line)]
end

tiles = Dict()
for ds in directions
    pos = reduce(+, ds, init = CartesianIndex(0, 0))
    tiles[pos] = !get(tiles, pos, false)
end

tiles |> values |> sum |> println
