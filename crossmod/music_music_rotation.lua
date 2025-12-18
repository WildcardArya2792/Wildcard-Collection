SMODS.Atlas {
  key = "crossmod_musical_deck",
  path = "musical_deck.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "crossmod_musical_deck",
    loc_txt = {
        name = "Musician's Deck",
        text = {
            "{C:attention}Start with an Eternal Negative Album Joker.{}",
            "{C:inactive}Any Albums mod works!{}"
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "crossmod_musical_deck",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local jokers = {}
                for k, v in pairs(G.P_CENTER_POOLS.Joker) do
                    if v.mod and (v.mod.id == 'Albums' or v.mod.id == 'albums2') then
                        table.insert(jokers, v.key)
                    end
                end
                local joker = pseudorandom_element(jokers, 'Musical Chairs')
                SMODS.add_card{ key = joker, stickers = { "eternal" }, edition = "e_negative" , force_stickers = true } 
                return true
            end
        }))
    end
}