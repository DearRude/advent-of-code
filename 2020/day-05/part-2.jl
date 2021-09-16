function calc_seat_id(seat::String)
    row = parse(Int, replace(replace(seat[1:7], "B" => "1"), "F" => "0"), base=2)
    column = parse(Int, replace(replace(seat[end-2:end], "R" => "1"), "L" => "0"), base=2)
    return (row * 8) + column
end


input_file = open("input.txt", "r")
seats = readlines(input_file)
seats_arr = []

[push!(seats_arr, calc_seat_id(seat)) for seat in seats]
[seat in seats_arr || println(seat) for seat in 11:835]

close(input_file)