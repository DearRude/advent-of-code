input_file = open("input.txt", "r")
mapline = readlines(input_file)
slopes = [1, 3, 5, 7]
trees = zeros(slopes[end])
trees[4] = 1; trees[6] = 1


for (idx, line) in enumerate(mapline), sl in slopes
    obj = line[((sl*idx-sl) % 31) + 1]
    obj == '#' && (global trees[sl] += 1)

    idx % 2 == 1 && sl == 1 && 
    line[Int32(floor(idx / 2) % 31) + 1] == '#' &&
    (global trees[2] += 1)
end


println(trees)
print(BigInt(prod(trees)))
close(input_file)