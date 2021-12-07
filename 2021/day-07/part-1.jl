# This question also can be solved with calculating the median
# but this solution is fast enough (I guess?)

function main()
    input = readline(open("input.txt", "r"))
    pos = parse.(Int, split(input, ","))

    min_sum = sum(pos)
    for val in minimum(pos):maximum(pos)
        pos_sum = sum(abs, pos .- val)
        pos_sum < min_sum && (min_sum = pos_sum)
    end
    min_sum |> println
end
main()
