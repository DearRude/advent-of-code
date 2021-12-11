const SI = 10

function main()
    octs = fill('0', (SI, SI))
    flashed = fill(false, (SI, SI))
    moves = [(1, 0), (-1, 0), (0, 1), (0, -1),
             (1, 1), (1, -1), (-1, 1), (-1, -1)]
    raw_octs = open("input.txt", "r") |> readlines
    for (li_dx, line) ∈ raw_octs |> enumerate, (ch_dx, char) ∈ line |> enumerate
        octs[li_dx, ch_dx] = char
    end

    function addone(i, j)
        flashed[i, j] && return
        octs[i, j] > '9' || return
        flashed[i, j] = true
        for m ∈ moves
            n_i = i + m[1]; n_j = j + m[2]
            1 <= n_i <= SI && 1 <= n_j <= SI || continue
            octs[n_i, n_j] += 1
            octs[n_i, n_j] > '9' && addone(n_i, n_j)
        end
    end

    for idx ∈ 1:1000
        octs .+= 1
        [addone(i, j) for i∈1:SI, j∈1:SI]
        count(x -> x, flashed) == 100 && (idx |> println; break)
        flashed .= false
        octs[octs .> '9'] .= '0'
    end

end
main()
