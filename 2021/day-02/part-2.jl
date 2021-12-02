input_file = open("input.txt", "r")
commands = split.(readlines(input_file), " ")
commands = [[x[1], parse(Int, x[2])] for x in commands]

function calc_position(comms)
	aim, forward, depth = 0, 0, 0
	for comm in comms
		comm[1] == "down" ? (aim += comm[2]) :
		comm[1] == "up" ? (aim -= comm[2]) :
		(forward += comm[2]; depth += aim * comm[2])
	end
	return depth * forward
end

@info calc_position(commands)
