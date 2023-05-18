

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
    round_num::Int
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
    g = game(num_player, player_vec, deck(), Vector{card}(),1)
    shuffle_deck!(g)
    return g
end
"""
function shuffle_deck!(g::game)
    shuffles the deck of a game
"""
function shuffle_deck!(g::game)
    shuffle!(g.deck)
end

"""
function play_round(g::game)
    Overall logic to play a round
"""
function play_round(g::game)
    #every player draws 10 cards
    draw_new_hand(g)
    for play in g.players
        println("Cards in hand:\n")
        println(play.cards_in_hand)
        println(get_possible_actions(play))
    end
    #for 5 rounds 
    #choose 2 cards in hand 
    #hand cards to next player
    #repeat
    #rate the round
end


"""
function draw_new_hand(g)
    Draws 10 cards for each player
"""
function draw_new_hand(g::game)
    for player in g.players
        new_hand = Vector{card}()
        for i in 1:10
            push!(new_hand,pop!(g.deck))
        end
        player.cards_in_hand = new_hand
    end
end