-- Deck Code --

SMODS.Atlas {
  key = "sesbianlexdeck",
  path = "sesbianlexdeck.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "sesbianlex",
    path = "sesbianlexdeck.png",
    loc_txt = {
        name = 'Sesbian Lex Deck',
        text = {
            'Start with all {C:attention}Face Cards{}',
            'converted into {C:attention}Queens{}.',
            "{C:inactive}Now you just need to find Ember's Jokers...{}"
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "sesbianlexdeck",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                  if v:get_id() == 11 or v:get_id() == 13 then
                    SMODS.change_base(v, nil, "Queen")
                  end
                end
                return true
            end
        }))
    end
}

SMODS.Atlas {
  key = "saygexdeck",
  path = "saygexdeck.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "saygexdeck",
    path = "saygexdeck.png",
    loc_txt = {
        name = 'Say Gex Deck',
        text = {
            'Start with all {C:attention}Face Cards{}',
            'converted into {C:attention}Kings{}.',
            '{C:inactive}Just like Grindr!{}'
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "saygexdeck",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                  if v:get_id() == 12 or v:get_id() == 11 then
                    SMODS.change_base(v, nil, "King")
                  end
                end
                return true
            end
        }))
    end
}

SMODS.Atlas {
  key = "streamerclickbaitdeck",
  path = "streamerclickbaitdeck.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "streamerclickbaitdeck",
    path = "streamerclickbaitdeck.png",
    loc_txt = {
        name = 'Broken Baron Deck',
        text = {
            "This is a clickbait deck.",
            "You're better than this.",
            "{C:attention}#1# Joker slots.{}"
        }
    },
    config = {joker_slots = -2 },
    loc_vars = function(self, info_queue, back)
      return { vars = { self.config.joker_slots } }
    end,
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "streamerclickbaitdeck",
    apply = function(self, back)
      G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.joker_slots
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                  if v:get_id() ~= 13 then
                    SMODS.change_base(v, nil, "King")
                  end
                end
                SMODS.add_card{ key = "j_blueprint", stickers = { "eternal" }, force_stickers = true }
                SMODS.add_card{ key = "j_baron", stickers = { "eternal" }, force_stickers = true }
                SMODS.add_card{ key = "j_brainstorm", stickers = { "eternal" }, force_stickers = true }
                return true
            end
        }))
    end
}

SMODS.Atlas {
  key = "arya_but_deck",
  path = "arya_but_deck.png",
  px = 71,
  py = 95
}

SMODS.Back {
    key = "arya_but_deck",
    path = "arya_but_deck.png",
    loc_txt = {
        name = "Arya's Specialist Deck",
        text = {
            "{C:attention}Start with only 7s and Aces.{}",
            "{C:inactive}AKA: Luck-Coded Deck.{}",
            "{C:inactive}Art Credit: Lijourt{}"
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "arya_but_deck",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                  if v.base.suit == 'Hearts' or v.base.suit == 'Diamonds' then
                    SMODS.change_base(v, nil, "Ace")
                  else
                    SMODS.change_base(v, nil, "7")
                  end
                end
                return true
            end
        }))
    end
}

SMODS.Atlas {
  key = "upgraded_deck",
  path = "upgraded_deck.png",
  px = 71,
  py = 95
}

SMODS.Back {
  key = "upgraded_deck",
  path = "upgraded_deck.png",
  loc_txt = {
    name = "Upgraded Deck",
    text = {
      "{C:attention}All cards start with a random{}",
      "{C:attention}Wildcard Collection enhancement.{}",
      "{C:inactive}i.e: Enraged, Focused, Tranced.{}"
    }
  },
  pos = { x = 0, y = 0 },
  unlocked = true,
  atlas = "upgraded_deck",
  apply = function(self, back)
    G.E_MANAGER:add_event(Event({
      func = function()
        for k, v in pairs(G.playing_cards) do
          local random_enhancement = pseudorandom(pseudoseed('Upgraded Deck'))
          if random_enhancement <= 0.33 then
            v:set_ability("m_WCCO_arya_enhancement")
          elseif random_enhancement <= 0.66 then
            v:set_ability("m_WCCO_ember_enhancement")
          else
            v:set_ability("m_WCCO_delta_enhancement")
          end
        end
        return true
      end
    }))
  end
}

SMODS.Atlas {
  key = "chaotic_deck",
  path = "chaotic_deck.png",
  px = 71,
  py = 95
}

SMODS.Back {
  key = "chaotic_deck",
  path = "chaotic_deck.png",
  loc_txt = {
    name = "Truly Chaotic Deck",
    text = {
      "{C:attention}All cards' aspects{} are",
      "{C:attention}randomized completely!{}",
      "{C:inactive}This ain't your granny's Erratic Deck!{}"
    }
  },
  pos = { x = 0, y = 0 },
  unlocked = true,
  atlas = "chaotic_deck",
  apply = function(self, back)
    G.GAME.starting_params.erratic_suits_and_ranks = true -- This is a real thing that VanillaRemade tells you.
    G.E_MANAGER:add_event(Event({
      func = function()
        for k, v in pairs(G.playing_cards) do
          v:set_ability(SMODS.poll_enhancement { guaranteed = true }, nil, true) -- Gives a random enhancement.
          local random_edition = SMODS.poll_edition { key = "WCCO_seed", guaranteed = true, no_negative = true } -- Gives a random edition
          v:set_edition(random_edition)
          local random_seal = SMODS.poll_seal {key = "WCCO_seed", guaranteed = true} -- Gives a random seal
          v:set_seal(random_seal)
        end
        return true
      end
    }))
  end
}