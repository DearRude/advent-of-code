input_file = open("input.txt", "r")
commands = split.(readlines(input_file), " ")
commands = [[x[1], parse(Int, x[2])] for x in commands]
forward = filter(x -> x[1] == "forward", commands) .|> x -> x[2]
up = filter(x -> x[1] == "up", commands) .|> x -> x[2]
down = filter(x -> x[1] == "down", commands) .|> x -> x[2]

@info sum(forward) * (sum(down) - sum(up))
