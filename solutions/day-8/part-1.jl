function run(index::Int)
    comm, val = split(lines[index])
    comm == "nop" && return(index + 1)
    comm == "jmp" && return(index + parse(Int, val))
    comm == "acc" && global accumulator += parse(Int, val); return(index + 1)
end

input_file = open("test.txt", "r")
lines = readlines(input_file)
accumulator, is_read = 0, zeros(length(lines))

index = 1
while is_read[index] == 0
    is_read[index] = 1
    global index = run(index)
end

println(accumulator)
close(input_file)