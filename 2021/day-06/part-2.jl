function main()
    input = readline(open("input.txt", "r"))
    counts = zeros(9)
    for val ∈ parse.(Int8, split(input, ","))
        counts[val + 1] += 1
    end
    for _ ∈ 1:256
        pregnants = counts[1]
        for it ∈ 2:9
            counts[it - 1] = counts[it]
        end
        counts[7] += pregnants
        counts[9] = pregnants
    end
    counts |> sum |> BigInt |> println
end
main()
