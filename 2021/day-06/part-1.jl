function main()
    input = readline(open("input.txt", "r"))
    ln = parse.(Int, split(input, ","))

    for _ ∈ 1:80
        ln .-= 1
        for (idx, pregnant) ∈ ln |> enumerate if pregnant == -1
                ln[idx] = 6
                push!(ln, 8)
            end
        end
    end
    length(ln) |> println
end
main()
