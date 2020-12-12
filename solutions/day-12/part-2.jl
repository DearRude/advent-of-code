function move!(instruc, hamil, waypoint)
    direc, length = instruc[1], parse(Int, instruc[2:end])

    direc == 'R' && (direc = 'L'; length = 360 - length)
    direc == 'L' && length == 90 && (waypoint .= [waypoint[2], -waypoint[1]])
    direc == 'L' && length == 270 && (waypoint .= [-waypoint[2], waypoint[1]])
    direc == 'L' && length == 180 && (waypoint .= [-waypoint[1], -waypoint[2]])

    direc == 'N' && (waypoint[1] += length)
    direc == 'S' && (waypoint[1] -= length)
    direc == 'E' && (waypoint[2] += length)
    direc == 'W' && (waypoint[2] -= length)

    direc == 'F' && (hamil .+= length*waypoint)
end

input_file = open("input.txt", "r")
instuctions = readlines(input_file)
hamil, waypoint = [0, 0], [1, 10]


[move!(instruc, hamil, waypoint) for instruc=instuctions]

println(sum(abs, hamil))

close(input_file)