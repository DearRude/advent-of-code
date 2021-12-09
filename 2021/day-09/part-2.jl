function main()
    basins = []
    input = readlines(open("input.txt", "r"))
    mat = fill('9', (length(input) + 2, length(input[1]) + 2))
    marked = fill(false, (length(input) + 2, length(input[1]) + 2))
    for (idx, line) ∈ input |> enumerate, (ch, char) ∈ line |> enumerate
        mat[idx + 1, ch + 1] = char
    end
    function fl(i, j)
        (mat[i, j] == '9' || marked[i, j]) && return 0;
        marked[i, j] = true
        return 1 + fl(i - 1, j) + fl(i + 1, j) + fl(i, j - 1) + fl(i, j + 1)
    end

    for row ∈ 2:length(input) + 1, column ∈ 2:length(input[1]) + 1
        basin = fl(row, column)
        basin != 0 && push!(basins, basin)
    end
    (basins |> sort)[end - 2:end] |> prod |> println
end
main()
