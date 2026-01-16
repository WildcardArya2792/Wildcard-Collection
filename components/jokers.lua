local rainbow_gradient = SMODS.Gradient { 
  key = "rarity_gradient",
  colours = { 
    HEX('FF0000'), -- https://www.youtube.com/watch?v=KSoCld6kVKE
    HEX('FFA500'),
    HEX('FFFF00'),
    HEX('00FF00'),
    HEX('0000FF'),
    HEX('7800FF'),
  },
  cycle = 3
}

SMODS.Rarity {
  key = "wc_rarity",
  loc_txt = {
    name = "Wildcard Agent"
  },
  badge_colour = rainbow_gradient
}

SMODS.Rarity {
  key = "cursed_rarity",
  loc_txt = {
    name = "Shadow Self"
  },
  badge_colour = HEX('000000')
}

local crossover_rarity = SMODS.Gradient { 
  key = "rarity_crossover",
  colours = { 
    HEX('00FFFF'), -- https://www.youtube.com/watch?v=KSoCld6kVKE
    HEX('FF00FF'),
    HEX('FFFFFF'),
    HEX('FF00FF'),
    HEX('00FFFF'),
  },
  cycle = 5
}

SMODS.Rarity {
  key = "crossover_rarity",
  loc_txt = {
    name = "Crossover Exclusive"
  },
  badge_colour = crossover_rarity
}

----- JOKER CODE -----

-- Arya (Common)
-- Effect: Each 7 played gives +7 Chips & +7 Mult
SMODS.Atlas {
  key = "common_arya",
  path = "Arya_CommonRarity.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
    key = 'common_arya',
    loc_txt = {
      name = 'Arya',
      text = {
        "Each {C:attention}scored 7{}",
        "gives {C:chips}+#1# Chips{} and",
        "{C:mult}+#2# Mult{} when scored"
      }
    },
    config = { extra = { chips = 7, mult = 7 } },
    rarity = 1,
    discovered = true,
    atlas = 'common_arya',
    blueprint_compat = true,
    pos = { x = 0, y = 0 },
    cost = 5,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        -- :get_id tests for the rank of the card. Other than 2-10, Jack is 11, Queen is 12, King is 13, and Ace is 14.
        if context.other_card:get_id() == 7 then
          -- Specifically returning to context.other_card is fine with multiple values in a single return value, chips/mult are different from chip_mod and mult_mod, and automatically come with a message which plays in order of return.
        return {
          chips = card.ability.extra.chips,
          mult = card.ability.extra.mult,
          card = context.other_card
        }
      end
    end
  end
}

-- Lucky Woman Arya (Uncommon)
-- Effect: Each 7 or Ace played has a 1 in 10 chance to become Lucky.

SMODS.Atlas {
  key = "uncommon_arya",
  path = "Arya_UncommonRarity.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'uncommon_arya',
  loc_txt = {
    name = 'Lucky Woman Arya',
    text = {
      "{C:green}#1# in #2# chance{} for {C:attention}scored 7s{}",
      "to become a {C:attention}Lucky Card.{}"
    }
  },
  config = { extra = { odds = 7 } },
  rarity = 2,
  discovered = true,
  atlas = 'uncommon_arya',
  pos = { x = 0, y = 0 },
  blueprint_compat = true,
  cost = 7,
  -- CODE FROM 0614a: return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  loc_vars = function(self, info_queue, card)
    local numerAryaUncommon, denomAryaUncommon = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'uncommonAryaProbCheck')
    return {vars = {numerAryaUncommon, denomAryaUncommon } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if SMODS.pseudorandom_probability(card, 'Bitch, where you when I was walkin?', 1, card.ability.extra.odds, 'uncommonAryaProbCheck') then
        for k, v in pairs(context.full_hand) do
          if context.other_card:get_id() == 7 then
            return {
              context.other_card:set_ability(G.P_CENTERS.m_lucky, nil, true)
            }
          end
        end
      end
    end
  end
}

-- Arya The Gambler (Rare)
-- Effect: Gives x? Mult, but has a 1 in 5 chance to be destroyed.

