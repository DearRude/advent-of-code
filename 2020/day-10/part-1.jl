input_file = open("input.txt", "r")
jolts = map(str -> parse(Int, str), readlines(input_file))

three = (maximum(jolts) - length(jolts)) / 2 + 1
one = length(jolts) - three + 1
one * three |> println

close(input_file)