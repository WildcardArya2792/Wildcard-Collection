SMODS.Atlas {
  key = "crossmod_lcs_deck",
  path = "lcdirects_deck.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "crossmod_lcs_deck",
    loc_txt = {
        name = "LC's Deck",
        text = {
            "Start with an {C:attention}Eternal LCDirects{} and",
            "{C:attention}2 Hanged Man{} cards.",
            "{C:inactive}Unlocked via installing Yahimod!{}"
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "crossmod_lcs_deck",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card{ set = "Joker", key = "j_yahimod_lcdirects", stickers = { "eternal" }, force_stickers = true }
                SMODS.add_card({ set = 'Tarot', key = 'c_hanged_man'})
                SMODS.add_card({ set = 'Tarot', key = 'c_hanged_man'})
                return true
            end
        }))
    end
}

SMODS.Atlas {
  key = "crossmod_deck_21",
  path = "decktwentyone.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "crossmod_decktwentyone",
    loc_txt = {
        name = "Deck Twenty One",
        text = {
            "Start with an {C:attention}Eternal 21 Kid{}.",
            "{C:attention}All cards are 9s and 10s.{}",
            "{C:inactive}Unlocked via installing Yahimod!{}"
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "crossmod_deck_21",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                  if v.base.suit == 'Hearts' or v.base.suit == 'Diamonds' then
                    SMODS.change_base(v, nil, "10")
                  else
                    SMODS.change_base(v, nil, "9")
                  end
                end
                SMODS.add_card{ set = "Joker", key = "j_yahimod_21kid", stickers = { "eternal" }, force_stickers = true }
                return true
            end
        }))
    end
}

SMODS.Atlas {
  key = "crossmod_budgies_deck",
  path = "budgies_deck.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "crossmod_budgies_deck",
    loc_txt = {
        name = "Budgie's Deck",
        text = {
            "Start with an {C:attention}Eternal Budgie{}.",
            "{C:attention}All cards{} are {C:spades}Spades{} or {C:clubs}Clubs{}.",
            "{C:inactive}Unlocked via installing Yahimod!{}"
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "crossmod_budgies_deck",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                  if v.base.suit == 'Hearts' then
                    v:change_suit('Spades')
                  end
                  if v.base.suit == 'Diamonds' then
                    v:change_suit('Clubs')
                  end
                end
                SMODS.add_card{ set = "Joker", key = "j_yahimod_budgie", stickers = { "eternal" }, force_stickers = true }
                return true
            end
        }))
    end
}

SMODS.Atlas {
  key = "crossmod_yahis_deck",
  path = "deck_of_yahamouse.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "crossmod_yahis_deck",
    loc_txt = {
        name = "Deck Of Yahamouse",
        text = {
            "Start with either {C:attention}Yahiamice{} or",
            "{C:attention}all Twitch-themed Jokers from Yahimod{}.",
            "{C:inactive}Gifted Sub excluded due to conflict with Talisman!{}",
            "{C:inactive}Unlocked via installing Yahimod!{}"
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "crossmod_yahis_deck",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                local yahamouse_chance = math.random(0, 1)
                    if yahamouse_chance >= 0.95 then
                        SMODS.add_card{ set = "Joker", key = "j_yahimod_yahicard"}
                    else
                        SMODS.add_card{ set = "Joker", key = "j_yahimod_twitch"}
                        SMODS.add_card{ set = "Joker", key = "j_yahimod_twitchstream"}
                    end
                return true
            end
        }))
    end
}

SMODS.Atlas {
  key = "crossmod_toasterballs",
  path = "toasterball_overload.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "crossmod_toasterballs",
    loc_txt = {
        name = "Toasterballer Deck",
        text = {
            "Start with two {C:attention}Eternal Toasterballs{}.",
            "{C:inactive}Unlocked via installing Yahimod!{}"
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "crossmod_toasterballs",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card{ set = "Joker", key = "j_yahimod_toasterball", stickers = { "eternal" }, force_stickers = true }
                SMODS.add_card{ set = "Joker", key = "j_yahimod_toasterball", stickers = { "eternal" }, force_stickers = true }
                return true
            end
        }))
    end
}

SMODS.Atlas {
    key = 'kitten_whiskers',
    path = 'kitten_whiskers.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'kitten_whiskers',
    loc_txt = {
        name = "Kitten Whiskers",
        text = {
            "Gains {C:chips}+#1# chips{} and {C:mult}+#2# Mult{}",
            "for every {C:attention}Ace or 7 scored{}.",
            "{C:inactive}(Currently at:{} {C:chips}+#3# Chips{} {C:inactive}and{} {C:mult}+#4# Mult{}{C:inactive}.){}",
            "{C:inactive}Unlocked via installing Yahimod!{}"
        }
    },
    config = { extra = { chips_gain = 10, mult_gain = 1, chips = 0, mult = 0 } },
    atlas = 'kitten_whiskers',
    rarity = 1,
    cost = 4,
    pools = { ["Cat"] = true, ["Yahimodaddition"] = true },
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'yahimod_catcredit', set = 'Other', vars = { "Wildcard Arya" }}
        return {
            vars = { card.ability.extra.chips_gain, card.ability.extra.mult_gain, card.ability.extra.chips, card.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 or context.other_card:get_id() == 14 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = 'miau',
                    colour = G.C.MULT,
                    card = card
                }
            end
        end
    end
}