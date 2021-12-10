function main()
    ans = 0

    closed = Dict(
        '{' => '}', '[' => ']',
        '(' => ')', '<' => '>')
    error = Dict(
        '}' => 1197, ']' => 57,
        ')' => 3, '>' => 25137)

    function checkline(line)::Int64
        charque = []
        for char ∈ line
            char ∈ closed |> keys ? push!(charque, char) :
            char == closed[charque[end]] ? pop!(charque) : return error[char]
        end
        return 0
    end
    for line ∈ readlines(open("input.txt", "r"))
        ans += checkline(line)
    end
    ans |> println
end
main()
