manipulate(subject_number, loop_size) = subject_number ^ loop_size % 20201227

function solve(card_public_key, door_public_key)
    value, card_loop_size, subject_number = 1, 0, 7
    while true
        value *= subject_number
        value = value % 20201227
        card_loop_size += 1
        value == card_public_key && break
    end
    manipulate(door_public_key, card_loop_size)
end

input = parse.(BigInt, readlines("input.txt"))
solve(input...) |> println