HangedMan.foolishJoker_effects = {

['c_magician'] = {
    description = function(card)
        local description = {
            {{'Cards with no ', G.C.UI.TEXT_DARK}, {'enhancements ', G.C.FILTER}, {'are', G.C.UI.TEXT_DARK}, },
            {{'converted to ', G.C.UI.TEXT_DARK}, {'Lucky ', G.C.FILTER}, {'cards when scored', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_lucky']
    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if not next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:set_ability('m_lucky', nil, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_empress'] = {
    description = function(card)
        local description = {
            {{'Cards with no ', G.C.UI.TEXT_DARK}, {'enhancements ', G.C.FILTER}, {'are', G.C.UI.TEXT_DARK}, },
            {{'converted to ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.FILTER}, {'cards when scored', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_mult']
    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if not next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:set_ability('m_mult', nil, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_heirophant'] = {
    description = function(card)
        local description = {
            {{'Cards with no ', G.C.UI.TEXT_DARK}, {'enhancements ', G.C.FILTER}, {'are', G.C.UI.TEXT_DARK}, },
            {{'converted to ', G.C.UI.TEXT_DARK}, {'Bonus ', G.C.FILTER}, {'cards when scored', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_bonus']
    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if not next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:set_ability('m_bonus', nil, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_lovers'] = {
    description = function(card)
        local description = {
            {{'Cards with no ', G.C.UI.TEXT_DARK}, {'enhancements ', G.C.FILTER}, {'are', G.C.UI.TEXT_DARK}, },
            {{'converted to ', G.C.UI.TEXT_DARK}, {'Wild ', G.C.FILTER}, {'cards when scored', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_wild']
    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if not next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:set_ability('m_wild', nil, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_devil'] = {
    description = function(card)
        local description = {
            {{'Cards with no ', G.C.UI.TEXT_DARK}, {'enhancements ', G.C.FILTER}, {'are', G.C.UI.TEXT_DARK}, },
            {{'converted to ', G.C.UI.TEXT_DARK}, {'Gold ', G.C.FILTER}, {'cards when scored', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_gold']
    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if not next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:set_ability('m_gold', nil, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_strength'] = {
    description = function(card)
        local description = {
            {{'Increase rank of scored cards by ', G.C.UI.TEXT_DARK}, {'1', G.C.FILTER}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if (not scored_card.debuff) and (not SMODS.has_no_rank(scored_card)) then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                assert(SMODS.modify_rank(scored_card, 1))
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_star'] = {
    description = function(card)
        local description = {
            {{'Convert suit of scored cards to ', G.C.UI.TEXT_DARK}, {'Diamonds', G.C.SUITS.Diamonds}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if (not scored_card.debuff) then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:change_suit('Diamonds')
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_moon'] = {
    description = function(card)
        local description = {
            {{'Convert suit of scored cards to ', G.C.UI.TEXT_DARK}, {'Clubs', G.C.SUITS.Clubs}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if (not scored_card.debuff) then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:change_suit('Clubs')
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_sun'] = {
    description = function(card)
        local description = {
            {{'Convert suit of scored cards to ', G.C.UI.TEXT_DARK}, {'Hearts', G.C.SUITS.Hearts}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if (not scored_card.debuff) then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:change_suit('Hearts')
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_world'] = {
    description = function(card)
        local description = {
            {{'Convert suit of scored cards to ', G.C.UI.TEXT_DARK}, {'Spades', G.C.SUITS.Spades}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.before then
            local toEnhance = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card.foolishEnhance = nil
                if (not scored_card.debuff) then
                    scored_card.foolishEnhance = true
                    toEnhance[#toEnhance + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                    }))
                end
				delay(0.25)
            end
            delay(0.3)
            for _i, scored_card in ipairs(toEnhance) do
                scored_card:change_suit('Spades')
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        scored_card:flip()
                        scored_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        scored_card.foolishEnhance = nil
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_chariot'] = {
    description = function(card)
        local description = {
            {{'Convert ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random card with no ', G.C.UI.TEXT_DARK}, },
            {{'enhancements ', G.C.FILTER}, {'held in to a ', G.C.UI.TEXT_DARK}, {'Steel ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_steel']
    },
    effect = function (card, context)
        if context.before and G.hand.cards then
            local eligible_hand_card = {}
            for _i, v in ipairs(G.hand.cards) do if not next(SMODS.get_enhancements(v)) then eligible_hand_card[#eligible_hand_card + 1] = v end end
            local cardPicked = pseudorandom_element(eligible_hand_card, pseudoseed('foolishJoker'))

            if cardPicked then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        cardPicked:flip()
                        cardPicked:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                }))
                delay(0.7)
                cardPicked:set_ability('m_steel', nil, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        cardPicked:flip()
                        cardPicked:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_justice'] = {
    description = function(card)
        local description = {
            {{'Convert ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random card with no ', G.C.UI.TEXT_DARK}, },
            {{'enhancements ', G.C.FILTER}, {'held in to a ', G.C.UI.TEXT_DARK}, {'Glass ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_glass']
    },
    effect = function (card, context)
        if context.before and G.hand.cards then
            local eligible_hand_card = {}
            for _i, v in ipairs(G.hand.cards) do if not next(SMODS.get_enhancements(v)) then eligible_hand_card[#eligible_hand_card + 1] = v end end
            local cardPicked = pseudorandom_element(eligible_hand_card, pseudoseed('foolishJoker'))

            if cardPicked then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        cardPicked:flip()
                        cardPicked:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                }))
                delay(0.7)
                cardPicked:set_ability('m_glass', nil, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        cardPicked:flip()
                        cardPicked:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_tower'] = {
    description = function(card)
        local description = {
            {{'Convert ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random card with no ', G.C.UI.TEXT_DARK}, },
            {{'enhancements ', G.C.FILTER}, {'held in to a ', G.C.UI.TEXT_DARK}, {'Stone ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_stone']
    },
    effect = function (card, context)
        if context.before and G.hand.cards then
            local eligible_hand_card = {}
            for _i, v in ipairs(G.hand.cards) do if not next(SMODS.get_enhancements(v)) then eligible_hand_card[#eligible_hand_card + 1] = v end end
            local cardPicked = pseudorandom_element(eligible_hand_card, pseudoseed('foolishJoker'))

            if cardPicked then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        cardPicked:flip()
                        cardPicked:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)							
                        return true
                    end
                }))
                delay(0.7)
                cardPicked:set_ability('m_stone', nil, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        cardPicked:flip()
                        cardPicked:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                        return true
                    end
                }))
                delay(0.25)
            end
        end
    end
},

['c_high_priestess'] = {
    description = function(card)
        local description = {
            {{'Creates up to ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random ', G.C.UI.TEXT_DARK}, {'Planet ', G.C.SECONDARY_SET.Planet}, {'card', G.C.UI.TEXT_DARK}, },
            {{'(must have room)', G.C.UI.TEXT_INACTIVE},}
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.after and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    SMODS.add_card {
                        set = 'Planet',
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
        end
    end
},

['c_emperor'] = {
    description = function(card)
        local description = {
            {{'Creates up to ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random ', G.C.UI.TEXT_DARK}, {'Tarot ', G.C.SECONDARY_SET.Tarot}, {'card', G.C.UI.TEXT_DARK}, },
            {{'(must have room)', G.C.UI.TEXT_INACTIVE},}
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.after and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    SMODS.add_card {
                        set = 'Tarot',
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
        end
    end
},

['c_hermit'] = {
    description = function(card)
        local description = {
            {{'Gain ', G.C.UI.TEXT_DARK}, {'20% ', G.C.FILTER}, {'of current money', G.C.UI.TEXT_DARK}, },
            {{'(Max of $20)', G.C.UI.TEXT_INACTIVE},}
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.after then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    card:juice_up(0.3, 0.5)
                    ease_dollars(math.max(0, math.min(math.floor(G.GAME.dollars*0.2),20)), true)
                    return true
            	end
        	}))
        	delay(0.6)
        end
    end
},

['c_temperance'] = {
    description = function(card)
        local description = {
            {{'Give the ', G.C.UI.TEXT_DARK}, {'sell value ', G.C.FILTER}, {'of', G.C.UI.TEXT_DARK}, },
            {{'a random held Joker', G.C.UI.TEXT_DARK},}
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.after and G.jokers.cards then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    card:juice_up(0.3, 0.5)
                    ease_dollars(pseudorandom_element(G.jokers.cards, pseudoseed('foolishJoker')).sell_cost, true)
                    return true
                end
            }))
            delay(0.6)
        end
    end
},


['c_wheel_of_fortune'] = {
    description = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, 4, 'foolish_wheel')
        local description = {
            {{numerator..' in '..denominator..' ' , G.C.GREEN}, {'chance to add ', G.C.UI.TEXT_DARK}, {'Foil', G.C.DARK_EDITION}, {',', G.C.UI.TEXT_DARK},  },
            {{'Holographic', G.C.DARK_EDITION}, {', or ', G.C.UI.TEXT_DARK}, {'Polychrome', G.C.DARK_EDITION},},
            {{'edition to a random ', G.C.UI.TEXT_DARK}, {'Joker', G.C.FILTER},}
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS["e_foil"],
        G.P_CENTERS["e_holo"],
        G.P_CENTERS["e_polychrome"]
    },
    effect = function (card, context)
        if context.after and G.jokers.cards then
            if SMODS.pseudorandom_probability(card, 'foolishJoker', 1, 4) then
                local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
                local eligible_card = pseudorandom_element(editionless_jokers, 'foolishJoker')
                local edition = SMODS.poll_edition { key = 'foolishJoker', guaranteed = true, no_negative = true, options = { 'e_polychrome', 'e_holo', 'e_foil' } }

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        eligible_card:set_edition(edition, true)
                        check_for_unlock({ type = 'have_edition' })
                        return true
                    end
                }))

            else
                HangedMan.display_wheel_text(card, localize('k_nope_ex'), G.C.SECONDARY_SET.Tarot)
            end
        end
    end
},

['c_judgement'] = {
    description = function(card)
        local description = {
            {{'Creates a random ', G.C.UI.TEXT_DARK}, {'Joker ', G.C.FILTER}, {'at end of Blind ', G.C.UI.TEXT_DARK},},
            {{'(must have room)', G.C.UI.TEXT_INACTIVE},}
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.end_of_round and context.game_over == false and G.jokers and (#G.jokers.cards < G.jokers.config.card_limit) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    SMODS.add_card({ set = 'Joker' })
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
    end
},

['c_death'] = {
    description = function(card)
        local description = {
            {{'When discarding exactly ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'cards, convert ', G.C.UI.TEXT_DARK},},
            {{'the left ', G.C.FILTER}, {'card into the ', G.C.UI.TEXT_DARK}, {'right ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK},}
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.pre_discard and not context.blueprint and #context.full_hand == 2 then 
            card.ability.extra.deathActivating = false
            local rightmost = G.hand.highlighted[1]
            for i = 1, #G.hand.highlighted do
                if G.hand.highlighted[i].T.x > rightmost.T.x then
                    rightmost = G.hand.highlighted[i]
                end
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.2)
            end
            delay(0.6)

            for i = 1, #G.hand.highlighted do
                if G.hand.highlighted[i] ~= rightmost then
                    copy_card(rightmost, G.hand.highlighted[i])
                end
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.2)
            end
            delay(0.5)
		end
    end
},

['c_hanged_man'] = {
    description = function(card)
        local description = {
            {{'Destroy all cards in ', G.C.UI.TEXT_DARK}, {'first ', G.C.FILTER}, {'discard of Blind', G.C.UI.TEXT_DARK},},
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.discard and not context.blueprint and G.GAME.current_round.discards_used <= 0 then
            for i, v in ipairs(G.hand.highlighted) do
                if SMODS.shatters(v) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            v:shatter() 
                            return true
                        end
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            v:start_dissolve()
                            return true
                        end
                    }))
                end
                delay(0.3)
                return { remove = true, delay = 0.3 }
            end
            delay(0.5)
		end
    end
},

['planet_replication_catchall'] = {
    description = function(card)
        local description = {
            {{'Upgrade the hand of this ', G.C.UI.TEXT_DARK}, {'Planet', G.C.SECONDARY_SET.Planet}, },
            {{'card when Blind is defeated', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.end_of_round and context.game_over == false then
            local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
            if not fool_c then return end
            local upgradeHand = HangedMan.planet_hand_type_from_key(fool_c.key) or nil
			if not upgradeHand then return end
            SMODS.upgrade_poker_hands({ hands = {upgradeHand}})
        end
    end
},



}