SMODS.Atlas {
  key = "rare_arya",
  path = "Arya_RareRarity.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'rare_arya',
  loc_txt = {
    name = 'Arya The Gambler',
    text = {
      "Gives {X:mult,C:white} x?? {} {C:mult}Mult{}, but has a",
      "{C:green}#1# in #2# chance{} to be destroyed.",
      "{C:inactive}''Roll those dice! You surely cannot lose!''{}"
    }
  },
  config = { extra = { Xmult_mod = temp_Mult, odds = 5 } },
  rarity = 3,
  atlas = 'rare_arya',
  discovered = true,
  blueprint_compat = true,
  pos = { x = 0, y = 0 },
  cost = 9,
  loc_vars = function(self, info_queue, card)
    local numerAryaRare, denomAryaRare = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'rareAryaProbCheck')
    return {vars = {numerAryaRare, denomAryaRare, card.ability.extra.Xmult_mod } }
    --return { vars = { card.ability.extra.Xmult_mod, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local temp_Mult = pseudorandom('Arya The Gambler', 1, 10)
      return {
        message = localize{type='variable',key='a_xmult',vars={temp_Mult}},
        Xmult_mod = temp_Mult
      }
    end

    -- Checks to see if it's end of round, and if context.game_over is false.
    -- Also, not context.repetition ensures it doesn't get called during repetitions.
    if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
      -- Another pseudorandom thing, randomly generates a decimal between 0 and 1, so effectively a random percentage.
      if SMODS.pseudorandom_probability(card, "I've been going through something. 1855 days. I've been going through something. Be afraid.", 1, card.ability.extra.odds, 'rareAryaProbCheck') then
        -- This part plays the animation.
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            -- This part destroys the card.
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.3,
              blockable = false,
              func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
                return true;
              end
            }))
            return true
          end
        }))
        return {
          message = 'Lost The Draw!'
        }
      else
        return {
          message = 'Jackpot!'
        }
      end
    end
  end
}

-- Golden Ticket Arya (Legendary)
-- Effect: Each scored Ace or 7 gives x1 to this Joker.

SMODS.Atlas {
  key = "legendary_arya",
  path = "Arya_LegendaryRarity.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'legendary_arya',
  loc_txt = {
    name = 'Golden Ticket Arya',
    text = {
      "Gains {X:mult,C:white} X#2# {} {C:mult}Mult{}",
      "for every {C:attention}scored Ace or 7{}.",
      "{C:inactive} (Current xMult:{} {X:mult,C:white} X#1# {} {C:inactive}Mult){}"
    }
  },
  config = { extra = { x_mult = 1, x_mult_gain = 1 } },
  rarity = 4,
  cost = 20,
  atlas = 'legendary_arya',
  discovered = true,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult, card.ability.extra.x_mult_gain } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        Xmult_mod = card.ability.extra.x_mult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
      }
    end
    if context.cardarea == G.play and context.other_card and (context.other_card:get_id() == 14 or context.other_card:get_id() == 7) and not context.repetition then
      card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
      return {
        message = 'Power Up!',
        colour = G.C.XMULT,
        card = card
      }
    end
  end
}

-- Arya. Dea Del Gioco D'azzardo (Custom Rarity: Wildcard)
-- Wildcard Perk: "Roll To Win"
-- Perk Effect: 1 in 5 chance to automatically win the blind.
-- BG Song: Devil's Casino - Vane Lily

SMODS.Atlas {
  key = "goddess_arya",
  path = "Arya_RainbowBackingAndSoul.png",
  px = 71, -- REWORKED FOR 71 x 95 in Release 3!
  py = 95
}

