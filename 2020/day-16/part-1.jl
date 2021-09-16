function in_range(nums)
    for row in 1:size(limits)[1]
        limits[row, 1] <= nums <= limits[row, 2] && return true
    end
    return false
end


function gen_lims()::Array{Int64,2}
    lims = zeros(Int64, (2CLS , 2))
    for (idx, line) in enumerate(input_file[begin:CLS])
        store = SubString.(line, findall(r"\d+", line)) .|> sub -> parse(Int, sub)
        lims[idx, :] = store[begin:2]; lims[idx+CLS, :] = store[3:end]
    end
    lims
end

input_file = open("input.txt", "r") |> readlines
CLS, TIK = 20, 26
limits = gen_lims()

sums = []
for line in input_file[TIK:end]
    nums = parse.(Int, split(line, ','))
    filter!(!in_range, nums)
    push!(sums, sum(nums))
end

sums |> sum |> println