SMODS.Atlas {
    key = "arya_enhancement",
    path = "arya_enhancement.png",
    px = 71,
    py = 95
}

SMODS.Enhancement {
    key = 'arya_enhancement',
    loc_txt = {
        name = 'Tranced',
        text = {
            '{X:mult,C:white}X1.25{} {C:mult}Mult{} and {X:chips,C:white}X1.25{} {C:chips}Chips{} on {C:attention}Small Blind & Big Blind{}.',
            '{X:mult,C:white}X2.50{} {C:mult}Mult{} and {X:chips,C:white}X2.50{} {C:chips}Chips{} on {C:attention}Boss Blinds{}.'
        }
    },
    atlas = 'arya_enhancement',
    discovered = true,
    pos = { x = 0, y = 0 },
    config = { extra = { x_chips = 1.25, x_mult = 1.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_chips, card.ability.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if G.GAME.blind.boss then
                return { xchips = (card.ability.extra.x_chips * 2), xmult = (card.ability.extra.x_mult * 2) }
            else
                return { xchips = card.ability.extra.x_chips, xmult = card.ability.extra.x_mult }
            end
        end
    end
}

SMODS.Atlas {
    key = "ember_enhancement",
    path = "ember_enhancement.png",
    px = 71,
    py = 95
}

SMODS.Enhancement {
    key = 'ember_enhancement',
    loc_txt = {
        name = 'Enraged',
        text = {
            '{C:attention}Retriggers twice when scored{}.'
        }
    },
    atlas = 'ember_enhancement',
    discovered = true,
    pos = { x = 0, y = 0 },
    config = { extra = { repetitions = 2 } },
    loc_vars = function(self, info_queue, card)
        return {} -- Ignore it.
    end,
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}

SMODS.Atlas {
    key = "delta_enhancement",
    path = "delta_enhancement.png",
    px = 71,
    py = 95
}

SMODS.Enhancement {
    key = 'delta_enhancement',
    loc_txt = {
        name = 'Focused',
        text = {
            '{C:attention}Upgrades played hand type{} by {C:attention}1 level{}.'
        }
    },
    atlas = 'delta_enhancement',
    discovered = true,
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_chips, card.ability.x_mult } }
    end,
    calculate = function(self, card, context)
		if context.final_scoring_step and context.cardarea == G.play then
			return {
				level_up = true
			}
		end
	end
}