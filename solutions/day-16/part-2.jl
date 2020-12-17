function in_range(nums::Int32, col::Int)::Bool
    first = limits[col, 1]<=nums<=limits[col, 2]
    second = limits[col, 3]<=nums<=limits[col, 4]
    return second || first
end

function val_ticket(row_num)::Bool
    for rng in 1:CLS
        all(in_range.(nums[row_num, :], rng)) && return true
    end
    return false
end

function gen_lims()::Array{Int32,2}
    lims = zeros(Int32, (CLS , 4))
    for (idx, line) in enumerate(input_file[begin:CLS])
        store = SubString.(line, findall(r"\d+", line)) .|> sub -> parse(Int, sub)
        lims[idx, :] = store
    end
    lims
end

function gen_matrix()::Array{Int32, 2}
    nums = zeros(Int32, (size(input_file[TIK:end])[1]+1, CLS))
    nums[end, :] = parse.(Int32, split(input_file[TIK-3], ','))
    for (idx, line) in enumerate(input_file[TIK:end])
        nums[idx, :] = parse.(Int32, split(line, ','))
    end
    nums
end

function gen_ticket_map()::Array{Int, 1}
    tik_map::Dict{Int, Array{Int, 1}} = Dict(k=>[] for k in 1:CLS)
    final_map = zeros(Int, CLS)
    for rng=1:CLS, col=1:CLS
        all(in_range.(nums[:, rng], col)) && push!(tik_map[col], rng)
    end
    for _ in 1:20
        place, single = [(k, v) for (k, v) in tik_map if length(v) == 1][1]
        final_map[place] = single[1]
        [tik_map[idx]=filter(x -> x!=single[1], tik_map[idx]) for idx=tik_map|>keys]
    end
    final_map
end

input_file = open("input.txt", "r") |> readlines
CLS, TIK, DEP = 20, 26, 6
limits, nums = gen_lims(), gen_matrix()
nums = nums[val_ticket.(1:end), :]

prt_dict(dic) = for (k, v) in dic println("$k: $v") end
[nums[end, col] for col=gen_ticket_map()[1:DEP]] |> prod |> println

