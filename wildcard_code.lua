--- Load all files from the components folder.

assert(SMODS.load_file("components/blinds.lua"))()
assert(SMODS.load_file("components/boosters.lua"))()
assert(SMODS.load_file("components/consumables.lua"))()
assert(SMODS.load_file("components/decks.lua"))()
assert(SMODS.load_file("components/enhancements.lua"))()
assert(SMODS.load_file("components/jokers.lua"))()
assert(SMODS.load_file("components/joker_quips.lua"))()

if next(SMODS.find_mod('cardpronouns')) then
    assert(SMODS.load_file("crossmod/FUCKINGPRONOUNS.lua"))() -- https://www.youtube.com/watch?v=VYyPE6EvrqE. Also, trans rights are human rights!
end