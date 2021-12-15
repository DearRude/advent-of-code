function main()
    mat::Vector{String} = []
    for line in eachline("input.txt")
        push!(mat, line)
    end
    route = fill(0, (length(mat), length(mat[1])))
    route[1, 1] = mat[1][1] - '0'
    [route[1, x] = route[1, x - 1] + (mat[1][x - 1] - '0') for x ∈ 2:length(mat)]
    [route[x, 1] = route[x - 1, 1] + (mat[x - 1][1] - '0') for x ∈ 2:length(mat[1])]
    for i ∈ 2:length(mat), j ∈ 2:length(mat[1])
        route[i, j] = (mat[i][j] - '0') + min(route[i, j - 1], route[i - 1, j])
    end
    route[length(mat), length(mat[1])] |> println
    route |> display
end
main()
