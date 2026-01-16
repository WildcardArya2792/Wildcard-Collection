----- BOOSTER PACK CODE -----

SMODS.ObjectType {
  key = "CrossoverPackOne",
  cards = {
    ['j_WCCO_gap_aura'] = true,
    ['j_WCCO_gap_distortionist'] = true,
    ['j_WCCO_gap_scapegoat'] = true,
    ['j_WCCO_gap_split_idol'] = true,
    ["j_WCCO_gap_end_world_normopathy"] = true,
    ["j_WCCO_KPDH_Arya"] = true,
    ["j_WCCO_KPDH_Ember"] = true,
    ["j_WCCO_KPDH_Hayl"] = true,
    ["j_WCCO_KPDH_VenueTicket"] = true
  }
}

SMODS.Atlas {
  key = 'Crossover_One',
  path = 'CrossoverPack1.png',
  px = 71,
  py = 95
}

SMODS.Booster{
  key = 'Crossover_One',
  loc_txt = {
    name = 'Crossover Pack: Set One',
    group_name = "Select a Joker!",
      text = {
        "Choose {C:attention}1{} of {C:attention}2{} possible {C:attention}Crossover-exclusive Jokers!{}",
        "{C:inactive}Currently in this pack:{}",
        "{C:inactive}GHOST and Pals (5 Jokers){}",
        "{C:inactive}KPOP Demon Hunters (3 Jokers){}"
      },
    },
  config = {extra = 2, choose = 1},
  draw_hand = false,
  atlas = 'Crossover_One',
  pos = { x = 0, y = 0 },
  create_card = function(self, card)
    return {set = "CrossoverPackOne", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "Please Work"}
  end,
  weight = 5,
  cost = 6
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
  weight = 5,
  cost = 4,
  group_key = 'Gems'
}