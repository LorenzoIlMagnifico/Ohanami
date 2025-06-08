
include("Agent.jl")
using .Agent
"""
player

Contains properties of a player
- `blue_cards`: The number of played blue cards
- `green_cards`: The number of played green cards
- `grey_cards`: The number of played grey cards
- `pink_cards`: The number of played pink cards
- `points`: The number of current points
- `played_cards`: A vector of length 3 containing the 3 stacks of cards being allowed to be played
"""
mutable struct player
    num_cards::Dict{String,Int}
    points::Int
    played_cards::Vector{Vector{card}}
    cards_in_hand::Vector{card}
    removed_cards::Vector{card}
    player_agent::agent
end

"""
function player()
    Creates a player struct
"""
function player()
    played_cards_vec = Vector{Vector{card}}()
    push!(played_cards_vec, Vector{card}())
    push!(played_cards_vec, Vector{card}())
    push!(played_cards_vec, Vector{card}())
    num_cards = Dict{String,Int}()
    num_cards["blue"] = 0
    num_cards["green"] = 0
    num_cards["grey"] = 0
    num_cards["pink"] = 0
    return player(num_cards,0,played_cards_vec,Vector{card}(),Vector{card}(),agent("random"))
end
"""
function player()
    Creates a player struct
"""
function player(strategy::String)
    played_cards_vec = Vector{Vector{card}}()
    push!(played_cards_vec, Vector{card}())
    push!(played_cards_vec, Vector{card}())
    push!(played_cards_vec, Vector{card}())
    num_cards = Dict{String,Int}()
    num_cards["blue"] = 0
    num_cards["green"] = 0
    num_cards["grey"] = 0
    num_cards["pink"] = 0
    return player(num_cards,0,played_cards_vec,Vector{card}(),Vector{card}(),agent(strategy))
end

"""
function get_possible_actions()
    Returns all possible actions in terms of a list of tuples with the first element being the id of the card in hand, second being the stack concerning the move
"""
function get_possible_actions(p::player)
    list_of_moves = Vector{ohanami_action}()
    for (i,playing_card) in enumerate(p.cards_in_hand)
        num = playing_card.num
        push!(list_of_moves, ohanami_action(i,0,playing_card))
        for (j,stack) in enumerate(p.played_cards)
            if length(stack)>1
                if num<stack[1].num || num>stack[end].num
                    push!(list_of_moves,ohanami_action(i,j,playing_card))
                end
            else
                push!(list_of_moves,ohanami_action(i,j,playing_card))
            end
        end
    end
    return list_of_moves
end

"""
function execute_action(g::game, a::ohanami_action, p::player)
    Executes the given action on the game for the given player
"""
function execute_action(a::ohanami_action, p::player)
    card = p.cards_in_hand[a.card_id]
    deleteat!(p.cards_in_hand,a.card_id)
    
    if (a.stack_id==0)
        push!(p.removed_cards,card)
        return true
    end
    stack = p.played_cards[a.stack_id]
    if length(stack)==0
        push!(stack,card)
        p.num_cards[card.color] += 1
        return true
    else
        #either push at top or bottom of stack
        if card.num<stack[1].num #push at bottom
            pushfirst!(stack, card)
            p.num_cards[card.color] += 1
            return true
        elseif  card.num>stack[end].num #push at end
            push!(stack,card)
            p.num_cards[card.color] += 1
            return true
        else
            println("Something bad happened when trying to execute action with card $card on stack $(a.stack_id)")
            println(p)
            return false
        end
    end
    
end


"""
function choose_action(pl::player)
    chooses the action according to the current game state of a player
"""
function Agent.choose_action(p::player)
    choose_action(p.player_agent, p.played_cards, p.cards_in_hand, get_possible_actions(p))
end



"""
function Base.show(io::IO, play::player)
    Custom function used for displaying the information of a player
"""
function Base.show(io::IO, play::player)
    @printf(io,"\n")
    @printf(io,"----------------------\n")
    @printf(io,"Player uses agent %s\n",play.player_agent.agent_type)
    @printf(io, "Player has played:\n")
    @printf(io, "Blue: %d\n",play.num_cards["blue"])
    @printf(io, "Green: %d\n",play.num_cards["green"])
    @printf(io, "Grey: %d\n",play.num_cards["grey"])
    @printf(io, "Pink: %d\n",play.num_cards["pink"])
    @printf(io, "and has points:\n")
    @printf(io, "Points: %d\n",play.points)
    @printf(io, "with stacks:\n")
    for stack in play.played_cards
        if length(stack)>0
            @printf(io, "low: %d",stack[1].num)
            @printf(io, "high: %d\n",stack[end].num)
        else
            @printf(io, "none\n")
        end
    end
    @printf(io,"----------------------\n")
end
