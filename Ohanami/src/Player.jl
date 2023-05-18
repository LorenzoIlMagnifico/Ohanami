include("Card.jl")
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
    return player(0,0,0,0,0,played_cards_vec)
end