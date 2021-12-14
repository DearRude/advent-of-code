function main()
    input = open("input.txt", "r")
    tmp = input |> readline; input |> readline
    pairs = Dict{String,String}()
    counts = Dict{String,Int}()
    for line ∈ input |> readlines
        key, val = split(line, " -> ")
        pairs[key] = val
        counts[key] = 0
    end

    chars = Dict(x => 0 for x ∈ pairs |> values |> unique)
    c = counts |> copy

    for idx ∈ 1:length(tmp) - 1
        c[tmp[idx:idx + 1]] += 1
        chars[tmp[idx:idx]] += 1
    end
    chars[tmp[end:end]] += 1

    for _ ∈ 1:40
        co = counts |> copy
        for (key, val) ∈ pairs
            co[key[1] * val] += c[key]
            co[val * key[2]] += c[key]
            chars[val] += c[key]
        end
        c = co
    end

    maximum(chars |> values) - minimum(chars |> values) |> println
end
main()