SMODS.Joker {
  key = 'goddess_arya',
  loc_txt = {
    name = "Arya, Dea Del Gioco D'azzardo", -- This is Italian, in case you wanna translate it.
    text = {
      "{C:green}#1# in #2# chance{} to",
      "{C:attention}automatically win the current Blind.{}",
      "{C:dark_edition} Passive Ability:{} Each scored card gives {X:purple,C:white}^#3#{} {C:mult}Mult.{}",
      "{C:inactive}''Think you can play with the big dogs? Let's see what you got.''{}"
    }
  },
  config = { extra = { odds = 25, e_mult = 2 } },
  rarity = 'WCCO_wc_rarity',
  atlas = 'goddess_arya',
  blueprint_compat = true,
  pos = { x = 0, y = 0 },
  soul_pos = { x = 1, y = 0 },
  cost = 100, -- This is meant to deter people from using Equilibrium Deck to grab this.
  loc_vars = function(self, info_queue, card)
    local numerAryaGoddess, denomAryaGoddess = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'goddessAryaProbCheck')
    return {vars = {numerAryaGoddess, denomAryaGoddess, card.ability.extra.e_mult } }
    -- return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.e_mult } }
  end,
  in_pool = function(self)
    return not G.GAME.WCCO_present
  end,
  add_to_deck = function(self)
    G.GAME.WCCO_present = true
  end,
  remove_from_deck = function(self)
    G.GAME.WCCO_present = false
  end,
  calculate = function(self, card, context)
    if context.setting_blind and context.main_eval then
      if SMODS.pseudorandom_probability(card, "Cause you lied about religious views, you lied about your surgery, your past tense, all is perjury.", 1, card.ability.extra.odds, 'goddessAryaProbCheck') then
        G.E_MANAGER:add_event(Event({
          blocking = false,
          func = function()
            if G.STATE == G.STATES.SELECTING_HAND then
              G.GAME.chips = G.GAME.blind.chips
              G.STATE = G.STATES.HAND_PLAYED
              G.STATE_COMPLETE = true
              end_round()
              return true
            end
          end
        }))
      end
    end
    if context.cardarea == G.play and context.other_card and not context.repetition then
      return {
        e_mult = card.ability.extra.e_mult -- This shit powerful!
      }
    end
  end
}

-- Ember (Common)
-- Effect: Each scored Heart card gives +3 Mult to Ember.

SMODS.Atlas {
  key = "common_ember",
  path = "Ember_CommonRarity.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'common_ember',
  loc_txt = {
    name = 'Ember',
    text = {
      "Gains {C:mult}+#2# Mult{} for",
      "each {C:attention}scored{} {C:hearts}Heart{} card",
      "{C:inactive}(Currently at:{} {C:mult}+#1# Mult.{}{C:inactive}){}"
    }
  },
  config = { extra = { mult = 0, mult_gain = 1 } },
  rarity = 1,
  discovered = true,
  cost = 5,
  atlas = 'common_ember',
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
    if context.cardarea == G.play and context.other_card and context.other_card:is_suit("Hearts") and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
      return {
        message = 'Power Up!',
        colour = G.C.MULT,
        card = card
      }
    end
  end
}

-- Powered-Up Ember (Uncommon)
-- Effect: Each Heart card has a 1 in 5 chance to become a Mult Card.

SMODS.Atlas {
  key = "uncommon_ember",
  path = "Ember_UncommonRarity.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'uncommon_ember',
  loc_txt = {
    name = 'Powered-Up Ember',
    text = {
      "{C:green}#1# in #2# chance{} for {C:attention}scored{} {C:hearts}Heart{}",
      "cards to become a {C:mult}Mult Card{}."
    }
  },
  config = { extra = { odds = 5 } },
  rarity = 2,
  discovered = true,
  atlas = 'uncommon_ember',
  pos = { x = 0, y = 0 },
  blueprint_compat = true,
  cost = 7,
  loc_vars = function(self, info_queue, card)
    local numerEmberUncommon, denomEmberUncommon = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'uncommonEmberProbCheck')
    return {vars = {numerEmberUncommon, denomEmberUncommon } }
    -- return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if SMODS.pseudorandom_probability(card, "SESBIAN LEX", 1, card.ability.extra.odds, 'uncommonEmberProbCheck') then
        for k, v in pairs(G.jokers.cards) do
          if context.other_card:is_suit("Hearts") then
            return {
              context.other_card:set_ability(G.P_CENTERS.m_mult, nil, true)
            }
          end
        end
      end
    end
  end
}

-- Ember The Subject (Rare)
-- Effect: Each scored Queen adds +10 Mult to Ember.

