include("Card.jl")
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
    blue_cards::Int
    green_cards::Int
    grey_cards::Int
    pink_cards::Int
    points::Int
    played_cards::Vector{Vector{card}}
    cards_in_hand::Vector{card}
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
    return player(0,0,0,0,0,played_cards_vec,Vector{card}(),agent("random"))
end

"""
function get_possible_actions()
    Returns all possible actions in terms of a list of tuples with the first element being the id of the card in hand, second being the stack concerning the move
"""
function get_possible_actions(p::player)
    list_of_moves = Vector{ohanami_action}()
    for (i,playing_card) in enumerate(p.cards_in_hand)
        num = playing_card.num
        for (j,stack) in enumerate(p.played_cards)
            if length(stack)>1
                if num<stack[1].num || num>stack[end].num
                    push!(list_of_moves,ohanami_action(i,j))
                end
            else
                push!(list_of_moves,ohanami_action(i,j))
            end
        end
    end
    return list_of_moves
end

"""
function choose_action(pl::player)
    chooses the action according to the current game state of a player
"""
function Agent.choose_action(p::player)
    choose_action(p.player_agent, get_possible_actions(p))
end



"""
function Base.show(io::IO, play::player)
    Custom function used for displaying the information of a player
"""
function Base.show(io::IO, play::player)
    @printf(io, "Player has played:\n")
    @printf(io, "Blue: %d\n",play.blue_cards)
    @printf(io, "Green: %d\n",play.green_cards)
    @printf(io, "Grey: %d\n",play.grey_cards)
    @printf(io, "Pink: %d\n",play.pink_cards)
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
    
end
