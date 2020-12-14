using Combinatorics

input_file = open("input.txt", "r")
storage = Dict()
for line in readlines(input_file)
    line[1:4] == "mask" && (global mask = line[8:end])!=0 && continue
    store = SubString.(line, findall(r"\d+", line))
    masked = parse(Int, store[1]) | parse(Int, replace(mask, 'X'=> '0'), base=2)
    masked &= parse(Int, replace(replace(mask, '0'=>'1'), 'X'=>'0'), base=2)
    possible = findall(x -> x=='X', mask) |> powerset
    for mas in possible
        num = masked | parse(Int, [(bit ∈ mas ? '1' : '0') for bit=1:36] |> join, base=2)
        storage[num] = parse(Int, store[2])
    end
end

storage |> values |> sum |> println

close(input_file)