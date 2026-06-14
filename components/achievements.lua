SMODS.Achievement {
    key = "Goddess_Awakened",
    loc_txt = {
        name = "Gambling Goddess",
        description = {
            "Use the 'Submit' Spectral to summon",
            "Arya, Dea Del Gioco D'azzardo!"
        }
    },
    reset_on_startup = true,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if next(SMODS.find_card("j_WCCO_goddess_arya")) then
            return true
        else
            return false
        end
    end
}

SMODS.Achievement {
    key = "Time_For_Hunting",
    loc_txt = {
        name = "Release The Hunting Hounds",
        description = {
            "Use the 'Huntress' Spectral to summon",
            "Ember, Spirit Of The Hunt!"
        }
    },
    reset_on_startup = true,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if next(SMODS.find_card("j_WCCO_youre_so_portugese")) then
            return true
        else
            return false
        end
    end
}

SMODS.Achievement {
    key = "System_Compromised",
    loc_txt = {
        name = "Not Exactly DEDSEC",
        description = {
            "Use the 'Corrupt' Spectral to summon",
            "Delta, Zero-Day Liability!"
        }
    },
    reset_on_startup = true,
    hidden_text = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if next(SMODS.find_card("j_WCCO_not_every_geek_has_a_commodore_64")) then
            return true
        else
            return false
        end
    end
}

SMODS.Achievement {
    key = "Lovely_Pair",
    loc_txt = {
        name = "The Dev And The Artist",
        description = {
            "Have both Common Arya",
            "and Ember in a run."
        }
    },
    reset_on_startup = true,
    hidden_name = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if next(SMODS.find_card("j_WCCO_common_arya")) and next(SMODS.find_card("j_WCCO_common_ember")) then
            return true
        else
            return false
        end
    end
}

SMODS.Achievement {
    key = "Lady_Luck",
    loc_txt = {
        name = "Luck Be A Lady Tonight!",
        description = {
            "Have all base rarities",
            "of Arya in a run."
        }
    },
    reset_on_startup = true,
    hidden_name = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if (next(SMODS.find_card('j_WCCO_common_arya')) and next(SMODS.find_card('j_WCCO_uncommon_arya')) and next(SMODS.find_card('j_WCCO_rare_arya')) and next(SMODS.find_card('j_WCCO_legendary_arya'))) then
            return true
        else
            return false
        end
    end
}

SMODS.Achievement {
    key = "arf_arf_bark",
    loc_txt = {
        name = "Puppy-pilled",
        description = {
            "Have all base rarities",
            "of Ember in a run."
        }
    },
    reset_on_startup = true,
    hidden_name = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if (next(SMODS.find_card('j_WCCO_common_ember')) and next(SMODS.find_card('j_WCCO_uncommon_ember')) and next(SMODS.find_card('j_WCCO_rare_ember')) and next(SMODS.find_card('j_WCCO_legendary_ember'))) then
            return true
        else
            return false
        end
    end
}

SMODS.Achievement {
    key = "system_breach_mf",
    loc_txt = {
        name = "No Threat Detected",
        description = {
            "Have all base rarities",
            "of Delta in a run."
        }
    },
    reset_on_startup = true,
    hidden_name = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if (next(SMODS.find_card('j_WCCO_common_delta')) and next(SMODS.find_card('j_WCCO_uncommon_delta')) and next(SMODS.find_card('j_WCCO_rare_delta')) and next(SMODS.find_card('j_WCCO_legendary_delta'))) then
            return true
        else
            return false
        end
    end
}

SMODS.Achievement {
    key = "going_up_up_up",
    loc_txt = {
        name = "The Ultimate Fan",
        description = {
            "Have all 3 W/LDCARD members...",
            "and the concert ticket!"
        }
    },
    reset_on_startup = true,
    hidden_name = true,
    bypass_all_unlocked = true,
    unlock_condition = function(self, args)
        if (next(SMODS.find_card('j_WCCO_KPDH_VenueTicket'))) then
            return true
        else
            return false
        end
    end
}