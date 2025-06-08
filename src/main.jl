using Revise
using Ohanami
include("Settings.jl")
using Statistics


function do_main()
    g = game(SETTINGS)
    play_game!(g)
    return g
end
function do_main(num_players::Int)
    g = game(num_players)
    play_game!(g)
    return g
end
function eval_pink()
    result_dict = Dict{String,Vector{Int}}()
    result_dict["random"] = Vector{Int}()
    result_dict["random_pink"] = Vector{Int}()
    for i in 1:1000
        g = do_main()
        for play in g.players
            push!(result_dict[play.player_agent.agent_type],play.points)
        end
    end

    for key in keys(result_dict)
        println(key)
        println(mean(result_dict[key]))
    end
end

function eval_greedy_vs_pink()
    result_dict = Dict{String,Vector{Int}}()
    result_dict["greedy"] = Vector{Int}()
    result_dict["random_pink"] = Vector{Int}()
    for i in 1:10000
        p1 = player("greedy")
        p2 = player("random_pink")
        g = game([p1,p2])
        play_game!(g)
        @assert g.players[1].player_agent == "greedy"
        push!(result_dict["greedy"],g.players[1].points)
        @assert g.players[2].player_agent == "random_pink"
        push!(result_dict["random_pink"],g.players[2].points)
    end

    for key in keys(result_dict)
        println(key)
        println(mean(result_dict[key]))
    end
end

# p1 = player("greedy")
# p2 = player("random_pink")
# g = game([p1,p2])
# play_game!(g)
# println(g)
#println(g.players)
eval_greedy_vs_pink()