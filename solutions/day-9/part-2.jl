function is_sum_of(inner::Int, set_start::Int)::Int
    set_end = set_start + 1
    while sum(lines[set_start:set_end]) <= inner
        if sum(lines[set_start:set_end]) == inner
            return minimum(lines[set_start:set_end]) + maximum(lines[set_start:set_end])
        end
        set_end += 1
    end
    return 0
end

input_file = open("input.txt", "r")
lines = map(str -> parse(Int, str), readlines(input_file))
prem, check = 25, 22477624


for idx in 1:length(lines) - 1
    is_sum_of(check, idx) == 0 || (println(is_sum_of(check, idx)); break)
end


close(input_file)