

export action, ohanami_action

abstract type action end
struct ohanami_action <: action
    card_id::Int
    stack_id::Int
    card::card
end