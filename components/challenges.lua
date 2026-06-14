SMODS.Challenge {
    key = "shadow_arya",
    loc_txt = {
        name = "Shadow Self Battle: Arya"
    },
    rules = {
        custom = {
            {id = "shadow_arya"},
        },
        modifiers = {

        },
    },
    jokers = {
        { id = "j_WCCO_cursed_arya", eternal = true }
    }
}

SMODS.Challenge {
    key = "shadow_ember",
    loc_txt = {
        name = "Shadow Self Battle: Ember"
    },
    rules = {
        custom = {
            {id = "shadow_ember"},
        },
        modifiers = {
            
        },
    },
    jokers = {
        { id = "j_WCCO_cursed_ember", eternal = true }
    }
}

SMODS.Challenge {
    key = "shadow_delta",
    loc_txt = {
        name = "Shadow Self Battle: Delta"
    },
    rules = {
        custom = {
            {id = "shadow_delta"},
        },
        modifiers = {
            
        },
    },
    jokers = {
        { id = "j_WCCO_cursed_delta", eternal = true }
    }
}

SMODS.Challenge {
    key = "overdrive_only",
    loc_txt = {
        name = "MAXIMUM OVERDRIVE!!!"
    },
    jokers = {
        { id = "j_WCCO_OverdriveArya", eternal = true }
    },
    rules = {
        custom = {
            { id = 'no_reward' },
            { id = 'overdrive_only' },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
        },
        banned_tags = {
            { id = 'tag_skip' },
            { id = 'tag_investment' },
            { id = 'tag_handy' },
            { id = 'tag_garbage' },
            { id = 'tag_economy' },
        }
    }
}