function calctimestamp(arr_dict)
    step, time = 1, 0
    for (key, val) in arr_dict
        while mod(time, key) != val; time += step end
        step *= key
    end
    time
end

input_file = open("input.txt", "r")
raw, buses = readlines(input_file)[2], Dict()
[buses[parse(Int, bus)] = mod(parse(Int, bus) - (idx-1), parse(Int, bus))
for (idx, bus)=enumerate(split(raw, ',')) if bus!="x"]


calctimestamp(buses) |> println
close(input_file)