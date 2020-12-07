input_file = open("input.txt", "r")
expense = readlines(input_file)

@time for (idx, outer_str) in enumerate(expense)
    for inner_str in expense[idx+1:end]
        outer_num = parse(Int32, outer_str)
        inner_num = parse(Int32, inner_str)
        outer_num + inner_num == 2020 && println(outer_num * inner_num)
    end
end

close(input_file)