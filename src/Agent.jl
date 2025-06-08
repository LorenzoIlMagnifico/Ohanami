export choose_action, card, deck, AGENT_DICT

"""
function random_action(actions::Vector{action})
    Returns a random action
"""
function random_action(actions::Vector{<:action}, stack::Vector{Vector{card}}, hand::Vector{card};args::Dict{String,Any}=Dict())
    return rand(actions)
end
"""
function random_pink(actions::Vector{action})
    Returns a random action
"""
function random_pink(actions::Vector{<:action}, stack::Vector{Vector{card}}, hand::Vector{card};args::Dict{String,Any}=Dict())
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


function get_heu_val(stack::Vector{Vector{card}}, act::action)
    if act.stack_id == 0
        # discard action
        return 1000 #TODO this value could be improved but might not be very significant
    end
    s = stack[act.stack_id]
    playing_card = act.card
    if length(s) == 0
        return 60 - playing_card.num
    end
    min_val = s[1].num
    max_val = s[end].num
    if playing_card.num > min_val && playing_card.num < max_val
        return Inf # this is a bad action
    elseif playing_card.num < min_val
        return min_val - playing_card.num
    elseif playing_card.num > max_val
        return playing_card.num - max_val
    else
        println("Error this must not happen in get_heu_val")
    end
end
"""
function greedy_action(actions::Vector{action})
    Returns a greedy action with the lowest distance to a number on the stack
"""
function greedy_action(actions::Vector{<:action}, stack::Vector{Vector{card}}, hand::Vector{card};args::Dict{String,Any}=Dict())
    best_action::action = actions[1]
    best_heu = Inf # first action is always a discard action
    for act in actions
        heu_val = get_heu_val(stack, act)
        if heu_val < best_heu
            best_heu = heu_val
            best_action = act
        end
    end
    return best_action
end


function weighted_heu_val(stack::Vector{Vector{card}}, act::action)
    if act.stack_id == 0
        # discard action
        return 1000 #TODO this value could be improved but might not be very significant
    end
    s = stack[act.stack_id]
    playing_card = act.card
    if length(s) == 0
        return 60 - playing_card.num
    end
    min_val = s[1].num
    max_val = s[end].num
    if playing_card.num > min_val && playing_card.num < max_val
        return Inf # this is a bad action
    elseif playing_card.num < min_val
        return min_val - playing_card.num
    elseif playing_card.num > max_val
        return playing_card.num - max_val
    else
        println("Error this must not happen in get_heu_val")
    end
end
"""
function greedy_action(actions::Vector{action})
    Returns a greedy action with the lowest distance to a number on the stack
"""
function weighted_greedy_action(actions::Vector{<:action}, stack::Vector{Vector{card}}, hand::Vector{card};args::Dict{String,Any}=Dict())
    best_action::action = actions[1]
    best_heu = Inf # first action is always a discard action
    for act in actions
        heu_val = weighted_heu_val(stack, act)
        if heu_val < best_heu
            best_heu = heu_val
            best_action = act
        end
    end
    return best_action
end

const global AGENT_DICT = Dict("random"=>random_action, "random_pink"=> random_pink, "greedy"=> greedy_action, "greedy2"=> weighted_greedy_action)


"""
"""
function choose_action(ag::String, stack::Vector{Vector{card}}, hand::Vector{card}, actions::Vector{<:action})
    return AGENT_DICT[ag](actions, stack, hand)
end
