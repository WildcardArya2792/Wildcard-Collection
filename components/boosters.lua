----- BOOSTER PACK CODE -----

SMODS.Atlas {
  key = 'GAP_Booster',
  path = 'GAP_BoosterPack.png',
  px = 71,
  py = 95
}

SMODS.Booster{
  key = 'GAP_BoosterPack',
  loc_txt = {
    name = 'Pop Culture Pack: GHOST & Pals',
    group_name = "Enjoy your new Joker!",
      text = {
        'Pull a random {C:attention}GHOST & Pals inspired Joker.{}',
        "{C:inactive,s:0.75}Psst! Go listen to some of GHOST's works!{}"
      },
    },
  config = {extra = 1, choose = 1},
  draw_hand = false,
  atlas = 'GAP_Booster',
  pos = { x = 0, y = 0 },
  create_card = function(self, card)
    local keys = {
      'j_WCCO_gap_aura',
      'j_WCCO_gap_distortionist',
      'j_WCCO_gap_scapegoat',
      'j_WCCO_gap_split_idol',
    }
    local key = pseudorandom_element(keys, "ghost and pals")
    return {key = key}
  end,
  weight = 0.5,
  cost = 6,
  group_key = 'GAPGroup'
}

SMODS.ObjectType {
  key = "GAP_Jokers",
  cards = {
    ["j_gap_aura"] = true,
    ["j_gap_distortionist"] = true,
    ["j_gap_scapegoat"] = true,
    ["j_gap_split_idol"] = true
  },
}

----- GEMS -----

SMODS.Atlas {
  key = 'Gems_Booster',
  path = 'Gems_BoosterPack.png',
  px = 71,
  py = 95
}

SMODS.Booster{
  key = 'Gems_Booster',
  loc_txt = {
    name = 'Specialist Gem Pack',
    group_name = "Oooh, shiny!",
      text = {
        'Pull a random {C:attention}Specialist Gem.{}',
        "{C:inactive,s:0.75}You can use them to enhance your cards...{}"
      },
    },
  config = {extra = 1, choose = 1},
  draw_hand = true,
  atlas = 'Gems_Booster',
  pos = { x = 0, y = 0 },
  create_card = function(self, card)
    return SMODS.create_card({area = G.pack_cards, no_edition = true, skip_materialize = true, set = "specialist_gems"})
  end,
  weight = 0.67, -- ISTG if anyone makes a single "SIX SEVEN" joke, I'm deleting System32.
  cost = 4,
  group_key = 'Gems'
}