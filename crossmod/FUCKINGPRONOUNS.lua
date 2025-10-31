-- Custom Pronouns Set --

CardPronouns.Pronoun {
    colour = HEX("000000"),
    text_colour = HEX("FFFFFF"),
    pronoun_table = {"???", "???"},
    in_pool = function()
        return false
    end,
    key = "unknown"
}

-- Arya's Set

SMODS.Joker:take_ownership('WCCO_common_arya', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- no mod badge.
)

SMODS.Joker:take_ownership('WCCO_uncommon_arya', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_rare_arya', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_legendary_arya', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_legendary_arya', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_goddess_arya', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

-- Ember's Set

SMODS.Joker:take_ownership('WCCO_common_ember', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- no mod badge.
)

SMODS.Joker:take_ownership('WCCO_uncommon_ember', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_rare_ember', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_legendary_ember', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_youre_so_portugese', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "she_her"
    },
    true -- silent | suppresses mod badge
)

-- Delta's Set

SMODS.Joker:take_ownership('WCCO_common_delta', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "he_him"
    },
    true -- no mod badge.
)

SMODS.Joker:take_ownership('WCCO_uncommon_delta', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "he_him"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_rare_delta', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "he_him"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_legendary_delta', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "he_him"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_not_every_geek_has_a_commodore_64', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "he_him"
    },
    true -- silent | suppresses mod badge
)

-- Ghost And Pals Set

SMODS.Joker:take_ownership('WCCO_gap_scapegoat', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "unknown"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_gap_distortionist', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "unknown"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_gap_aura', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "unknown"
    },
    true -- silent | suppresses mod badge
)

SMODS.Joker:take_ownership('WCCO_gap_split_idol', -- object key (class prefix not required)
    { -- table of properties to change from the existing object
	    pronouns = "unknown"
    },
    true -- silent | suppresses mod badge
)

SMODS.Consumable:take_ownership('WCCO_spectral_summonarya',
    {
        pronouns = "she_her"
    },
    true
)

SMODS.Consumable:take_ownership('WCCO_spectral_summonember',
    {
        pronouns = "yuri" -- You asked.
    },
    true
)

SMODS.Consumable:take_ownership('WCCO_spectral_summondelta',
    {
        pronouns = "he_him"
    },
    true
)

SMODS.Consumable:take_ownership('WCCO_gem_delta',
    {
        pronouns = "he_him"
    },
    true
)

SMODS.Consumable:take_ownership('WCCO_gem_ember',
    {
        pronouns = "she_her"
    },
    true
)

SMODS.Consumable:take_ownership('WCCO_gem_arya',
    {
        pronouns = "she_her"
    },
    true
)

SMODS.Enhancement:take_ownership('WCCO_arya_enhancement',
    {
        pronouns = "she_her"
    },
    true
)

SMODS.Enhancement:take_ownership('WCCO_ember_enhancement',
    {
        pronouns = "she_her"
    },
    true
)

SMODS.Enhancement:take_ownership('WCCO_delta_enhancement',
    {
        pronouns = "he_him"
    },
    true
)

-- Just pure stupidity. These just get added into the pool. --

CardPronouns.Pronoun {
    colour = HEX("00FFFF"),
    text_colour = HEX("000000"),
    pronoun_table = {"Yaoi", "MLM", "Say Gex"},
    in_pool = function()
        return true
    end,
    key = "yaoi"
}

CardPronouns.Pronoun {
    colour = HEX("FF00FF"),
    text_colour = HEX("FFFFFF"),
    pronoun_table = {"Yuri", "WLW", "Sesbian Lex"},
    in_pool = function()
        return true
    end,
    key = "yuri"
}

CardPronouns.Pronoun {
    colour = HEX("FF5F00"),
    text_colour = HEX("FFFFFF"),
    pronoun_table = {"Furry", "UwU", "Yiff"},
    in_pool = function()
        return true
    end,
    key = "furry"
}

CardPronouns.Pronoun {
    colour = HEX("fff000"),
    text_colour = HEX("000000"),
    pronoun_table = {"^q^", "Yi", "Xi"},
    in_pool = function()
        return true
    end,
    key = "yixi"
}

CardPronouns.Pronoun {
    colour = HEX("3E00BB"),
    text_colour = HEX("FFFFFF"),
    pronoun_table = {"SINNER", "DEGENERATE"},
    in_pool = function()
        return true
    end,
    key = "depraved"
}

CardPronouns.Pronoun {
    colour = HEX("FF198C"),
    text_colour = HEX("FFFFFF"),
    pronoun_table = {"Dominant"},
    in_pool = function()
        return true
    end,
    key = "dom"
}

CardPronouns.Pronoun {
    colour = HEX("00E6E6"),
    text_colour = HEX("000000"),
    pronoun_table = {"Submissive"},
    in_pool = function()
        return true
    end,
    key = "sub"
}