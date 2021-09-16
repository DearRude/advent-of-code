mutable struct Food
    allers::Array{String, 1}
    ingres::Array{String, 1}
end

function parse_input(input)::Vector{Food}
    foods = Vector{Food}(undef, length(input))
    for (idx, line) in input |> enumerate
        things = line |> split
        sep = findfirst(x -> x=="(contains", things)
        aller, ingre = map(alle->alle[1:end-1], things[sep+1:end]), things[1:sep-1]
        foods[idx] = Food(aller, ingre)
    end
    foods
end

function find_allers(foods::Vector{Food})::Dict{String, Array{String}}
    almap::Dict{String, Array{String}} = Dict()
    for food=foods, aller=food.allers
        same_foods = filter(fod -> aller ∈ fod.allers, foods)
        dups = ∩([same_food.ingres for same_food=same_foods]...)
        get!(almap, aller, dups)
    end
    for _ in 1:4
        ones = [val[1] for val in almap|>values if length(val)==1]
        [almap[key]=setdiff!(val, ones) for (key, val)=almap if length(val)>1]
    end
    almap
end

sort_print(alamp::Dict{String, Array{String}}) =
    [print("$(alamp[aller][1]),") for aller=alamp|>keys|>collect|>sort]

readlines("input.txt") |> parse_input |> find_allers |> sort_print
