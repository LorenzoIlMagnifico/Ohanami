"""
card

Contains properties of a card
- `num`: The number depicted on a card
- `color`: The color of the card
"""
struct card
    num::Int
    color::String
end
"""
function card(num::Int)
    Creates the card with the correct color for a given number
"""
function card(num::Int, mapping::Dict{Int,String})
    return card(num,mapping[num])
end
"""
function deck()
    Creates a so far unused deck of cards
"""
function deck()
    card_deck = Vector{card}()
    num_to_col = card_to_vector_mapping()
    for i in 1:120
        push!(card_deck,card(i,num_to_col))
    end
    return card_deck

end
"""
function card_to_vector_mapping()
    Creates a mapping from num to vector
"""
function card_to_vector_mapping()
    #for debugging "./Ohanami/colors.csv"
    f = open("colors.csv", "r")
    num_to_col = Dict{Int, String}()
    colors = ["grey","pink","green","blue"]
    for i in 1:121
        line = readline(f)
        if i == 1
            continue
        end
        num = parse(Int,split(line,";")[1])
        col = split(line,";")[2]
        if !(col in colors)
            println("Error when reading cols")
            println(num, " ",col," is not in the list of correct colors")
        end
        num_to_col[num] = col
    end
    return num_to_col
    
end