SMODS.Atlas {
  key = "rare_ember",
  path = "Ember_RareRarity.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'rare_ember',
  loc_txt = {
    name = 'Ember The Subject',
    text = {
      "Gains {C:mult}+#2# Mult{} for",
      "each {C:attention}scored{} {C:attention}Queen{} card",
      "{C:inactive}(Currently at:{} {C:mult}+#1# Mult.{}{C:inactive}){}"
    }
  },
  config = { extra = { mult = 0, mult_gain = 10 } },
  rarity = 3,
  cost = 9,
  discovered = true,
  atlas = 'rare_ember',
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
    if context.cardarea == G.play and context.other_card and context.other_card:get_id() == 12 and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
      return {
        message = 'Power Up!',
        colour = G.C.MULT,
        card = card
      }
    end
  end
}

-- Bloody Yandere Ember (Legendary)
-- Effect: Each Queen played gains +20 Mult

SMODS.Atlas {
  key = "legendary_ember",
  path = "Ember_LegendaryRarity.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'legendary_ember',
  loc_txt = {
    name = 'Bloody Yandere Ember',
    text = {
      "Each {C:attention}scored{} {C:attention}Queen{} gains",
      "{C:mult}+20 Mult{} when scored."
    }
  },
  atlas = 'legendary_ember',
  config = { extra = { perma_mult = 20 } },
  rarity = 4,
  cost = 10,
  discovered = true,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 then
      context.other_card.ability.perma_mult = context.other_card.ability.perma_mult
      context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.perma_mult
      return {
        extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT },
        card = card -- CARD IS CARD
      }
    end
  end
}

-- Ember, Spirit Of The Hunt (Custom Rarity: Wildcard)
-- Wildcard Perk: "Goddess's Sacrifice"
-- Perk Effect: Sacrifices ALL Jokers besides any Arya Joker at the start of a round. Levels up Two Pair 5 times for each Joker sacrificed.
-- BG Song: Ruthlessness - Jorge Rivera-Herrans

SMODS.Atlas {
  key = "youre_so_portugese",
  path = "Ember_VDBackingAndSoul.png", -- REWORKED FOR 71 x 95 in Release 3!
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'youre_so_portugese',
  loc_txt = {
    name = "Ember, Spirit Of The Hunt",
    text = {
      "{C:attention}At the start of the Blind,{}",
      "{C:attention,s:2.0,E:1}SACRIFICES ALL JOKERS HELD!{}",
      "{C:inactive}(...except Wildcard Collection Jokers.){}",
      "For each Joker sacrificed: Level up {C:planet}Two Pair{} by {C:attention}5.{}",
      "{C:inactive}''Time to cull the weak for the goddess!''{}"
    }
  },
  config = { extra = { } }, -- Hope this can be empty. If not, we're fucked.
  rarity = 'WCCO_wc_rarity',
  atlas = 'youre_so_portugese',
  blueprint_compat = true,
  pos = { x = 0, y = 0 },
  soul_pos = { x = 1, y = 0 },
  cost = 1000, -- This is meant to deter people from using Equilibrium Deck to grab this.
  loc_vars = function(self, info_queue, card)
    return { vars = { } } -- Hope this can be empty. If not, we're fucked.
  end,
  calculate = function(self, card, context)
    if context.setting_blind and context.main_eval then
      G.E_MANAGER:add_event(Event({
        blocking = false,
        func = function()
          if G.STATE == G.STATES.SELECTING_HAND then
            for k, v in pairs(G.jokers.cards) do
              if not (v.config.center.mod and v.config.center.mod.id == "WCCollection") then
                v:start_dissolve()
                level_up_hand(card, 'Two Pair', instant, 5)
              end
            end
            return true
          end
        end
      }))
    end
  end
}

SMODS.Atlas {
  key = "common_delta",
  path = "Delta_Common.png",
  px = 71,
  py = 95 
}

SMODS.Joker {
  key = "common_delta",
  loc_txt = {
    name = "Delta",
    text = {
      "{C:attention}+#1#{} hand size."
    }
  },
  rarity = 1,
  cost = 4,
  atlas = "common_delta",
  blueprint_compat = false,
  discovered = true,
  pos = { x = 0, y = 0 },
  config = { extra = { h_size = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.h_size } }
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end
}

SMODS.Atlas {
  key = "uncommon_delta",
  path = "Delta_Uncommon.png",
  px = 71,
  py = 95 
}

