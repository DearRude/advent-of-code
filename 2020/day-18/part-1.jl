input_file = open("input.txt", "r")

import Base.:+
import Base.:*

struct MathString
    val::Int
end

+(x::MathString, y::MathString) = MathString(x.val + y.val)
-(x::MathString, y::MathString) = MathString(x.val * y.val)

function calculate(linestring)
    value = map(linestring) do line
        line = replace(line, r"(\d)" => s"MathString(\1)")
        line = replace(line, "*" => "-")
        Meta.parse(line)
    end
    data = eval.(value)
    sum(d.val for d in data)
end

input_file |> readlines |> calculate |> println


close(input_file)
