function do_cycle(st)
    nw_st = falses(size(st) .+ 2)
    nw_st[begin+1:end-1, begin+1:end-1, begin+1:end-1, begin+1:end-1] = st
    dirs = [(x, y, z, w) for x=-1:1, y=-1:1, z=-1:1, w=-1:1 if !(x==y==z==w==0)]
    temp_nw_st = copy(nw_st)
    for x=2:size(nw_st)[1]-1, y=2:size(nw_st)[2]-1, z=2:size(nw_st)[3]-1, w=2:size(nw_st)[4]-1
        around = [nw_st[[x,y,z,w].+dir...] for dir in dirs]
        nw_st[x,y,z,w] && 2<=count(around)<=3 || (temp_nw_st[x,y,z,w] = false)
        !nw_st[x,y,z,w] && count(around)==3 && (temp_nw_st[x,y,z,w] = true)
    end
    temp_nw_st
end

input_file = open("input.txt", "r")
init_state = falses(10, 10, 3, 3)

for (r_idx, row)=input_file|>readlines|>enumerate, (c_idx, entry)=row|>enumerate
    entry=='#' && (init_state[r_idx+1, c_idx+1, 2, 2] = true)
end

for _ in 1:6
   global init_state = do_cycle(init_state)
end

init_state |> count |> println

close(input_file)