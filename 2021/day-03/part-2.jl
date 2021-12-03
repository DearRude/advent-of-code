input_file = open("input.txt", "r")
binaries = split.(readlines(input_file), " ") .|> x -> x[1]

function filter_occur(bins, idx, least)
    more_zero = count(==('0'), bins .|> x -> x[idx]) > length(bins) / 2
    char_filter = (!more_zero) ⊻ least ? '1' : '0'
    filter(x -> x[idx] == char_filter, bins)
end

mosts = leasts = binaries
for (idx, _) ∈ binaries[1] |> enumerate
    length(mosts) > 1 && (global mosts = filter_occur(mosts, idx, false))
    length(leasts) > 1 && (global leasts = filter_occur(leasts, idx, true))
end

@info parse(Int, mosts[1], base=2) * parse(Int, leasts[1], base=2)
