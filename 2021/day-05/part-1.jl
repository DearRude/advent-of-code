const MAX = 1000;

function main()
    input_file = open("input.txt", "r")
    diagram = zeros(UInt8, MAX, MAX)
    for line ∈ readlines(input_file)
        origin, des = split(line, "->")
        x_or, y_or = parse.(UInt16, split(origin, ","))
        x_de, y_de = parse.(UInt16, split(des, ","))
        x_or != x_de && y_or != y_de && continue
        x_or, x_de = sort([x_or, x_de])
        y_or, y_de = sort([y_or, y_de])
        diagram[x_or:x_de, y_or:y_de] .+= 1;
    end
    length(diagram[diagram .>= 2]) |> println
end

main()
