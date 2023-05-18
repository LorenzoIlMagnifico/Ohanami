module Agent
include("Action.jl")
export agent, choose_action,action, ohanami_action
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
function random_action(actions::Vector{<:action})
    return rand(actions)
end

AGENT_DICT = Dict("random"=>random_action)

function choose_action(ag::agent, actions::Vector{<:action})
    return AGENT_DICT[ag.agent_type](actions)
end

end #module