SMODS.Joker {
  key = "uncommon_delta",
  loc_txt = {
    name = "Optimized Delta",
    text = {
      "{C:attention}90%{} blind requirement."
    }
  },
  rarity = 2,
  cost = 6,
  atlas = "uncommon_delta",
  blueprint_compat = false,
  discovered = true,
  pos = { x = 0, y = 0 },
  calculate = function(self, card, context)
    if context.setting_blind and context.main_eval then
      G.E_MANAGER:add_event(Event({
        blocking = false,
        func = function()
          G.GAME.blind.chips = math.floor(G.GAME.blind.chips - G.GAME.blind.chips * 0.1)
          G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
          return true
        end
      }))
    end
  end
}

SMODS.Atlas {
  key = "rare_delta",
  path = "Delta_Rare.png",
  px = 71,
  py = 95 
}

SMODS.Joker {
  key = "rare_delta",
  loc_txt = {
    name = "Delta, Recon Specialist",
    text = {
      "{C:blue}+#2# hands{} and {C:red}+#1# discard{}."
    }
  },
  rarity = 3,
  cost = 8,
  atlas = "rare_delta",
  blueprint_compat = false,
  discovered = true,
  pos = { x = 0, y = 0 },
  config = { extra = { hands = 2, d_size = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.d_size, card.ability.extra.hands } }
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
    ease_hands_played(card.ability.extra.hands)
    ease_discard(card.ability.extra.d_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    ease_hands_played(-card.ability.extra.hands)
    ease_discard(-card.ability.extra.d_size)
  end
}

SMODS.Atlas {
  key = "legendary_delta",
  path = "Delta_Legendary.png",
  px = 71,
  py = 95 
}

SMODS.Joker {
  key = "legendary_delta",
  loc_txt = {
    name = "Replay Attack Delta",
    text = {
      "{C:attention}Retrigger all scored cards #1# times{}."
    }
  },
  rarity = 4,
  cost = 10,
  atlas = "legendary_delta",
  blueprint_compat = true,
  discovered = true,
  pos = { x = 0, y = 0 },
  config = { extra = { repetitions = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.repetitions } }
  end,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
      return {
        repetitions = card.ability.extra.repetitions
      }
    end
  end
}

SMODS.Atlas {
  key = "not_every_geek_has_a_commodore_64",
  path = "Delta_CodeBackgroundAndSoul.png", 
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'not_every_geek_has_a_commodore_64',
  loc_txt = {
    name = "Delta, Zero-Day Liability",
    text = {
      "{C:attention}50% blind requirement{} and",
      "{C:attention}retriggers all scored cards #1# times.{}",
      '{C:inactive}"Stay out of my way. I have work to do."{}'
    }
  },
  config = { extra = { repetitions = 5 } },
  rarity = 'WCCO_wc_rarity',
  atlas = 'not_every_geek_has_a_commodore_64',
  blueprint_compat = true,
  pos = { x = 0, y = 0 },
  soul_pos = { x = 1, y = 0 },
  cost = 1000, -- This is meant to deter people from using Equilibrium Deck to grab this.
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.repetitions } }
  end,
  calculate = function(self, card, context)
    if context.setting_blind and context.main_eval then
      G.E_MANAGER:add_event(Event({
        blocking = false,
        func = function()
          G.GAME.blind.chips = math.floor(G.GAME.blind.chips - G.GAME.blind.chips * 0.5)
          G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
          return true
        end
      }))
    end
    if context.repetition and context.cardarea == G.play then
      return {
        repetitions = card.ability.extra.repetitions
      }
    end
  end
}

-- Ghost and Pals Pack Jokers

SMODS.Atlas {
  key = "gap_scapegoat_texture",
  path = "GAP_SCAPEGOAT.png",
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'gap_scapegoat',
  loc_txt = {
    name = "Culpable Scapegoat",
    text = {
      'Prevents {C:attention}death{} once before {C:attention}self-destructing.{}',
      "{C:inactive}Part of the GHOST and Pals Subpack!{}"
    }
  },
  rarity = 'WCCO_crossover_rarity',
  atlas = 'gap_scapegoat_texture',
  blueprint_compat = false,
  eternal_compat = false,
  pos = { x = 0, y = 0 },
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context)
    if context.end_of_round and context.game_over and context.main_eval then
      G.E_MANAGER:add_event(Event({
        func = function()
          G.hand_text_area.blind_chips:juice_up()
          G.hand_text_area.game_chips:juice_up()
          play_sound('tarot1')
          card:start_dissolve()
          return true
        end
      }))
      return {
        message = "Are you able to feel culpability?",
        saved = 'GAP_SaveMessage',
        colour = G.C.RED
      }
    end
  end
}

