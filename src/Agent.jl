module Agent
include("Action.jl")
export agent, choose_action,action, ohanami_action, card, deck
"""
agent

The agent that choses an action
- `agent_type`: way to chose an action
- `color`: The color of the card
"""
struct agent
    agent_type::String
end

"""
function random_action(actions::Vector{action})
    Returns a random action
"""
function random_action(actions::Vector{<:action}, stack::Vector{Vector{card}}, hand::Vector{card})
    return rand(actions)
end
"""
function random_pink(actions::Vector{action})
    Returns a random action
"""
function random_pink(actions::Vector{<:action}, stack::Vector{Vector{card}}, hand::Vector{card})
    pink_actions = Vector{ohanami_action}()
    for act in actions
        playing_card = act.card
        if playing_card.color == "pink"
            push!(pink_actions,act)
        end
    end
    if length(pink_actions) >= 1
        return rand(pink_actions)
    end
    return rand(actions)
end

"""
function greedy_action(actions::Vector{action})
    Returns a greedy action with the lowest distance to a number on the stack
"""
function greedy_action(actions::Vector{<:action}, stack::Vector{Vector{card}}, hand::Vector{card})
    
end

AGENT_DICT = Dict("random"=>random_action, "random_pink"=> random_pink, "greedy"=> greedy_action)

function choose_action(ag::agent, stack::Vector{Vector{card}}, hand::Vector{card}, actions::Vector{<:action})
    return AGENT_DICT[ag.agent_type](actions, stack, hand)
end

end #module