using Random
using Printf

Random.seed!(10)

SETTINGS = Dict{String,Any}()
SETTINGS["num_players"] = 4
SETTINGS["players"] = ["random","random_pink","random_pink","random_pink"]