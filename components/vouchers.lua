to_big = to_big or function(x) -- Damn you, Talisman.
  return x
end

SMODS.Atlas {
    key = "tier_3_vouchers",
    path = "tier_3_vouchers.png",
    px = 71,
    py = 95
}

--- Divider for Atlas and Vouchers ---
-- "Doing Tier 3s for Retcon and Illusion would require hooks or patches. I'm not paid enough."
-- "You barely pay us at all."

SMODS.Voucher {
    key = 'materialist',
    loc_txt = {
      name = 'Materialist',
      text = {
        "{C:attention}+#1#{} card slots.",
        "{C:inactive}Upgraded from: Overstock Plus{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    pos = { x = 0, y = 0 },
    requires = {'v_overstock_plus'},
    config = { extra = { shop_size = 3 } },
    cost = 25,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.shop_size } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'fire_sale',
    loc_txt = {
      name = 'Fire Sale',
      text = {
        "All cards and packs",
        "are now {C:attention}#1#%{} off.",
        "{C:inactive}Upgraded from: Clearance Sale{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    pos = { x = 1, y = 0 },
    cost = 25,
    requires = {'v_liquidation'},
    config = { extra = { percent = 75 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.percent } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'shining_star',
    loc_txt = {
      name = 'Shining Star',
      text = {
        "All cards are {C:attention}guaranteed{}",
        "to spawn with an {C:attention}Edition{}.",
        "{C:inactive}Upgraded from: Glow Up{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 2, y = 0 },
    config = { extra = { rate = 100 } }, -- We NEED to fix this shit.
    requires = { 'v_glow_up' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rate } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.edition_rate = card.ability.extra.rate
                return true
            end
        }))
    end
}

SMODS.Voucher { 
    key = 'insatiable_reroller',
    loc_txt = {
      name = 'Insatiable Reroller',
      text = {
        "Rerolls cost {C:attention}$#1#{}.",
        "{C:inactive}Upgraded from: Reroll Glut{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 3, y = 0 },
    config = { extra = { final_cost = 1 } },
    requires = { 'v_reroll_glut' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.final_cost } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                calculate_reroll_cost(skip_increment)
                return true -- Needed so the game doesn't hang!
            end
        }))
    end,
    calculate = function(self, card, context)
		calculate_reroll_cost(skip_increment)
    end
}

SMODS.Voucher {
    key = 'magical_essence',
    loc_txt = {
      name = 'Magical Essence',
      text = {
        "After opening an {C:attention}Arcana Pack{},",
        "spawn a random {C:spectral}Spectral{} card.", 
        "{C:inactive}Upgraded from: Omen Globe{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 4, y = 0 },
    requires = { 'v_omen_globe' },
    calculate = function(self, card, context)
        if context.open_booster and context.card.config.center.kind == 'Arcana' then
            SMODS.add_card{ set = "Spectral", soulable = true}
        end
    end
}

SMODS.Voucher {
    key = 'unbound_astronomy',
    loc_txt = {
      name = 'Unbound Astronomy',
      text = {
        "{C:planet}Planet{} cards in your", 
        "{C:attention}consumable{} area give {X:mult,C:white}X#1#{} Mult.",
        "{C:inactive}Upgraded from: Observatory{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    pos = { x = 5, y = 0 },
    cost = 25,
    config = { extra = { Xmult = 2.5 } },
    requires = { 'v_observatory' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_consumeable and context.other_consumeable.ability.set == 'Planet' then
            return {
                x_mult = card.ability.extra.Xmult,
                message_card = context.other_consumeable
            }
        end
    end
}

SMODS.Voucher {
    key = 'tri_dextrous',
    loc_txt = {
      name = 'Tri-Dextrous',
      text = {
        "Permanently gain an additional",
        "{C:blue}+#1#{} hands per round.",
        "{C:inactive}Upgraded from: Nacho Tong{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    pos = { x = 6, y = 0 },
    cost = 25,
    config = { extra = { hands = 3 } },
    requires = { 'v_nacho_tong' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,
    redeem = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end
}

SMODS.Voucher {
    key = 'net_zero',
    loc_txt = {
      name = 'Net-Zero Strategy',
      text = {
        "Each {C:red}discard{} gives",
        "{C:blue}+#1#{} hand in return.",
        "{C:inactive}Upgraded from: Recyclomancy{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    requires = { 'v_recyclomancy' },
    pos = { x = 7, y = 0 },
    config = { extra = { hands = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,
    calculate = function(self, card, context)
        if context.pre_discard then
            ease_hands_played(card.ability.extra.hands)
        end
    end
}

SMODS.Voucher {
    key = 'forest_of_riches',
    loc_txt = {
      name = 'Forest Of Riches',
      text = {
        "Raise the cap on",
        "interest earned in",
        "each round to {C:attention}$50{}.",
        "{C:inactive}Upgraded from: Money Tree{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    pos = { x = 8, y = 0 },
    cost = 25,
    requires = { 'v_money_tree' },
    config = { extra = { cap = 250 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cap } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.interest_cap = card.ability.extra.cap
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'kara_no_kara',
    loc_txt = {
      name = 'Kara Kara Kara No Kara',
      text = {
        "{C:dark_edition}+#1#{} Joker slots.",
        "{C:inactive}Upgraded from: Antimatter{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 9, y = 0 },
    config = { extra = { slots = 2 } },
    requires = { 'v_antimatter' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 2
                end
                return true
            end,
        }))
    end
}

SMODS.Voucher {
    key = 'indiscernible_glyph',
    loc_txt = {
      name = 'Indiscernible Glyph',
      text = {
        "{C:attention}-#1#{} Antes,",
        "{C:blue}-#2# hand{} and {C:red}-#3# discard{}.",
        "{C:inactive}Upgraded from: Petroglyph{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 10, y = 0 },
    requires = { 'v_petroglyph' },
    config = { extra = { ante_deduction = 2, hand_deduction = 1, discard_deduction = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ante_deduction, card.ability.extra.hand_deduction, card.ability.extra.discard_deduction  } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra.ante_deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.ante_deduction

        -- Apply hand change
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hand_deduction
        ease_hands_played(-card.ability.extra.hand_deduction)

        -- Apply discard change
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discard_deduction
        ease_discard(-card.ability.extra.discard_deduction)
    end
}

SMODS.Voucher {
    key = 'creationist',
    loc_txt = {
      name = 'Creationist',
      text = {
        "{C:attention}+#1#{} hand size.",
        "{C:inactive}Upgraded from: Palette{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 11, y = 0 },
    requires = { 'v_palette' },
    config = { extra = { size = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.size } }
    end,
    redeem = function(self, card)
        G.hand:change_size(card.ability.extra.size)
    end
}

SMODS.Voucher {
    key = 'tarot_master',
    loc_txt = {
      name = 'Tarot Master',
      text = {
        "After opening an {C:attention}Arcana Pack{},",
        "spawn a random {C:dark_edition}Negative{} {C:tarot}Tarot{} card.",
        "{C:inactive}Upgraded from: Tarot Tycoon{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 12, y = 0 },
    requires = { 'v_tarot_tycoon' },
    calculate = function(self, card, context)
        if context.open_booster and context.card.config.center.kind == 'Arcana' then
            SMODS.add_card{ set = "Tarot", edition = "e_negative"}
        end
    end
}

SMODS.Voucher {
    key = 'space_charter',
    loc_txt = {
      name = 'Space Charter',
      text = {
        "After opening a {C:attention}Celestial Pack{},",
        "spawn a random {C:dark_edition}Negative{} {C:planet}Planet{} card.",
        "{C:inactive}Upgraded from: Planet Tycoon{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 13, y = 0 },
    requires = { 'v_planet_tycoon' },
    calculate = function(self, card, context)
        if context.open_booster and context.card.config.center.kind == 'Celestial' then
            SMODS.add_card{ set = "Planet", edition = "e_negative"}
        end
    end
}

SMODS.Voucher {
    key = 'hallucination',
    loc_txt = {
      name = 'Hallucination',
      text = {
        "{C:attention}Playing cards{} in shop are guaranteed",
        "to have an {C:enhanced}Enhancement{} or {C:dark_edition}Edition{}.",
        "{C:inactive}Upgraded from: Illusion{}"
      }
    },
    discovered = true,
    atlas = "tier_3_vouchers",
    cost = 25,
    pos = { x = 14, y = 0 },
    requires = { 'v_illusion' },
    redeem = function(self, card)
      -- I don't even know how. But fuck it, we ball.
    end
}

SMODS.Voucher {
  key = 'script_writer',
  loc_txt = {
    name = 'Script Writer',
    text = {
      "Reduces boss reroll cost to {C:attention}$5{}.",
      "{C:inactive}Upgraded from: Retcon{}"
    }
  },
  discovered = true,
  atlas = "tier_3_vouchers",
  cost = 25,
  pos = { x = 15, y = 0 },
  requires = { 'v_retcon' },
  config = { extra = { money = 5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  redeem = function(self, card)
    G.GAME.EL_HORSO = 5
  end
}

--- UGLY as fuck hooks. But oh well, the show goes on. ---

function calculate_reroll_cost(skip_increment)
    if G.GAME.current_round.free_rerolls < 0 then G.GAME.current_round.free_rerolls = 0 end
    if G.GAME.current_round.free_rerolls > 0 then G.GAME.current_round.reroll_cost = 0; return end
    
    if G.GAME.used_vouchers["v_WCCO_insatiable_reroller"] then -- SealsOnEverything gets the credit.
        G.GAME.current_round.reroll_cost = 1
        return
    end

    G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase or 0
    if not skip_increment then G.GAME.current_round.reroll_cost_increase = G.GAME.current_round.reroll_cost_increase + 1 end
    G.GAME.current_round.reroll_cost = (G.GAME.round_resets.temp_reroll_cost or G.GAME.round_resets.reroll_cost) + G.GAME.current_round.reroll_cost_increase
end

function create_card_for_shop(area)
    if area == G.shop_jokers and G.SETTINGS.tutorial_progress and G.SETTINGS.tutorial_progress.forced_shop and G.SETTINGS.tutorial_progress.forced_shop[#G.SETTINGS.tutorial_progress.forced_shop] then
        local t = G.SETTINGS.tutorial_progress.forced_shop
        local _center = G.P_CENTERS[t[#t]] or G.P_CENTERS.c_empress
        local card = Card(area.T.x + area.T.w/2, area.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, _center, {bypass_discovery_center = true, bypass_discovery_ui = true})
        t[#t] = nil
        if not t[1] then G.SETTINGS.tutorial_progress.forced_shop = nil end
        
        create_shop_card_ui(card)
        return card
      else
        local forced_tag = nil
        for k, v in ipairs(G.GAME.tags) do
          if not forced_tag then
            forced_tag = v:apply_to_run({type = 'store_joker_create', area = area})
            if forced_tag then
              for kk, vv in ipairs(G.GAME.tags) do
                if vv:apply_to_run({type = 'store_joker_modify', card = forced_tag}) then break end
              end
              return forced_tag end
          end
        end
          G.GAME.spectral_rate = G.GAME.spectral_rate or 0
          local total_rate = G.GAME.joker_rate + G.GAME.tarot_rate + G.GAME.planet_rate + G.GAME.playing_card_rate + G.GAME.spectral_rate
          local polled_rate = pseudorandom(pseudoseed('cdt'..G.GAME.round_resets.ante))*total_rate
          local check_rate = 0
          for _, v in ipairs({
            {type = 'Joker', val = G.GAME.joker_rate},
            {type = 'Tarot', val = G.GAME.tarot_rate},
            {type = 'Planet', val = G.GAME.planet_rate},
            {type = (G.GAME.used_vouchers["v_illusion"] and pseudorandom(pseudoseed('illusion')) > 0.6) and 'Enhanced' or 'Base', val = G.GAME.playing_card_rate},
            {type = 'Spectral', val = G.GAME.spectral_rate},
          }) do
            if polled_rate > check_rate and polled_rate <= check_rate + v.val then
              local card = create_card(v.type, area, nil, nil, nil, nil, nil, 'sho')
              create_shop_card_ui(card, v.type, area)
              G.E_MANAGER:add_event(Event({
                  func = (function()
                      for k, v in ipairs(G.GAME.tags) do
                        if v:apply_to_run({type = 'store_joker_modify', card = card}) then break end
                      end
                      return true
                  end)
              }))
              if (v.type == 'Base' or v.type == 'Enhanced') and G.GAME.used_vouchers["v_illusion"] and (pseudorandom(pseudoseed('illusion')) > 0.8 or G.GAME.used_vouchers["v_WCCO_hallucination"]) then 
                local edition_poll = pseudorandom(pseudoseed('illusion'))
                local edition = {}
                if edition_poll > 1 - 0.15 then edition.polychrome = true
                elseif edition_poll > 0.5 then edition.holo = true
                else edition.foil = true
                end
                card:set_edition(edition)
              end
              return card
            end
            check_rate = check_rate + v.val
          end
      end
  end

-- All of this below is for Script Writer. This sucks. Stay in school, kids, or you'll end up like me.

G.FUNCS.reroll_boss_button = function(e)
  if ( (G.GAME.dollars-G.GAME.bankrupt_at) - 10 >= to_big(0) ) and G.GAME.used_vouchers["v_retcon"] or (G.GAME.used_vouchers["v_directors_cut"] and (G.GAME.dollars-G.GAME.bankrupt_at) - 10 >= to_big(0) and not G.GAME.round_resets.boss_rerolled) or (((G.GAME.dollars-G.GAME.bankrupt_at) - 5 >= to_big(0)) and G.GAME.used_vouchers["v_WCCO_script_writer"]) then 
    e.config.colour = G.C.RED
    e.config.button = 'reroll_boss'
    e.children[1].children[1].config.shadow = true
    if e.children[2] then e.children[2].children[1].config.shadow = true end 
  else
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
    e.children[1].children[1].config.shadow = false
    if e.children[2] then e.children[2].children[1].config.shadow = false end 
  end
end

G.FUNCS.reroll_boss = function(e)
  G.GAME.EL_HORSO = 10 
    stop_use()
    G.GAME.round_resets.boss_rerolled = true
    if not G.from_boss_tag then
      if G.GAME.used_vouchers["v_WCCO_script_writer"] then
        G.GAME.EL_HORSO = 5
        ease_dollars(-5)
      end
      if not G.GAME.used_vouchers["v_WCCO_script_writer"] then
        G.GAME.EL_HORSO = 10
        ease_dollars(-10)
      end
    end
    G.from_boss_tag = nil
    G.CONTROLLER.locks.boss_reroll = true
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          play_sound('other1')
          G.blind_select_opts.boss:set_role({xy_bond = 'Weak'})
          G.blind_select_opts.boss.alignment.offset.y = 20
          return true
        end
      }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.3,
      func = (function()
        local par = G.blind_select_opts.boss.parent
        G.GAME.round_resets.blind_choices.Boss = get_new_boss()

        G.blind_select_opts.boss:remove()
        G.blind_select_opts.boss = UIBox{
          T = {par.T.x, 0, 0, 0, },
          definition =
            {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
              UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
            }},
          config = {align="bmi",
                    offset = {x=0,y=G.ROOM.T.y + 9},
                    major = par,
                    xy_bond = 'Weak'
                  }
        }
        par.config.object = G.blind_select_opts.boss
        par.config.object:recalculate()
        G.blind_select_opts.boss.parent = par
        G.blind_select_opts.boss.alignment.offset.y = 0
        
        G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
            G.CONTROLLER.locks.boss_reroll = nil
            return true
          end
        }))

        save_run()
        for i = 1, #G.GAME.tags do
          if G.GAME.tags[i]:apply_to_run({type = 'new_blind_choice'}) then break end
        end
          return true
      end)
    }))
  end