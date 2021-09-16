input_file = open("input.txt", "r")
entries = readlines(input_file)

matched = 0

for entry in entries
    para, char, puts = split(entry, " ")
    bound = split(para, "-")
    bnd = map(str->parse(Int8, str), bound)
    status = (puts[bnd[1]] == char[1]) + (puts[bnd[2]] == char[1])
    status == 1 && (global matched += 1)
end


print(matched)
close(input_file)