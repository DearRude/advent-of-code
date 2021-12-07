# This question also can be solved with calculating the mean
# but this solution is fast enough (I guess?)

function main()
    input = readline(open("input.txt", "r"))
    pos = parse.(Int, split(input, ","))


    min_sum = sum(pos)^2
    for val in minimum(pos):maximum(pos)
        pos_sum = sum(x -> (abs(x) * (abs(x) + 1)) / 2, pos .- val)
        pos_sum < min_sum && (min_sum = pos_sum)
    end
    min_sum |> BigInt |> println
end
main()
