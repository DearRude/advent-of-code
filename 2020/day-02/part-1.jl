input_file = open("input.txt", "r")
entries = readlines(input_file)

matched = 0

for entry in entries
    para, char, puts = split(entry, " ")
    bounds = split(para, "-")
    bnd = map(str -> parse(Int8, str), bounds)
    counts = count(c->(c==char[1]), puts)
    bnd[1] <= counts <= bnd[2] && global matched += 1
end

print(matched)


close(input_file)