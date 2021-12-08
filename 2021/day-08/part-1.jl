function main()
    uniqs = [2, 3, 4, 7]
    input = readlines(open("input.txt", "r"))
    digi = split.(input, " | ") .|> x -> x[2] |> x -> split(x, " ")
    digi = vcat(digi...) .|> length .|> x -> x ∈ uniqs
    digi |> sum |> println
end
main()
