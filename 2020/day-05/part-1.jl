function calc_seat_id(seat::String)
    row = parse(Int, replace(replace(seat[1:7], "B" => "1"), "F" => "0"), base=2)
    column = parse(Int, replace(replace(seat[end-2:end], "R" => "1"), "L" => "0"), base=2)
    return (row * 8) + column
end


input_file = open("input.txt", "r")
seats = readlines(input_file)

max_id = 0
[calc_seat_id(seat) > max_id && global max_id = calc_seat_id(seat)
for seat in seats]


println(max_id)
close(input_file)