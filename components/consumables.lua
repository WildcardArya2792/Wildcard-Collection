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
    
    SMODS.add_card{ key = "j_WCCO_goddess_arya"}
  end,

  can_use = function(self, card)
    if #G.jokers.cards < G.jokers.config.card_limit and ( next(SMODS.find_card('j_WCCO_common_arya')) and next(SMODS.find_card('j_WCCO_uncommon_arya')) and next(SMODS.find_card('j_WCCO_rare_arya')) and next(SMODS.find_card('j_WCCO_legendary_arya'))  ) then
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
    
    SMODS.add_card{ key = "j_WCCO_youre_so_portugese"}
  end,

  can_use = function(self, card)
    if #G.jokers.cards < G.jokers.config.card_limit and ( next(SMODS.find_card('j_WCCO_common_ember')) and next(SMODS.find_card('j_WCCO_uncommon_ember')) and next(SMODS.find_card('j_WCCO_rare_ember')) and next(SMODS.find_card('j_WCCO_legendary_ember'))  )then
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

SMODS.Atlas{
  key = 'spectral_summondelta',
  path = 'spectral_summondelta.png',
  px = 71,
  py = 95,
}

SMODS.Consumable({
  key = "spectral_summondelta",
  set = "Spectral",
  object_type = "Consumable",
  name = "agent_summondelta",
  loc_txt = {
    name = "Corrupt",
    text = {
      "{C:dark_edition,E:1}Didn't sanitize inputs? Too bad...{}",
      "{C:inactive}WARNING! Sacrifices ALL Delta Jokers held!{}"
      },
    },
	pos = {x = 0, y = 0},
	order = 99,
	atlas = "spectral_summondelta",
  unlocked = true,
  cost = 0,

  use = function(self, card, area, copier)
    for k, v in pairs(SMODS.find_card("j_WCCO_common_delta")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_uncommon_delta")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_rare_delta")) do
      v:start_dissolve()
    end

    for k, v in pairs(SMODS.find_card("j_WCCO_legendary_delta")) do
      v:start_dissolve()
    end
    
    SMODS.add_card{ key = "j_WCCO_not_every_geek_has_a_commodore_64"}
  end,

  can_use = function(self, card)
    if #G.jokers.cards < G.jokers.config.card_limit and ( next(SMODS.find_card('j_WCCO_common_delta')) and next(SMODS.find_card('j_WCCO_uncommon_delta')) and next(SMODS.find_card('j_WCCO_rare_delta')) and next(SMODS.find_card('j_WCCO_legendary_delta'))  ) then
      return true
    end
	end,

  in_pool = function(self)
    if ( next(SMODS.find_card('j_WCCO_common_delta')) and next(SMODS.find_card('j_WCCO_uncommon_delta')) and next(SMODS.find_card('j_WCCO_rare_delta')) and next(SMODS.find_card('j_WCCO_legendary_delta'))  ) then
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