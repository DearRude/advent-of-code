function main()
    ans = 0
    input = readlines(open("input.txt", "r"))
    mat = fill('9', (length(input) + 2, length(input[1]) + 2))
    for (idx, line) ∈ input |> enumerate, (ch, char) ∈ line |> enumerate
        mat[idx + 1, ch + 1] = char
    end
    for row ∈ 2:length(input) + 1, column ∈ 2:length(input[1]) + 1
        mat[row, column] >= mat[row + 1, column] && continue
        mat[row, column] >= mat[row - 1, column] && continue
        mat[row, column] >= mat[row, column + 1] && continue
        mat[row, column] >= mat[row, column - 1] && continue
        ans += parse(Int, mat[row, column]) + 1
    end
    ans |> println
end
main()