SMODS.Atlas {
  key = 'gap_distortionist',
  path = 'GAP_Distortionist.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'gap_distortionist',
  loc_txt = {
    name = "Manipulative Distortionist",
    text = {
      "{C:green}#1# in #2# chance{} to",
      "{C:attention}destroy discarded cards.{}",
      "{C:inactive}Part of the GHOST and Pals Subpack!{}"
    }
  },
  rarity = 'WCCO_crossover_rarity',
  atlas = 'gap_distortionist',
  blueprint_compat = false,
  pos = { x = 0, y = 0 },
  config = { extra = { odds = 5 } },
  loc_vars = function(self, info_queue, card)
    local numerGAP_Distortionist, denomGAP_Distortionist = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'uncommonGAP_DistortionistProbCheck')
    return {vars = {numerGAP_Distortionist, denomGAP_Distortionist } }
    -- return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context)
    if context.pre_discard then
      if SMODS.pseudorandom_probability(card, "Broken Mirrors", 1, card.ability.extra.odds) then
        card.ability.extra.active = true
      end
    end
    if context.discard then
      if card.ability.extra.active then
        if context.other_card == context.full_hand[#context.full_hand] then
          card.ability.extra.active = false
        end
        return {remove = true}
      end
    end
  end
}

SMODS.Atlas {
  key = 'gap_aura',
  path = 'GAP_Aura.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'gap_aura',
  loc_txt = {
    name = "Eulogy Of Sameness",
    text = {
      "Spawns a {C:attention}random consumable{}",
      "when {C:attention}hand is played.{}",
      "{C:inactive}(Must have room!){}",
      "{C:inactive}Part of the GHOST and Pals Subpack!{}"
    }
  },
  rarity = 'WCCO_crossover_rarity',
  atlas = 'gap_aura',
  blueprint_compat = false,
  pos = { x = 0, y = 0 },
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context)
    if context.before and (#G.consumeables.cards + 1 <= G.consumeables.config.card_limit) then
      SMODS.add_card({set = "Consumeables", area = G.consumeables})
    end
  end
}

SMODS.Atlas {
  key = 'gap_SplitIdol',
  path = 'GAP_SplitIdol.png',
  px = 71,
  py = 95
}


SMODS.Joker {
  key = 'gap_split_idol',
  loc_txt = {
    name = "Split Idol(ized) Personality",
    text = {
      "{C:green}#1# in #2# chance{} to {C:attention}enhance played cards.{}",
      "{C:attention}(All Enhancements can be applied.){}",
      "{C:inactive}Part of the GHOST and Pals Subpack!{}"
    }
  },
  rarity = 'WCCO_crossover_rarity',
  atlas = 'gap_SplitIdol',
  blueprint_compat = false,
  pos = { x = 0, y = 0 },
  config = { extra = { odds = 4 } },
  loc_vars = function(self, info_queue, card)
    local numerGAP_SplitIdol, denomGAP_SplitIdol = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'uncommonGAP_SplitIdolProbCheck')
    return {vars = {numerGAP_SplitIdol, denomGAP_SplitIdol } }
  end,
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "Two Sides", 1, card.ability.extra.odds) then 
      for k, v in pairs(context.full_hand) do 
        context.other_card:set_ability(SMODS.poll_enhancement { guaranteed = true }, nil, true)
      end 
    end
  end
}

SMODS.Atlas {
  key = 'gap_end_world_normopathy',
  path = 'GAP_EndWorldNormopathy.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = "gap_end_world_normopathy",
  loc_txt = {
    name = "Last Resort Normopathy",
    text = {
      "{C:attention}Sell this Joker{} to instantly {C:attention}win the current Blind,{}",
      "{C:attention,s:1.25}However, sets your money to $0.{}",
      "{C:inactive}You still receive blind rewards.{}",
      "{C:inactive}Part of the GHOST and Pals Subpack!{}"
    }
  },
  cost = 0,
  rarity = 'WCCO_crossover_rarity',
  atlas = 'gap_end_world_normopathy',
  blueprint_compat = false,
  pos = { x = 0, y = 0 },
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context) 
    if context.selling_self then
      G.GAME.chips = G.GAME.blind.chips
      G.STATE = G.STATES.HAND_PLAYED
      G.STATE_COMPLETE = true -- Sets chips to requirement.
      ease_dollars(- (G.GAME.dollars + 1), true) -- Sets cash to 0.
      end_round() -- Actually ends the round.
      return true -- Not sure why you're here, but whatever.
    end
  end
}

