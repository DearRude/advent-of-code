function move!(idx, hamil)
    direc, length = instuctions[idx][1], parse(Int, instuctions[idx][2:end])
    new_direcs = copy(direcs)

    direc == 'F' && (direc = direcs[1])
    direc == 'R' && circshift!(direcs, new_direcs, -length/90)
    direc == 'L' && circshift!(direcs, new_direcs, length/90)

    direc == 'N' && (hamil[1] += length)
    direc == 'S' && (hamil[1] -= length)
    direc == 'E' && (hamil[2] += length)
    direc == 'W' && (hamil[2] -= length)
end

input_file = open("input.txt", "r")
instuctions = readlines(input_file)
hamil, direcs = [0, 0], ['E', 'S', 'W', 'N']

[move!(idx, hamil) for idx in 1:length(instuctions)]

println(sum(abs, hamil))

close(input_file)