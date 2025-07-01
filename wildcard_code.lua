----- RARITY CODE -----

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

----- CONSUMABLES CODE -----

-- Spectral to summon: Wildcard Agent - Arya 

SMODS.Atlas{
  key = 'spectral_summonarya',
  path = 'spectral_summonarya.png',
  px = 71,
  py = 95,
}

SMODS.Consumable({
  key = "spectral_summonarya",
  set = "Spectral",
  object_type = "Consumable",
  name = "agent_summonarya",
  loc_txt = {
    name = "Submit",
    text = {
      "{C:dark_edition,E:1}Those who find me will thrive...{}",
      "{C:inactive}WARNING! Sacrifices ALL Arya Jokers held!{}"
      },
    },
	pos = {x = 0, y = 0},
	order = 99,
	atlas = "spectral_summonarya",
  unlocked = true,
  cost = 0,

  use = function(self, card, area, copier)
    for k, v in pairs(SMODS.find_card("j_WCCO_common_arya")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_uncommon_arya")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_rare_arya")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_legendary_arya")) do
      v:start_dissolve()
    end
    
    SMODS.add_card({rarity = "WCCO_wc_rarity", set = "Joker"})
  end,

  can_use = function(self, card)
    if #G.jokers.cards < G.jokers.config.card_limit then
      return true
    end
	end,

  in_pool = function(self)
    if ( next(SMODS.find_card('j_WCCO_common_arya')) and next(SMODS.find_card('j_WCCO_uncommon_arya')) and next(SMODS.find_card('j_WCCO_rare_arya')) and next(SMODS.find_card('j_WCCO_legendary_arya'))  ) then
      return true
    end
    return false
  end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
      unlock_card(self)
    else
			unlock_card(self)
		end
	end,
})

-- Spectral to summon: Wildcard Agent - Ember

SMODS.Atlas{
  key = 'spectral_summonember',
  path = 'spectral_summonember.png',
  px = 71,
  py = 95,
}

SMODS.Consumable({
  key = "spectral_summonember",
  set = "Spectral",
  object_type = "Consumable",
  name = "agent_summonember",
  loc_txt = {
    name = "Huntress",
    text = {
      "{C:dark_edition,E:1}Let the hunt for the weak begin...{}",
      "{C:inactive}WARNING! Sacrifices ALL Ember Jokers held!{}"
      },
    },
	pos = {x = 0, y = 0},
	order = 99,
	atlas = "spectral_summonember",
  unlocked = true,
  cost = 0,

  use = function(self, card, area, copier)
    for k, v in pairs(SMODS.find_card("j_WCCO_common_ember")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_uncommon_ember")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_rare_ember")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_legendary_ember")) do
      v:start_dissolve()
    end
    
    SMODS.add_card({rarity = "WCCO_wc_rarity", set = "Joker"})
  end,

  can_use = function(self, card)
    if #G.jokers.cards < G.jokers.config.card_limit then
      return true
    end
	end,

  in_pool = function(self)
    if ( next(SMODS.find_card('j_WCCO_common_ember')) and next(SMODS.find_card('j_WCCO_uncommon_ember')) and next(SMODS.find_card('j_WCCO_rare_ember')) and next(SMODS.find_card('j_WCCO_legendary_ember'))  ) then
      return true
    end
    return false
  end,

	check_for_unlock = function(self, args)
		if args.type == "win_deck" then
      unlock_card(self)
    else
			unlock_card(self)
		end
	end,
})

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
        "Each played {C:attention}7{}",
        "gives {C:chips}+#1# Chips{} and",
        "{C:mult}+#2# Mult{} when scored"
      }
    },
    config = { extra = { chips = 7, mult = 7 } },
    rarity = 1,
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
      "{C:green}#1# in #2#{} chance for each separate",
      "scored {C:attention}7{} to become a {C:attention}Lucky Card{}."
    }
  },
  config = { extra = { odds = 10 } },
  rarity = 2,
  atlas = 'uncommon_arya',
  pos = { x = 0, y = 0 },
  blueprint_compat = true,
  cost = 7,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if pseudorandom('Good Kid, M.A.A.D City') < G.GAME.probabilities.normal / card.ability.extra.odds then
        if context.other_card:get_id() == 7 then
          return {
            context.other_card:set_ability(G.P_CENTERS.m_lucky, nil, true)
          }
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
      "{C:green}#2# in #3#{} chance to be destroyed.",
      "{C:inactive}Roll those dice! You surely cannot lose!{}"
    }
  },
  config = { extra = { Xmult_mod = temp_Mult, odds = 5 } },
  rarity = 3,
  atlas = 'rare_arya',
  blueprint_compat = true,
  pos = { x = 0, y = 0 },
  cost = 9,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult_mod, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
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
      if pseudorandom('Bitch, where you when I was walkin?') < G.GAME.probabilities.normal / card.ability.extra.odds then
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
      "{C:green}#1# in #2#{} chance to",
      "{C:attention}automatically win the current Blind.{}",
      "{C:dark_edition} Passive Ability:{} Each scored card gives {X:purple,C:white}^#3#{} {C:mult}Mult.{}",
      "{C:inactive}''Think you can play with the big dogs? Let's see what you got.''{}"
    }
  },
  config = { extra = { odds = 10, e_mult = 2 } },
  rarity = 'WCCO_wc_rarity',
  atlas = 'goddess_arya',
  blueprint_compat = true,
  pos = { x = 0, y = 0 },
  soul_pos = { x = 1, y = 0 },
  cost = 100, -- This is meant to deter people from using Equilibrium Deck to grab this.
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.e_mult } }
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
      if pseudorandom('Cause you lied about religious views, you lied about your surgery, you lied about your accent and your past tense, all is perjury') < G.GAME.probabilities.normal / card.ability.extra.odds then
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
      "each scored {C:hearts}Heart{} card",
      "{C:inactive}(Currently at:{} {C:mult}+#1# Mult.{}{C:inactive}){}"
    }
  },
  config = { extra = { mult = 0, mult_gain = 1 } },
  rarity = 1,
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
      "{C:green}#1# in #2#{} chance for each separate scored",
      "{C:hearts}Heart{} card to become a {C:mult}Mult Card{}."
    }
  },
  config = { extra = { odds = 5 } },
  rarity = 2,
  atlas = 'uncommon_ember',
  pos = { x = 0, y = 0 },
  blueprint_compat = true,
  cost = 7,
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if pseudorandom('Sesbian Lex') < G.GAME.probabilities.normal / card.ability.extra.odds then
        if context.other_card:is_suit("Hearts") then
          return {
            context.other_card:set_ability(G.P_CENTERS.m_mult, nil, true)
          }
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
      "each scored {C:attention}Queen{} card",
      "{C:inactive}(Currently at:{} {C:mult}+#1# Mult.{}{C:inactive}){}"
    }
  },
  config = { extra = { mult = 0, mult_gain = 10 } },
  rarity = 3,
  cost = 9,
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
      "Each scored {C:attention}Queen{} gains",
      "{C:mult}+20 Mult{} when scored."
    }
  },
  atlas = 'legendary_ember',
  config = { extra = { perma_mult = 20 } },
  rarity = 4,
  cost = 10,
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
      "{C:inactive}(Except any Arya or Ember Jokers you have!){}",
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