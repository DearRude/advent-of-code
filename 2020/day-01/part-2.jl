input_file = open("input.txt", "r")
expense = readlines(input_file)

# Part Two
@time for (out_idx, outer_str) in enumerate(expense)
    for (in_idx, inner_str) in enumerate(expense[out_idx+1:end])
        for deep_str in expense[in_idx+1:end]
            outer_num = parse(Int32, outer_str)
            inner_num = parse(Int32, inner_str)
            deep_num = parse(Int32, deep_str)
            if outer_num + inner_num + deep_num == 2020
                println(outer_num * inner_num * deep_num)
            end
        end
    end
end

close(input_file)