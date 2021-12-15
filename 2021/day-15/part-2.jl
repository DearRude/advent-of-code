SI = 100
AP = 5
function main()
    mat = fill(1, (AP * SI, AP * SI))
    for (i, line) ∈ eachline("input.txt") |> enumerate, (j, char) ∈ line |> enumerate
        mat[i, j] = parse(Int, char)
    end
    for i ∈ 1:AP * SI, j ∈ 1:AP * SI
        i <= SI && j <= SI && continue
        in, jn = (i - 1) ÷ SI, (j - 1) ÷ SI
        pr = mat[i - (in * SI), j - (jn * SI)] + in + jn
        mat[i, j] = pr > 9 ? pr - 9 : pr
    end
    route = zeros(AP * SI, AP * SI)
    route[1, 1] =  mat[1, 1]
    [route[1, x] = route[1, x - 1] + mat[1, x - 1] for x ∈ 2:AP * SI]
    [route[x, 1] = route[x - 1, 1] + mat[x - 1, 1] for x ∈ 2:AP * SI]
    for i ∈ 2:AP * SI, j ∈ 2:AP * SI
        route[i, j] = mat[i, j] + min(route[i, j - 1], route[i - 1, j])
    end
    route[AP * SI, AP * SI] |> println
end
main()
