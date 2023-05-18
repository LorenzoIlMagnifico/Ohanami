include("Ohanami.jl")
using .Ohanami
include("Settings.jl")
function do_main()
    g = game(2)
    println(g.deck)
    play_round(g)
    #println(card("3"))
    #println(player("3"))
end
do_main()