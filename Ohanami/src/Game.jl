

include("Player.jl")

"""
game

Contains parameters of a game
- `number_of_players`: Int describing how many players there are
- `players`: A vector containing the players 1 up to number_of_players
- `deck`: The current deck of cards that is played with
- `removed_cards`: The cards not on a players board that were removed

"""
struct game
    number_of_players::Int
    players::Vector{player}
    deck::Vector{card}
    removed_cards::Vector{card}
end
"""
function game(num_player::Int)
    Creates a game struct to be interacted with when playing
"""
function game(num_player::Int)
    player_vec = Vector{player}()
    for i in 1:num_player
        push!(player_vec,player())
    end
    return game(num_player, player_vec, deck(), Vector{card}())
end