function prs_rl(line::String)
    words = split(line)
    outer_bag = join(words[1:2], " ")
    inner_bags = Dict()

    "no" in words && (return outer_bag, inner_bags)
    count_in = count(",", line) + 1

    for inn in 1:count_in
        bag_count = parse(Int, words[4*inn+1])
        bag_name = join(words[4*inn+2: 4*inn+3], " ")
        inner_bags[bag_name] = bag_count
    end

    return outer_bag, inner_bags
end


function in_shiny(outermost::String)::Int
    queue, count = [outermost], 0
    while length(queue) != 0
        for (bg_name, bg_count) in bags[queue[1]]
            count += bg_count
            [bags[bg_name][ig_name] *= bg_count for (ig_name, _) in bags[bg_name]]
        end
        append!(queue, keys(bags[queue[1]]))
        popfirst!(queue)
    end
    return count
end


input_file = open("input.txt", "r")
rules = readlines(input_file)
bags = Dict()

[bags[prs_rl(rule)[1]] = prs_rl(rule)[2] for rule in rules]

println(in_shiny("shiny gold"))

close(input_file)
