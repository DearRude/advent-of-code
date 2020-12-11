input_file = open("input.txt", "r")
jolts = map(str -> parse(Int, str), readlines(input_file)) |> sort
pushfirst!(jolts, 0)

function count_rm(length)
    length < 1 && return 1; length < 3 && return 2length
    count = 2^length - 1
    [count -= (length-2) * binomial(length-3, iter) for iter in 1:length-3]
    count
end

diffs = [jolts[idx+1] - jolts[idx] for idx in 1:length(jolts)-1] |> join
diffs = map(ones -> length(ones) - 1, split(diffs, '3'))

[count_rm(one) for one in diffs] |> prod |> println

close(input_file)