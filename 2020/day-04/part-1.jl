input_file = open("input.txt", "r")
passlines = readlines(input_file)
pass_idx, passports = 1, [[]]

for line in passlines
    if line == ""
        global pass_idx += 1
        push!(passports, [])
        continue
    end
    append!(passports[pass_idx], split(line, ' '))
end

non_valids = 0
for passport in passports
    has_cid = false
    for entity in passport
        if entity[1:3] == "cid"
            has_cid = true
            break
        end
    end

    if length(passport) < 7 || (length(passport) == 7 && has_cid)
        global non_valids += 1
    end

end

println(length(passports) - non_valids)
close(input_file)