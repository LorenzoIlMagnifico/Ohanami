include("Ohanami.jl")
using .Ohanami
include("Settings.jl")
using Statistics
function do_main()
    g = game(4)
    play_round(g)
    play_round(g)
    play_round(g)
    return g
end
function do_main(num_players::Int)
    g = game(num_players)
    play_round(g)
    play_round(g)
    play_round(g)
    return g
end
result_dict = Dict{Int,Vector{Int}}()
result_dict[1] = Vector{Int}()
result_dict[2] = Vector{Int}()
result_dict[3] = Vector{Int}()
result_dict[4] = Vector{Int}()
for j in 1:100
    for i in 1:4
        g = do_main(i)
        for play in g.players
            push!(result_dict[i],play.points)
        end
    end
end
for i in 1:4
    println("Average result when playing with $i players")
    println(mean(result_dict[i]))
end