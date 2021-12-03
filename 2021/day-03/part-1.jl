input_file = open("input.txt", "r")
binaries = split.(readlines(input_file), " ") .|> x -> x[1]

gamma_bits =
    [count(==('0'), binaries .|> x -> x[idx]) > length(binaries) / 2 ? '0' : '1'
    for (idx, _) ∈ binaries[1] |> enumerate]

pad = 64 - length(gamma_bits)
gamma_rate = parse(UInt, gamma_bits |> join, base=2)
@info gamma_rate * (~gamma_rate << pad >> pad)
