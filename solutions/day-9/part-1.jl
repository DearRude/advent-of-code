input_file = open("input.txt", "r")
lines = map(str -> parse(Int, str), readlines(input_file))
prem = 25

for (idx, line) in enumerate(lines[prem + 1: end])
    num_set = lines[idx : idx + prem-1]
    any(iter -> line - iter in num_set, num_set) || (println(line); break)
end
close(input_file)