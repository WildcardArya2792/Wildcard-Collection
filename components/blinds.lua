---@diagnostic disable: undefined-global
SMODS.ScreenShader {
  key = "negative",
  path = "negative.fs",
  should_apply = function(self)
    if (G.GAME.blind and G.GAME.blind.config.blind.key == "bl_WCCO_arya_only_visual_variance") then
      return true
    else
      return false
    end
  end
}

-- Defining shaders before blind. Very cool and good code.

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
      if context.debuff_card and context.debuff_card.area ~= G.jokers and (context.debuff_card:is_suit('Clubs', true) or context.debuff_card:is_suit('Spades', true)) then
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
      if context.debuff_card and context.debuff_card.area ~= G.jokers and (context.debuff_card:is_suit('Hearts', true) or context.debuff_card:is_suit('Diamonds', true)) then
        blind.triggered = true
          return {
            debuff = true
          }
      end
    end
  end
}

SMODS.Atlas {
  key = 'the_worthless',
  path = 'the_worthless.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "blind_the_worthless",
  atlas = "the_worthless",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "The Underdogs",
    text = {
      "All ranks below 7 are debuffed."
    }
  },
  dollars = 5,
  mult = 2,
  boss_colour = HEX("FF0000"),
  boss = { min = 1 },
  calculate = function(self, blind, context)
    if not blind.disabled then
      if context.debuff_card then
        local rank = context.debuff_card:get_id()
        if (rank == 2 or rank == 3 or rank == 4 or rank == 5 or rank == 6) then
          return {
            debuff = true
          }
        end 
      end
    end
  end
}

SMODS.Atlas {
  key = 'the_favorites',
  path = 'the_favorites.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "blind_the_favorites",
  atlas = "the_favorites",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "The Favorites",
    text = {
      "All ranks above 6 are debuffed."
    }
  },
  dollars = 5,
  mult = 2,
  boss_colour = HEX("00FF00"),
  boss = { min = 1 },
  calculate = function(self, blind, context)
    if not blind.disabled then
      if context.debuff_card then
        local rank = context.debuff_card:get_id()
        if (rank == 7 or rank == 8 or rank == 9 or rank == 10 or rank == 11 or rank == 12 or rank == 13 or rank == 14) then
          return {
            debuff = true
          }
        end
      end
    end
  end
}

SMODS.Atlas {
  key = 'crimson_heatwave',
  path = 'crimson_heatwave.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "delta_only_crimson_heatwave",
  atlas = "crimson_heatwave",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "Constructor.CRIMSON_HEATWAVE",
    text = {
      "ABSURDLY (10x) large blind."
    }
  },
  dollars = 5,
  mult = 10,
  boss_colour = HEX("DC143C"),
  boss = { min = 1 },
  disable = function(self)
    G.GAME.blind.chips = G.GAME.blind.chips / 5
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
  end,
  in_pool = function(self, args)
    if (G.GAME.round_resets.ante > 8) and ( next(SMODS.find_card('j_WCCO_common_delta')) or next(SMODS.find_card('j_WCCO_uncommon_delta')) or next(SMODS.find_card('j_WCCO_rare_delta')) or next(SMODS.find_card('j_WCCO_legendary_delta')) or next(SMODS.find_card('j_WCCO_not_every_geek_has_a_commodore_64'))) then
      return true
    end
  end
}

