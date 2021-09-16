function run(index::Int, codes)
    comm, val = split(codes[index])
    comm == "nop" && return(index + 1)
    comm == "jmp" && return(index + parse(Int, val))
    comm == "acc" && global accumulator += parse(Int, val); return(index + 1)
end

function finite(change::Int)::Bool
    index, codes = 1, copy(lines)
    if codes[change][1:3] == "nop"
        codes[change] = replace(codes[change], "nop" => "jmp")
    elseif codes[change][1:3] == "jmp"
        codes[change] = replace(codes[change], "jmp" => "nop")
    end
    while is_read[index] == 0
        is_read[index] = 1
        index = run(index, codes)
        index > length(codes) && return true
    end
    return false
end

input_file = open("input.txt", "r")
lines = readlines(input_file)
accumulator, is_read = 0, zeros(length(lines))

for (idx, _) in enumerate(lines)
    finite(idx) && println(accumulator)
    global accumulator = 0
    global is_read = zeros(length(lines))
end

close(input_file)