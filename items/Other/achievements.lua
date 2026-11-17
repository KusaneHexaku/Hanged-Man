-- Winner Winner: Escape The Tower
SMODS.Achievement{
    key = "escape_theTower",
    hidden_name = false,
    hidden_text = false,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "escape_tower") then
            return true
        end
    end
}

-- Full House: Reveal the entire Secret Message
SMODS.Achievement{
    key = "reveal_entire_secretMessage",
    hidden_name = false,
    hidden_text = false,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "reveal_entire_secretMessage" and args.remaining < 1) then
            return true
        end
    end
}

-- Wiped Out: Let the tide swallow you
SMODS.Achievement{
    key = "rideTheTide_wipedout",
    hidden_name = false,
    hidden_text = false,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "rideTheTide_wipedout") then
            return true
        end
    end
}

-- Blackout: Fully fill out the Bingo Card
SMODS.Achievement{
    key = "bingoCard_blackout",
    hidden_name = false,
    hidden_text = false,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "bingoCard_blackout" and args.lines > 14 ) then
            return true
        end
    end
}

-- Unending Thorns: Reveal the entire Spiral of Stars
SMODS.Achievement{
    key = "complete_the_spiralOfStars",
    hidden_name = false,
    hidden_text = false,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "complete_the_spiralOfStars" and args.stars > 63 ) then
            return true
        end
    end
}

-- Who Wants to be a Trivia Machine?: Correctly answer 12 questions in a row (Wild Cards do not count)
SMODS.Achievement{
    key = "who_wants_to_be_a_triviaMachine",
    hidden_name = false,
    hidden_text = false,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "who_wants_to_be_a_triviaMachine" and args.streak > 11 ) then
            return true
        end
    end
}

-- Stacked Odds: Upgrade Cyclomancy 5 times with a single hand
SMODS.Achievement{
    key = "cyclomancy_stacked_odds",
    hidden_name = false,
    hidden_text = false,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "cyclomancy_stacked_odds" and args.streak > 4 ) then
            return true
        end
    end
}

-- Synesthesia: Cashout right at the moment The Colour of Money is about to destroy itself
SMODS.Achievement{
    key = "theColourOfMoney_synesthesia",
    hidden_name = false,
    hidden_text = false,
    bypass_all_unlocked = true,
    unlock_condition = function (self, args)
        if args and (args.type == "theColourOfMoney_synesthesia" ) then
            return true
        end
    end
}