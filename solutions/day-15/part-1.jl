input = [0,3,6]

for num in length(input)+1:2020
    prev = findprev(x -> x==input[num-1], input, num-2)
    prev |> isnothing && (push!(input, 0);true) || push!(input, num-1-prev)
end

input[end] |> println