SMODS.Atlas {
  key = 'void_tornado',
  path = 'void_tornado.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "delta_only_void_tornado",
  atlas = "void_tornado",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "HackTool.VOID_TORNADO",
    text = {
      "Forces as many cards as",
			"possible to be selected."
    }
  },
  dollars = 15,
  mult = 2,
  boss_colour = HEX("000000"),
  boss = { min = 1 },
  calculate = function(self, blind, context)
    if not blind.disabled then
      if context.hand_drawn then
        local any_forced = nil
        for _, playing_card in ipairs(G.hand.cards) do
          if playing_card.ability.forced_selection then
            any_forced = true
          end
        end
        if not any_forced then
          G.hand:unhighlight_all() -- Credit to SomethingCom515. What the hell is SMODS.shallow_copy!?
          local cards = SMODS.shallow_copy(G.hand.cards)
          for i = 1, (G.hand.config.highlighted_limit - #G.hand.highlighted) do
            local forced_card, index = pseudorandom_element(cards, self.key)
            forced_card.ability.forced_selection = true
            if not forced_card.highlighted then
              G.hand:add_to_highlighted(forced_card)
            end
            table.remove(cards, index)
          end
        end
      end
    end
  end,
  disable = function(self)
    for _, playing_card in ipairs(G.playing_cards) do
      playing_card.ability.forced_selection = nil
    end
  end,
  in_pool = function(self, args)
    if (G.GAME.round_resets.ante > 8) and ( next(SMODS.find_card('j_WCCO_common_delta')) or next(SMODS.find_card('j_WCCO_uncommon_delta')) or next(SMODS.find_card('j_WCCO_rare_delta')) or next(SMODS.find_card('j_WCCO_legendary_delta')) or next(SMODS.find_card('j_WCCO_not_every_geek_has_a_commodore_64'))) then
      return true
    end
  end
}

SMODS.Atlas {
  key = 'midnight_storm',
  path = 'midnight_storm.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "delta_only_midnight_storm",
  atlas = "midnight_storm",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "Ransom.MIDNIGHT_STORM",
    text = {
      "Flips and shuffles all Jokers,",
			"then permanently debuffs",
			"a random Joker."
    }
  },
  dollars = 20,
  mult = 2,
  boss_colour = HEX("191970"),
  boss = { min = 1 },
  calculate = function(self, blind, context)
    if not blind.disabled then
      if context.setting_blind then
        if #G.jokers.cards > 0 then
          G.jokers:unhighlight_all()
          for _, joker in ipairs(G.jokers.cards) do
            joker:flip()
          end
          if #G.jokers.cards > 1 then
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.2,
              func = function()
                G.E_MANAGER:add_event(Event({
                  func = function()
                    G.jokers:shuffle('aajk')
                    play_sound('cardSlide1', 0.85)
                    return true
                  end,
                }))
                delay(0.10)
                G.E_MANAGER:add_event(Event({
                  func = function()
                    G.jokers:shuffle('aajk')
                    play_sound('cardSlide1', 1.15)
                    return true
                  end
                }))
                delay(0.05)
                G.E_MANAGER:add_event(Event({
                  func = function()
                    G.jokers:shuffle('aajk')
                    play_sound('cardSlide1', 1)
                    return true
                  end
                }))
                delay(0.025)
                G.E_MANAGER:add_event(Event({
                  func = function()
                    G.jokers:shuffle('aajk')
                    play_sound('cardSlide1', 1.50)
                    return true
                  end
                }))
                delay(0.010)
                G.E_MANAGER:add_event(Event({
                  func = function()
                    G.jokers:shuffle('aajk')
                    play_sound('cardSlide1', 0.75)
                    return true
                  end
                }))
                delay(0.5)
                return true
              end
            }))
          end
        end
      end
	  	if context.hand_drawn then
  			if blind.prepped and G.jokers.cards[1] then
    			local prev_chosen_set = {}
    			local fallback_jokers = {}
    			local jokers = {}
    			for i = 1, #G.jokers.cards do
    				if G.jokers.cards[i].ability.crimson_heart_chosen then
							prev_chosen_set[G.jokers.cards[i]] = true
							G.jokers.cards[i].ability.crimson_heart_chosen = nil
								if G.jokers.cards[i].debuff then
									SMODS.debuff_card(G.jokers.cards[i], false, "RANSOM")
								end
							end
						end
					for i = 1, #G.jokers.cards do
      			if not G.jokers.cards[i].debuff then
      				if not prev_chosen_set[G.jokers.cards[i]] then
          			jokers[#jokers + 1] = G.jokers.cards[i]
        			end
        			table.insert(fallback_jokers, G.jokers.cards[i])
      			end
					end
					if #jokers == 0 then 
						jokers = fallback_jokers 
					end
					local _card = pseudorandom_element(jokers, 'vremade_crimson_heart') -- Yeah, not even gonna try to hide that I stole the code.
					if _card then
						_card.ability.crimson_heart_chosen = true
						SMODS.debuff_card(_card, true, "RANSOM")
						_card:juice_up()
						blind:wiggle()
						return {
        			message = 'Encrypted!',
        			colour = G.C.XMULT,
        			card = card
      			}
					end
				end
			end
  	end
	end,
  in_pool = function(self, args)
    if (G.GAME.round_resets.ante > 8) and ( next(SMODS.find_card('j_WCCO_common_delta')) or next(SMODS.find_card('j_WCCO_uncommon_delta')) or next(SMODS.find_card('j_WCCO_rare_delta')) or next(SMODS.find_card('j_WCCO_legendary_delta')) or next(SMODS.find_card('j_WCCO_not_every_geek_has_a_commodore_64'))) then
      return true
    end
  end
}

