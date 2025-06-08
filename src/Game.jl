



export game, play_game!

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
    round_num::Vector{Int}
    settings::Dict{String,Any}
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
    g = game(num_player, player_vec, deck(),[1],Dict{String,Any}())
    shuffle_deck!(g)
    return g
end
function game(player_vec::Vector{player})
    g = game(length(player_vec), player_vec, deck(),[1],Dict{String,Any}())
    shuffle_deck!(g)
    return g
end
function game(settings::Dict{String,Any})
    player_vec = Vector{player}()
    for i in 1:settings["num_players"]
        push!(player_vec,player(settings["players"][i]))
    end
    g = game(settings["num_players"],player_vec,deck(),[1],settings)
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
function evaluate_round(g::game)
    Evaluates the round of a game
"""
function evaluate_round(g::game)
    for p in g.players
        p.points += 3*p.num_cards["blue"]
        if g.round_num[1] >= 2
            p.points += 4*p.num_cards["green"]
        end
        if g.round_num[1] >= 3
            p.points += 7*p.num_cards["grey"]
            p.points += floor(Int,((p.num_cards["pink"]*(p.num_cards["pink"]+1))/2)+0.5)
        end
    end
end

"""
function hand_cards_around(g::game)
    Hands the cards to the next player
"""
function hand_cards_around(g::game)
    original_hand = g.players[1].cards_in_hand
    if length(g.players) == 1
        return
    end
    for player_id in 2:length(g.players)
        next_hand = g.players[player_id].cards_in_hand
        g.players[player_id].cards_in_hand = original_hand
        original_hand = next_hand
    end
    g.players[1].cards_in_hand = original_hand
end
"""
function play_round(g::game)
    plays a round of the game g meaning 10 cards are dealt and each player choses 2 cards for 5 turns until round is over
"""
function play_round!(g::game)
    #every player draws 10 cards
    draw_new_hand(g)
    for i in 1:5
        #for 5 rounds 
        for play in g.players
            #choose 2 cards in hand and play them
            action = choose_action(play, g)
            execute_action(action, play)
            action = choose_action(play, g)
            execute_action(action, play)
            #hand cards to next player  
        end
        hand_cards_around(g)
    end
    #rate the round
    evaluate_round(g)
    g.round_num[1] += 1
end

function play_game!(g::game)
    play_round!(g)
    play_round!(g)
    play_round!(g)
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

function construct_args(p::player, g::game)
    return Dict{String,Any}("player" => p, "game" => g)
end

"""
function choose_action(pl::player)
    chooses the action according to the current game state of a player
"""
function choose_action(p::player, g::game)
    actions = get_possible_actions(p)
    stack = p.played_cards
    hand = p.cards_in_hand
    return AGENT_DICT[p.player_agent](actions, stack, hand, args = construct_args(p, g))
end