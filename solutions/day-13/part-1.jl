input_file = open("input.txt", "r")
lines = readlines(input_file)

stamp = parse(Int, lines[1])
buses = [parse(Int, bus) for bus=split(lines[2], ',') if bus!="x"]
times = [bus - (stamp % bus) for bus=buses]

buses[argmin(times)] * minimum(times) |> println
close(input_file)