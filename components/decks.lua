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
            '{C:inactive}AKA: Baron Clickbait 101!{}'
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
            "I don't even need to explain it.",
            "You're already gonna win. Trust me."
        }
    },
    pos = { x = 0, y = 0 },
    unlocked = true,
    atlas = "streamerclickbaitdeck",
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                  if v:get_id() ~= 13 then
                    SMODS.change_base(v, nil, "King")
                  end
                end
                SMODS.add_card{ key = "j_blueprint", stickers = { "eternal" } }
                SMODS.add_card{ key = "j_baron", stickers = { "eternal" } }
                SMODS.add_card{ key = "j_brainstorm", stickers = { "eternal" } }
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