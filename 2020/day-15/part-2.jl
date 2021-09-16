function calc_until(last_index::Int)::Int
    freq::Dict{Int, Int} = Dict(num=>idx for (idx, num)=enumerate(input[begin:end-1]))
    last_n = input |> last
    for idx in length(input):last_index-1
        temp = idx - get(freq, last_n, idx)
        freq[last_n] = idx
        last_n = temp
    end
    last_n
end

const input = [2,15,0,9,1,20]
calc_until(30000000) |> println
