function main()
    ans = []

    closed = Dict(
        '{' => '}', '[' => ']',
        '(' => ')', '<' => '>')
    error = Dict(
        '}' => 3, ']' => 2,
        ')' => 1, '>' => 4)

    function checkline(line)::Int64
        score, charque = 0, []
        for char ∈ line
            char ∈ closed |> keys ? push!(charque, char) :
            char == closed[charque[end]] ? pop!(charque) : return 0
        end
        for que ∈ charque |> reverse
            score *= 5
            score += error[closed[que]]
            end
        return score
    end
    for line ∈ readlines(open("input.txt", "r"))
        score = checkline(line)
        score != 0 && push!(ans, score)
    end
    (ans |> sort)[(length(ans) + 1) ÷ 2] |> println
end
main()
