function main()
    input = open("input.txt", "r")
    tmp = split(input |> readline, ""); input |> readline
    pairs = Dict()
    for line ∈ input |> readlines
        key, val = split(line, " -> ")
        pairs[key] = val
    end

    for _ ∈ 1:10
        for (idx, char) ∈ tmp[begin:end - 1] |> enumerate
            insert!(tmp, 2idx, pairs[tmp[2idx - 1:2idx] |> join])
        end
    end
    countmap = [count(==(el), tmp) for el ∈ tmp]
    maximum(countmap) - minimum(countmap) |> println
end
main()
