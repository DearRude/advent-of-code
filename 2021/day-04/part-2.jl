input_file = open("input.txt", "r")
nums = parse.(Int, split(readline(input_file), ","))

boards = split(replace(read(input_file, String), "\n" => " "), " ", keepempty=false)
boards = reshape(parse.(Int, boards), 5, 5, :)
board_count = size(boards)[3]
[boards[boards .== x] .= -1 for x in nums[1:4]]


function calcsum(index, idx)
    board = boards[:, :, index]
    for num ∈ nums[idx:end]
        board[board .== num] .= -1
        if any(sum(board, dims=1) .== -5) || any(sum(board, dims=2) .== -5)
            num * sum(board[board .!= -1]) |> println
            break
        end
    end
end

for (idx, num) ∈ nums[5:end] |> enumerate
    global boards[boards .== num] .= -1
    horsum = sum(boards, dims=2) .== -5
    any(horsum) && [global boards[:, :, x[3]] .= -5 for x ∈ findall(x -> x, horsum)]
    versum = sum(boards, dims=1) .== -5
    any(versum) && [global boards[:, :, x[3]] .= -5 for x ∈ findall(x -> x, versum)]
    count(x -> sum(boards[:, :, x]) != -125, 1:board_count) == 1 &&
        (calcsum(findfirst(x -> sum(boards[:, :, x]) != -125, 1:board_count), idx); break)
end