SMODS.Atlas {
  key = 'KPDH_Arya',
  path = 'KPDH_ShowstopperArya.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = "KPDH_Arya",
  loc_txt = {
    name = "Arya, Showstopping Finale",
    text = {
      "{X:chips,C:white}x#1#{} {C:chips}Chips{} and {X:mult,C:white}x#2#{} {C:mult}Mult{}",
      "on your {C:attention}final hand.{}",
      "{C:inactive}Part of the KPop Demon Hunters Subpack!{}"
    }
  },
  cost = 5,
  config = { extra = { xchips = 2, xmult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult, card.ability.extra.xchips } }
  end,
  rarity = 'WCCO_crossover_rarity',
  atlas = 'KPDH_Arya',
  blueprint_compat = false,
  pos = { x = 0, y = 0 },
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context)
    if context.joker_main and G.GAME.current_round.hands_left == 0 then
      return {
        xchips = card.ability.extra.xchips,
        xmult = card.ability.extra.xmult
      }
    end
  end
}

SMODS.Atlas {
  key = 'KPDH_Ember',
  path = 'KPDH_DemonEmber.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = "KPDH_Ember",
  loc_txt = {
    name = "Ember, Demon-Human Hybrid",
    text = {
      "{C:attention}Scored{} {C:hearts}Hearts{} give both",
      "{C:chips}+#1# Chips{} and {C:mult}+#2# Mult.{}",
      "{C:inactive}Part of the KPop Demon Hunters Subpack!{}"
    }
  },
  cost = 5,
  config = { extra = { chips = 30, mult = 4 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,
  rarity = 'WCCO_crossover_rarity',
  atlas = 'KPDH_Ember',
  blueprint_compat = false,
  pos = { x = 0, y = 0 },
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.other_card and context.other_card:is_suit("Hearts") and not context.repetition then
      return {
        chips = card.ability.extra.chips,
        mult = card.ability.extra.mult
      }
    end
  end
}

SMODS.Atlas {
  key = 'KPDH_Hayl',
  path = 'KPDH_SpiritHayl.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = "KPDH_Hayl",
  loc_txt = {
    name = "Hayl, Spirit Booster",
    text = {
      "Gives an additional {C:purple}+#1#%{} of your {C:attention}hand's score.{}",
      "{C:inactive}Part of the KPop Demon Hunters Subpack!{}"
    }
  },
  cost = 5,
  config = { extra = { score = 10 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.score } }
  end,
  rarity = 'WCCO_crossover_rarity',
  atlas = 'KPDH_Hayl',
  blueprint_compat = false,
  pos = { x = 0, y = 0 },
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context)
    if context.after then
      G.E_MANAGER:add_event(Event({
        blocking = false,
        func = function()
          card:juice_up(0.3, 0.4)
          play_sound("gong")
          G.GAME.chips = G.GAME.chips + ((G.GAME.chips + SMODS.calculate_round_score()) / card.ability.extra.score) -- Credit to metanite64 for this. Stay in school, kids.
          return true
        end
      }))
    end
  end
}

SMODS.Atlas {
  key = 'KPDH_VenueTicket',
  path = 'KPDH_WILDCARDTICKET.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = "KPDH_VenueTicket",
  loc_txt = {
    name = "W/LDCARD's Ticket",
    text = {
      "{C:attention,s:1.25}When all members of W/LDCARD are held...{}",
      "{C:attention}All scored cards{} gain the {C:attention}Golden{} enhancement.",
      "{C:inactive}Part of the KPop Demon Hunters Subpack!{}"
    }
  },
  cost = 5,
  rarity = 'WCCO_crossover_rarity',
  atlas = 'KPDH_VenueTicket',
  blueprint_compat = false,
  pos = { x = 0, y = 0 },
  in_pool = function(self, args)
    return not args or args.source ~= "sho"
  end,
  calculate = function(self, card, context)
    if next(SMODS.find_card('j_WCCO_KPDH_Arya')) and next(SMODS.find_card('j_WCCO_KPDH_Ember')) and next(SMODS.find_card('j_WCCO_KPDH_Hayl')) then
      if context.individual and context.cardarea == G.play then
        for k, v in pairs(context.full_hand) do 
          context.other_card:set_ability(G.P_CENTERS.m_WCCO_KPDH_Golden, nil, true)
        end
      end
    end
  end
}

-- Arya, Mistress Of Misfortune (Cursed Rarity)

SMODS.Atlas {
  key = "cursed_arya",
  path = "cursed_arya.png",
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'cursed_arya',
  loc_txt = {
    name = 'Arya, Mistress Of Misfortune',
    text = {
      "Gains {C:mult}#2#{} {C:mult}Mult{}",
      "for every {C:attention}scored card that is NOT an Ace or 7{}.",
      "{C:inactive} (Current Mult:{} {C:mult}#1#{} {C:inactive}Mult){}",
      "{C:inactive}This Joker is challenge exclusive!{}"
    }
  },
  config = { extra = { mult = 0, mult_loss = -1 } },
  rarity = "WCCO_cursed_rarity",
  discovered = true,
  cost = 20,
  atlas = 'cursed_arya',
  blueprint_compat = true,
  in_pool = function(self)
    return false
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_loss } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
    if context.cardarea == G.play and context.other_card and not (context.other_card:get_id() == 14 or context.other_card:get_id() == 7) and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_loss
      return {
        message = 'Mult Lost!',
        colour = G.C.XMULT,
        card = card
      }
    end
  end
}

