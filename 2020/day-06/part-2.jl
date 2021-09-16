input_file = open("input.txt", "r")
persons = readlines(input_file)
alphabets = [string(Char(alp)) for alp in 97:122]
ans, yes, idx = [alphabets], 0, 1


for person in persons
    person == "" && push!(ans, alphabets) != 0 && global idx += 1
    person == "" || global ans[idx] = intersect(ans[idx], split(person, ""))
end


[global yes+=length(an) for an in ans]

println(yes)
close(input_file)