uniqs = Dict(2 => '1', 3 => '7', 4 => '4', 7 => '8')

function main()
    ans = 0
    for line ∈ readlines(open("input.txt", "r"))
        train, test = split(line, " | ") .|> x -> split(x, " ")
        maps = train |> encode
        raw_num = map(x -> decode(x, maps), test) |> join
        ans += parse(Int, raw_num)
    end
    ans |> println
end

function encode(digis)
    one = filter(x -> length(x) == 2, digis)[1]
    six = filter(x -> length(x) == 6 && !issubset(one, x), digis)[1]
    upper_right = setdiff(one, six)[1]
    five = filter(x -> length(x) == 5 && !issubset(upper_right, x), digis)[1]
    down_left = setdiff(six, five)[1]
    return upper_right, down_left
end

function decode(digi, maps)
    length(digi) ∈ uniqs |> keys && (return uniqs[length(digi)])
    if length(digi) == 6
        maps ⊆ digi && return '0'
        maps[1] ∈ digi && return '9'
        return '6'
    elseif length(digi) == 5
        maps ⊆ digi && return '2'
        maps[1] ∈ digi && return '3'
        return '5'
    end
end
main()