SMODS.Atlas {
  key = 'audio_assault',
  path = 'audio_assault.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "arya_only_audio_assault",
  atlas = "audio_assault",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "Auditory Annoyance",
    text = {
      "Clicking plays a random sound.",
      "Additionally, 3x Blind Size."
    }
  },
  dollars = 7,
  mult = 3,
  boss_colour = HEX("FF00FF"),
  boss = { min = 1 },
  in_pool = function(self, args)
    if (G.GAME.round_resets.ante > 8) and ( next(SMODS.find_card('j_WCCO_common_arya')) or next(SMODS.find_card('j_WCCO_uncommon_arya')) or next(SMODS.find_card('j_WCCO_rare_arya')) or next(SMODS.find_card('j_WCCO_legendary_arya')) or next(SMODS.find_card('j_WCCO_goddess_arya'))) then
      return true
    end
  end
}

SMODS.Atlas {
  key = 'visual_variance',
  path = 'visual_variance.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "arya_only_visual_variance",
  atlas = "visual_variance",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "Visual Variance",
    text = {
      "All colors become inverted.",
      "Additionally, 3x Blind Size."
    }
  },
  dollars = 7,
  mult = 3,
  boss_colour = HEX("FFFFFF"),
  boss = { min = 1 },
  in_pool = function(self, args)
    if (G.GAME.round_resets.ante > 8) and ( next(SMODS.find_card('j_WCCO_common_arya')) or next(SMODS.find_card('j_WCCO_uncommon_arya')) or next(SMODS.find_card('j_WCCO_rare_arya')) or next(SMODS.find_card('j_WCCO_legendary_arya')) or next(SMODS.find_card('j_WCCO_goddess_arya'))) then
      return true
    end
  end
}

SMODS.Atlas {
  key = 'seesaw_semblance',
  path = 'seesaw_semblance.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 1
}

SMODS.Blind {
  key = "arya_only_seesaw_semblance",
  atlas = "seesaw_semblance",
  pos = { x = 0, y = 0 },
  loc_txt = {
    name = "Seesaw Semblance",
    text = {
      "Either odds or evens",
      "are debuffed.",
      "Additionally, 3x Blind Size."
    }
  },
  dollars = 10,
  mult = 3,
  boss_colour = HEX("135246"),
  boss = { min = 1 },
  set_blind = function (self)
    G.GAME.blind.effect[0] = pseudorandom(pseudoseed('seesaw'))
  end,
  calculate = function(self, blind, context) -- mysminty gets the credit here.
    if not blind.disabled then
      if context.debuff_card and (G.GAME.blind.effect[0] > 0.5) then
        local rank = context.debuff_card:get_id()
        if (rank == 1 or rank == 3 or rank == 5 or rank == 7 or rank == 9 or rank == 14) then
          return {
            debuff = true
          }
        end
      end
      if context.debuff_card and (G.GAME.blind.effect[0] < 0.5) then
        local rank = context.debuff_card:get_id()
        if (rank == 2 or rank == 4 or rank == 6 or rank == 8 or rank == 10) then
          return {
            debuff = true
          }
        end
      end
    end
  end,
  in_pool = function(self, args)
    if (G.GAME.round_resets.ante > 8) and ( next(SMODS.find_card('j_WCCO_common_arya')) or next(SMODS.find_card('j_WCCO_uncommon_arya')) or next(SMODS.find_card('j_WCCO_rare_arya')) or next(SMODS.find_card('j_WCCO_legendary_arya')) or next(SMODS.find_card('j_WCCO_goddess_arya'))) then
      return true
    end
  end
}

