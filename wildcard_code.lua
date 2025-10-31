--- Load all files from the components folder.

assert(SMODS.load_file("components/blinds.lua"))()
assert(SMODS.load_file("components/boosters.lua"))()
assert(SMODS.load_file("components/challenges.lua"))()
assert(SMODS.load_file("components/consumables.lua"))()
assert(SMODS.load_file("components/decks.lua"))()
assert(SMODS.load_file("components/enhancements.lua"))()
assert(SMODS.load_file("components/jokers.lua"))()
assert(SMODS.load_file("components/joker_quips.lua"))()
assert(SMODS.load_file("components/vouchers.lua"))()

if next(SMODS.find_mod('cardpronouns')) then
    assert(SMODS.load_file("crossmod/FUCKINGPRONOUNS.lua"))() -- https://www.youtube.com/watch?v=VYyPE6EvrqE. Also, trans rights are human rights!
end

if next(SMODS.find_mod('Albums')) and next(SMODS.find_mod('albums2')) then
    assert(SMODS.load_file("crossmod/music_music_rotation.lua"))() -- https://www.youtube.com/watch?v=5-dqH0TRIa4. I'm on that good kush and alcohol.
end