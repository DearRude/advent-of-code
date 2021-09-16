input_file = open("input.txt", "r")
passlines = readlines(input_file)
pass_idx, passports = 1, [[]]

function valid_byr(bri_date::SubString)
    date_num = parse(Int, bri_date)
    length(bri_date) != 4 && (return false)
    1920 <= date_num <= 2002 || (return false)
    return true
end

function valid_iyr(issue_date::SubString)
    date_num = parse(Int, issue_date)
    length(issue_date) != 4 && (return false)
    2010 <= date_num <= 2020 || (return false)
    return true
end

function valid_eyr(exp_date::SubString)
    date_num = parse(Int, exp_date)
    length(exp_date) != 4 && (return false)
    2020 <= date_num <= 2030 || (return false)
    return true
end


function valid_hgt(height::SubString)
    isdigit(height[end]) && (return false)
    num = parse(Int, height[1:end-2])
    height[end-1:end] == "cm" && 150 <= num <= 193 && (return true)
    height[end-1:end] == "in" && 59 <= num <= 76 && (return true)
    return false
end

function valid_hcl(hair_col::SubString)
    hair_col[1] != '#' && (return false)
    for char in hair_col[2:end]
        !isdigit(char) && !(97 <= Int(char) <= 102) && (return false)
    end
    return true
end

function valid_ecl(eye_col::SubString)
    valids = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    eye_col in valids && (return true)
    return false
end

valid_pid(pid::SubString) = (length(pid) == 9)

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
    has_cid, wrong = false, false
    for entity in passport
        en = split(entity, ':')
        en[1] == "cid" && (has_cid = true)
        en[1] == "byr" && !valid_byr(en[2]) && (wrong = true)
        en[1] == "iyr" && !valid_iyr(en[2]) && (wrong = true)
        en[1] == "hgt" && !valid_hgt(en[2]) && (wrong = true)
        en[1] == "hcl" && !valid_hcl(en[2]) && (wrong = true)
        en[1] == "eyr" && !valid_eyr(en[2]) && (wrong = true)
        en[1] == "ecl" && !valid_ecl(en[2]) && (wrong = true)
        en[1] == "pid" && !valid_pid(en[2]) && (wrong = true)
    end

    if length(passport) < 7 || (length(passport) == 7 && has_cid) || wrong
        global non_valids += 1
    end

end

println(length(passports) - non_valids)
close(input_file)