SI = 1500

function main()
    dots = fill(false, (SI, SI))
    input = open("input.txt", "r")
    while (true)
        line = input |> readline
        line == "" && break
        x, y = parse.(Int, split(line, ","))
        dots[y + 1, x + 1] = true
    end
    while (true)
        line = input |> readline
        line == "" && break
        dir, axis = split(split(line, " ")[3], "=")
        dir, axis = dir == "y" ? 1 : 2, parse(Int, axis) + 1
        if dir == 1
            dots = dots[begin:2axis - 1, :]
            dots[1:axis, :] .|= reverse(dots[axis:end, :], dims=dir)
            dots[axis:end, :] .= false
        else
            dots = dots[:, begin:2axis - 1]
            dots[:, 1:axis] .|= reverse(dots[:, axis:end], dims=dir)
            dots[:, axis:end] .= false
        end
    end
    map(x -> x ? '#' : ' ', dots) |> display
end
main()
