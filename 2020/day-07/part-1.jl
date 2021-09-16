function prs_rl(line::String)
    words = split(line)
    outer_bag = join(words[1:2], " ")
    "no" in words && (return outer_bag, [])
    count_in = count(",", line) + 1
    inner_bags = [join(words[4*inn+2: 4*inn+3], " ") for inn in 1:count_in]
    return outer_bag, inner_bags
end

function shiny_in(innermost::String)::Bool
    queue = [innermost]
    while length(queue) != 0
        "shiny gold" in bags[queue[1]] && return true
        append!(queue, bags[queue[1]])
        popfirst!(queue)
    end
    return false
end


input_file = open("input.txt", "r")
rules = readlines(input_file)
bags = Dict()

[bags[prs_rl(rule)[1]] = prs_rl(rule)[2] for rule in rules]

println(count(shiny_in(bag) for bag in keys(bags)))


close(input_file)