-- I am not proud of this solution.

SMODS.Sound{
  key = "FAHH",
  path = "FAHH.ogg",
}

SMODS.Sound{
  key = "Wade_PKCell",
  path = "Wade_PKCell.ogg",
}
SMODS.Sound{
  key = "Wade_Dingus",
  path = "Wade_Dingus.ogg",
}
SMODS.Sound{
  key = "FISH",
  path = "FISH.ogg",
}
SMODS.Sound{
  key = "Discord_Ping",
  path = "Discord_Ping.ogg",
}
SMODS.Sound{
  key = "F1_Radio",
  path = "F1_Radio.ogg",
}
SMODS.Sound{
  key = "TF2_Notif",
  path = "TF2_Notif.ogg",
}
SMODS.Sound{
  key = "white_people",
  path = "white_people.ogg",
}
SMODS.Sound{
  key = "ahh",
  path = "ahh.ogg",
}
SMODS.Sound{
  key = "Mask_Rap_Verse",
  path = "Mask_Rap_Verse.ogg",
}

-- Dear future Arya: If it's not broken, don't fucking touch it.

local oldcontrollerlcursorpress = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
  x = x or self.cursor_position.x
  y = y or self.cursor_position.y

  local g = oldcontrollerlcursorpress(self, x, y)
  if G.GAME.blind and G.GAME.blind.config.blind.key == "bl_WCCO_arya_only_audio_assault" then
    local myEarsTheyBleed = pseudorandom(pseudoseed('Holy noise pollution'))
    if myEarsTheyBleed <= 0.10 then
      play_sound('WCCO_FAHH', 1, 1)
    elseif myEarsTheyBleed <= 0.20 then
      play_sound('WCCO_Wade_PKCell', 1, 1)
    elseif myEarsTheyBleed <= 0.30 then
      play_sound('WCCO_Wade_Dingus', 1, 1)
    elseif myEarsTheyBleed <= 0.40 then
      play_sound('WCCO_FISH', 1, 1)
    elseif myEarsTheyBleed <= 0.50 then
      play_sound('WCCO_Discord_Ping', 1, 1)
    elseif myEarsTheyBleed <= 0.60 then
      play_sound('WCCO_F1_Radio', 1, 1)
    elseif myEarsTheyBleed <= 0.70 then
      play_sound('WCCO_TF2_Notif', 1, 1)
    elseif myEarsTheyBleed <= 0.80 then
      play_sound('WCCO_white_people', 1, 1)
    elseif myEarsTheyBleed <= 0.90 then
      play_sound('WCCO_ahh', 1, 1)
    else
      play_sound('WCCO_Mask_Rap_Verse', 1, 1)
    end
    return g
  end

  if ((self.locked) and (not G.SETTINGS.paused or G.screenwipe)) or (self.locks.frame) then return end

  self.cursor_down.T = {x = x/(G.TILESCALE*G.TILESIZE), y = y/(G.TILESCALE*G.TILESIZE)}
  self.cursor_down.time = G.TIMERS.TOTAL
  self.cursor_down.handled = false
  self.cursor_down.target = nil
  self.is_cursor_down = true

  local press_node =  (self.HID.touch and self.cursor_hover.target) or self.hovering.target or self.focused.target

  if press_node then 
    self.cursor_down.target = press_node.states.click.can and press_node or press_node:can_drag() or nil
  end

  if self.cursor_down.target == nil then 
    self.cursor_down.target = G.ROOM
  end
end

