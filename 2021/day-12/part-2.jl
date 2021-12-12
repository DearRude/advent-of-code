using DataStructures: DefaultDict

function main()
    lines = DefaultDict{String, Vector{String}}([])
    for line ∈ open("input.txt", "r") |> readlines
        a, b = split(line, "-")
        push!(lines[a], b)
        push!(lines[b], a)
    end

    visited = DefaultDict{String, Int}(0)
    function search(loc)
        loc == "end" && (return 1)
        small_visited = any(>(1), (v for (k, v) ∈ visited if k[1] ∈ 'a':'z'))
        loc[1] ∈ 'a':'z' && visited[loc] > 0 && small_visited && (return 0)
        visited[loc] += 1
        ret = sum(search(next) for next ∈ lines[loc] if next != "start")
        visited[loc] -= 1
        return ret
    end
    search("start") |> println
end
main()
