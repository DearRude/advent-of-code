# I hate my implementation so I won't be optimizing it.

function adjlist(chair, seats)
    ways = [[right, up] for right=-1:1 for up=-1:1 if !(up==right==0)]
    adjs, nchair = [], chair
    push!(adjs, seats[nchair...])
    for way in ways
        nchair += way
        flag = true
        while flag
            seats[nchair...] != 0 && push!(adjs, seats[nchair...])
            flag = 1<nchair[1]<size(seats)[1] && 1<nchair[2]<size(seats)[2]
            flag = flag && seats[nchair...] == 0
            nchair += way
        end
        nchair = chair
    end
    adjs
end


function doround(seats)
    nseats, (rows, cols) = copy(seats), size(seats)
    for x = 2:rows-1, y = 2:cols-1
        seats[x, y] == 0 && continue # Skip floor
        occupied_arount = count(i -> i == 1, adjlist([x, y], seats))
        occupied_arount == 0 && (nseats[x, y] = 1)
        seats[x, y] == 1 && occupied_arount >= 6 && (nseats[x, y] = -1)
    end
    nseats
end


function equali(seats)
    while true
        new_seats = doround(seats)
        new_seats == seats && return count(i -> i == 1, new_seats)
        seats = new_seats
    end
end

input_file = open("input.txt", "r")
seats_raw = readlines(input_file)

seats = zeros(Int8, length(seats_raw)+2, length(seats_raw[1])+2)
[seats[row+1, chair+1] = -1 for row=1:length(seats_raw)
for chair=1:length(seats_raw[1]) if seats_raw[row][chair]=='L']


println(equali(seats))


close(input_file)