input = readlines("input.txt")

function parse_input(input)
    ridx, sidx = findfirst(x->x=="", input) .+ [-1, 1]
    rules = Dict(map(input[1:ridx]) do line
        m = match(r"^(\d+): (\"(\w+)\"|([^|]+)|(.+))$", line)
        m[1] => !isnothing(m[3]) ? m[3] : !isnothing(m[4]) ? m[4] : "(?:$(m[5]))"
    end)
    rules, input[sidx:end]
end

function get_rule(rules, idx)
    rule = rules[idx]
    nr = [r.match for r = eachmatch(r"\b\d+\b", rule)]
    res = [Regex("\\b$r\\b") for r = nr]
    rep = [get_rule(rules, r) for r = nr]
    replace(reduce(replace, res .=> rep, init = rule), " " => "")
end

rules, strs = parse_input(input)

ans = begin
    r42, r31 = get_rule.(Ref(rules), ["42", "31"])
    count(contains(Regex("^$r42+($r42(?1)?$r31)\$")), strs)
end

ans |> println