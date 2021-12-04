input_file = open("input.txt", "r")
nums = parse.(Int, split(readline(input_file), ","))

boards = split(replace(read(input_file, String), "\n" => " "), " ", keepempty=false)
boards = reshape(parse.(Int, boards), 5, 5, :)
[boards[boards .== x] .= -1 for x in nums[1:4]]

function calcsum(index, num)
    final_board = boards[:, :, index[3]]
    num * sum(final_board[final_board .!= -1]) |> println
end

for num ∈ nums[5:end]
    global boards[boards .== num] .= -1
    horsum = sum(boards, dims=2) .== -5
    any(horsum) && (calcsum(findfirst(x -> x, horsum), num); break)
    versum = sum(boards, dims=1) .== -5
    any(versum) && (calcsum(findfirst(x -> x, versum), num); break)
end
