Oblivion = Oblivion or {}
Oblivion.corruption_map = Oblivion.corruption_map or {}

SMODS.Atlas {
  key = "hypnotist_arya",
  path = "Crossmod_HypnotistArya.png",
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'hypnotist_arya',
  loc_txt = {
    name = 'Hypnotic Arya',
    text = {
      "{C:green}#1# in #2# chance{} for {C:attention}scored cards{}",
      "to become {C:attention}Tranced.{}",
      "{C:inactive}''Don't worry, you'll be safe here...''{}"
    }
  },
  config = { extra = { odds = 5 } },
  rarity = "ovn_corrupted",
  atlas = 'hypnotist_arya',
  pos = { x = 0, y = 0 },
  blueprint_compat = true,
  cost = 7,
  loc_vars = function(self, info_queue, card)
    local numerAryaHypnotist, denomAryaHypnotist = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'JoinTheHive')
    return {vars = {numerAryaHypnotist, denomAryaHypnotist } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if SMODS.pseudorandom_probability(card, 'DROPDEEPDOWN', 1, card.ability.extra.odds, 'JoinTheHive') then
        for k, v in pairs(context.full_hand) do
            return {
              context.other_card:set_ability(G.P_CENTERS.m_WCCO_arya_enhancement, nil, true)
            }
        end
      end
    end
  end
}

SMODS.Atlas {
  key = "wrathful_ember",
  path = "Crossmod_WrathfulEmber.png", 
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'wrathful_ember',
  loc_txt = {
    name = 'Wrathful Ember',
    text = {
      "{C:green}#1# in #2# chance{} for {C:attention}scored{}",
      "{C:hearts}Heart{} cards to become {C:attention}Enraged{}.",
      "{C:inactive}''I won't rest until you've repaid your debt!''{}"
    }
  },
  config = { extra = { odds = 6 } },
  rarity = "ovn_corrupted",
  atlas = 'wrathful_ember',
  pos = { x = 0, y = 0 },
  blueprint_compat = true,
  cost = 7,
  loc_vars = function(self, info_queue, card)
    local numerEmberWrathful, denomEmberWrathful = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'SpiteWrathAndHatred')
    return {vars = {numerEmberWrathful, denomEmberWrathful } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if SMODS.pseudorandom_probability(card, "Love And Hate", 1, card.ability.extra.odds, 'SpiteWrathAndHatred') then
        for k, v in pairs(G.jokers.cards) do
          if context.other_card:is_suit("Hearts") then
            return {
              context.other_card:set_ability(G.P_CENTERS.m_WCCO_ember_enhancement, nil, true)
            }
          end
        end
      end
    end
  end
}

SMODS.Atlas {
  key = "infected_delta",
  path = "Crossmod_InfectedDelta.png",
  px = 71,
  py = 95 
}

SMODS.Joker {
  key = "infected_delta",
  loc_txt = {
    name = "!NF3CT3D D3LT4",
    text = {
      "{C:attention}110%{} blind requirement, but {C:green}#1# in #2# chance{}",
      "for {C:attention}scored{} cards to become {C:attention}Focused{}.",
      "{C:inactive}ERROR: Failed to load this card's quote!{}"
    }
  },
  rarity = "ovn_corrupted",
  cost = 6,
  atlas = "infected_delta",
  blueprint_compat = false,
  discovered = true,
  pos = { x = 0, y = 0 },
  config = { extra = { odds = 7 } },
  loc_vars = function(self, info_queue, card)
    local numerDeltaInfected, denomDeltaInfected = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'WANNACRY')
    return {vars = {numerDeltaInfected, denomDeltaInfected } }
  end,
  calculate = function(self, card, context)
    if context.setting_blind and context.main_eval then
      G.E_MANAGER:add_event(Event({
        blocking = false,
        func = function()
          G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 1.1)
          G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
          return true
        end
      }))
    end
    if context.individual and context.cardarea == G.play then
      if SMODS.pseudorandom_probability(card, 'NoThreatsFound', 1, card.ability.extra.odds, 'DownloadADamnAntivirus!') then
        for k, v in pairs(context.full_hand) do
            return {
              context.other_card:set_ability(G.P_CENTERS.m_WCCO_delta_enhancement, nil, true)
            }
        end
      end
    end
  end
}

Oblivion.corruption_map["j_WCCO_uncommon_arya"] = "j_WCCO_hypnotist_arya"
Oblivion.corruption_map["j_WCCO_uncommon_ember"] = "j_WCCO_wrathful_ember"
Oblivion.corruption_map["j_WCCO_uncommon_delta"] = "j_WCCO_infected_delta"