-- Ember, Eternally Spiteful Energy

SMODS.Atlas {
  key = "cursed_ember",
  path = "cursed_ember.png",
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'cursed_ember',
  loc_txt = {
    name = 'Ember, Eternally Spiteful',
    text = {
      "If {C:attention}scored hand does NOT consist of only{}",
      "{C:hearts}Heart{} cards, {X:mult,C:white}x#1#{} {C:mult}Mult{}.",
      "{C:inactive}This Joker is challenge exclusive!{}"
    }
  },
  config = { extra = { x_mult = 0 } },
  rarity = "WCCO_cursed_rarity",
  discovered = true,
  cost = 20,
  atlas = 'cursed_ember',
  blueprint_compat = true,
  in_pool = function(self)
    return false
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult} }
  end,
  calculate = function(self, card, context)
    local oops_only_hearts = true
    if context.joker_main then
      for k, v in pairs(context.scoring_hand) do
        if not v:is_suit("Hearts") and not context.repetition then
          oops_only_hearts = false
        end
      end
      if (oops_only_hearts == false) then
        return {
          Xmult_mod = card.ability.extra.x_mult
        }
      else 
        return {
          message = 'Love Is Love!',
          colour = G.C.XMULT
        }
      end
    end
  end
}

SMODS.Atlas {
  key = "cursed_delta",
  path = "cursed_delta.png",
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'cursed_delta',
  loc_txt = {
    name = 'Delta, The Devoid Spirit',
    text = {
      "{C:attention}+25% Blind Requirement{},",
      "{C:blue}-#2# hands{} and {C:red}-#1# discard{}.",
      "{C:inactive}This Joker is challenge exclusive!{}"
    }
  },
  rarity = "WCCO_cursed_rarity",
  discovered = true,
  cost = 20,
  atlas = 'cursed_delta',
  config = { extra = { hands = 2, d_size = 1 } },
  blueprint_compat = true,
  in_pool = function(self)
    return false
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.d_size, card.ability.extra.hands } }
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
    ease_hands_played(-card.ability.extra.hands)
    ease_discard(-card.ability.extra.d_size)
  end,
  calculate = function(self, card, context)
    if context.setting_blind and context.main_eval then
      G.E_MANAGER:add_event(Event({
        blocking = false,
        func = function()
          G.GAME.blind.chips = math.floor(G.GAME.blind.chips + G.GAME.blind.chips * 0.25)
          G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
          return true
        end
      }))
    end
  end
}