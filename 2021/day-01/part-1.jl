input_file = open("input.txt", "r")
depths = map(str -> parse(Int, str), readlines(input_file))

diffsum(nums::Array{Int}, diff::Int)::Int =
	map(x -> x[1] < x[2], zip(nums, nums[diff:end])) |> sum

@info diffsum(depths, 2)

close(input_file)
