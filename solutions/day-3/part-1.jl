input_file = open("input.txt", "r")
mapline = readlines(input_file)
trees = 0

for (idx, line) in enumerate(mapline)
    obj = line[((3*idx-3) % 31) + 1]
    obj == '#' && (global trees += 1)
end



print(trees)
close(input_file)