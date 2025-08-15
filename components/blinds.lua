SMODS.Atlas {
  key = 'blind_the_night',
  path = 'the_night.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "blind_the_night",
  atlas = "blind_the_night",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "The Night",
    text = {
      "All Clubs and Spades are debuffed."
    }
  },
  dollars = 5,
  mult = 2,
  boss_colour = HEX("000000"),
  boss = { min = 1 },
  calculate = function(self, blind, context)
    if not blind.disabled then
      if context.debuff_card and context.debuff_card.area ~= G.jokers and (context.debuff_card:is_suit("Clubs") or context.debuff_card:is_suit("Spades")) then
        blind.triggered = true
          return {
            debuff = true
          }
      end
    end
  end
}

SMODS.Atlas {
  key = 'blind_the_day',
  path = 'the_day.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "blind_the_day",
  atlas = "blind_the_day",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "The Day",
    text = {
      "All Diamonds and Hearts are debuffed."
    }
  },
  dollars = 5,
  mult = 2,
  boss_colour = HEX("00E2D6"),
  boss = { min = 1 },
  calculate = function(self, blind, context)
    if not blind.disabled then
      if context.debuff_card and context.debuff_card.area ~= G.jokers and (context.debuff_card:is_suit("Hearts") or context.debuff_card:is_suit("Diamonds")) then
        blind.triggered = true
          return {
            debuff = true
          }
      end
    end
  end
}