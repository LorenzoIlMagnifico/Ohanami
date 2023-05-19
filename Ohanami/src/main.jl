include("Ohanami.jl")
using .Ohanami
include("Settings.jl")
using Statistics
function do_main()
    g = game(SETTINGS)
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
result_dict = Dict{String,Vector{Int}}()
result_dict["random"] = Vector{Int}()
result_dict["random_pink"] = Vector{Int}()
for i in 1:10000
    g = do_main()
    for play in g.players
        push!(result_dict[play.player_agent.agent_type],play.points)
    end
end

for key in keys(result_dict)
    println(key)
    println(mean(result_dict[key]))
end
#println(g.players)