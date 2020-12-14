input_file = open("input.txt", "r")

storage = Dict()
for line in readlines(input_file)
    line[1:4] == "mask" && (global mask = line[8:end])!=0 && continue
    store = SubString.(line, findall(r"\d+", line))
    masked = parse(Int, store[2]) | parse(Int, replace(mask, 'X' =>'0'), base=2)
    masked &= parse(Int, replace(mask, 'X' =>'1'), base=2)
    storage[store[1]] = masked
end

storage |> values |> sum |> println

close(input_file)