local oldcontrollerlcursorrelease = Controller.L_cursor_release
function Controller:L_cursor_release(x, y)
  local g = oldcontrollerlcursorrelease(self, x, y)
  if G.GAME.blind and G.GAME.blind.config.blind.key == "bl_WCCO_arya_only_audio_assault" then
    local myEarsTheyBleed = pseudorandom(pseudoseed('Holy noise pollution'))
    if myEarsTheyBleed <= 0.10 then
      play_sound('WCCO_FAHH', 1, 1)
    elseif myEarsTheyBleed <= 0.20 then
      play_sound('WCCO_Wade_PKCell', 1, 1)
    elseif myEarsTheyBleed <= 0.30 then
      play_sound('WCCO_Wade_Dingus', 1, 1)
    elseif myEarsTheyBleed <= 0.40 then
      play_sound('WCCO_FISH', 1, 1)
    elseif myEarsTheyBleed <= 0.50 then
      play_sound('WCCO_Discord_Ping', 1, 1)
    elseif myEarsTheyBleed <= 0.60 then
      play_sound('WCCO_F1_Radio', 1, 1)
    elseif myEarsTheyBleed <= 0.70 then
      play_sound('WCCO_TF2_Notif', 1, 1)
    elseif myEarsTheyBleed <= 0.80 then
      play_sound('WCCO_white_people', 1, 1)
    elseif myEarsTheyBleed <= 0.90 then
      play_sound('WCCO_ahh', 1, 1)
    else
      play_sound('WCCO_Mask_Rap_Verse', 1, 1)
    end
    return g
  end
  x = x or self.cursor_position.x
    y = y or self.cursor_position.y

    if ((self.locked) and (not G.SETTINGS.paused or G.screenwipe)) or (self.locks.frame) then return end

    self.cursor_up.T = {x = x/(G.TILESCALE*G.TILESIZE), y = y/(G.TILESCALE*G.TILESIZE)}
    self.cursor_up.time = G.TIMERS.TOTAL
    self.cursor_up.handled = false
    self.cursor_up.target = nil
    self.is_cursor_down = false

    self.cursor_up.target = self.hovering.target or self.focused.target

    if self.cursor_up.target == nil then 
        self.cursor_up.target = G.ROOM
    end

    
end

-- Left button above, right button below.
-- Dear future Arya: Is this really worth it?
-- Dear past Arya: God no. This is not worth it.

local oldcontrollerqueuercursorpress = Controller.queue_R_cursor_press
function Controller:queue_R_cursor_press(x, y)
  local g = oldcontrollerqueuercursorpress(self, x, y)
  if G.GAME.blind and G.GAME.blind.config.blind.key == "bl_WCCO_arya_only_audio_assault" then -- Holy spaghetti code!
    local myEarsTheyBleed = pseudorandom(pseudoseed('Holy noise pollution'))
    if myEarsTheyBleed <= 0.10 then
      play_sound('WCCO_FAHH', 1, 1)
    elseif myEarsTheyBleed <= 0.20 then
      play_sound('WCCO_Wade_PKCell', 1, 1)
    elseif myEarsTheyBleed <= 0.30 then
      play_sound('WCCO_Wade_Dingus', 1, 1)
    elseif myEarsTheyBleed <= 0.40 then
      play_sound('WCCO_FISH', 1, 1)
    elseif myEarsTheyBleed <= 0.50 then
      play_sound('WCCO_Discord_Ping', 1, 1)
    elseif myEarsTheyBleed <= 0.60 then
      play_sound('WCCO_F1_Radio', 1, 1)
    elseif myEarsTheyBleed <= 0.70 then
      play_sound('WCCO_TF2_Notif', 1, 1)
    elseif myEarsTheyBleed <= 0.80 then
      play_sound('WCCO_white_people', 1, 1)
    elseif myEarsTheyBleed <= 0.90 then
      play_sound('WCCO_ahh', 1, 1)
    else
      play_sound('WCCO_Mask_Rap_Verse', 1, 1)
    end
    return g
  end

  if self.locks.frame then 
    return 
  end

  if not G.SETTINGS.paused and G.hand and G.hand.highlighted[1] then 
    if (G.play and #G.play.cards > 0) or (self.locked) or (self.locks.frame) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then 
      return 
    end
    G.hand:unhighlight_all()
  end
end