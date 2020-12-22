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

function remove_dups(foods::Vector{Food})::Vector{Food}
    for food=foods, aller=food.allers
        same_foods = filter(fod -> aller ∈ fod.allers, foods)
        dups = ∩([same_food.ingres for same_food=same_foods]...)
        [setdiff!(same.ingres, dups) for same in foods]
    end
    foods
end

function count_left(foods::Vector{Food})::Int
    [length(food.ingres) for food=foods] |> sum
end

readlines("input.txt") |> parse_input |> remove_dups |> count_left |> println
