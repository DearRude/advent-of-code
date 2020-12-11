function doround(seats)
    nseats, (rows, cols) = copy(seats), size(seats)
    for x = 2:rows-1, y = 2:cols-1
        seats[x, y] == 0 && continue # Skip floor
        occupied_arount = count(i -> i == 1, seats[x-1:x+1, y-1:y+1])
        occupied_arount == 0 && (nseats[x, y] = 1)
        seats[x, y] == 1 && occupied_arount >= 5 && (nseats[x, y] = -1)
    end
    nseats
end


input_file = open("input.txt", "r")
seats_raw = readlines(input_file)

seats = zeros(Int8, length(seats_raw)+2, length(seats_raw[1])+2)
[seats[row+1, chair+1] = -1 for row=1:length(seats_raw)
for chair=1:length(seats_raw[1]) if seats_raw[row][chair]=='L']

new_seats = doround(seats)
while new_seats != seats
    global seats = new_seats
    global new_seats = doround(new_seats)
end

println(count(i -> i == 1, seats))

close(input_file)