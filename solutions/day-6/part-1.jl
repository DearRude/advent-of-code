input_file = open("input.txt", "r")
persons = readlines(input_file)
ans, yes, idx = [[]], 0, 1

for person in persons
    person == "" && push!(ans, []) != 0 && global idx += 1
    person == "" || (append!(ans[idx], person))
end


[global yes+=length(union(an)) for an in ans]

println(yes)
close(input_file)