local foolish_phanta = {

['c_phanta_grave'] = {
    description = function(card)
        local description = {
            {{'Convert ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random card with no ', G.C.UI.TEXT_DARK}, },
            {{'enhancements ', G.C.FILTER}, {'held in to a ', G.C.UI.TEXT_DARK}, {'Ghost ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_phanta_ghostcard']
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
                cardPicked:set_ability('m_phanta_ghostcard', nil, true)
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

['c_phanta_brazier'] = {
    description = function(card)
        local description = {
            {{'Convert ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random card with no ', G.C.UI.TEXT_DARK}, {'enhancements ', G.C.FILTER}, },
            {{'held in to a ', G.C.UI.TEXT_DARK}, {'Copper Grate (Fresh) ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_phanta_coppergratefreshshorter'], G.P_CENTERS['e_phanta_waxed_showcase']
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
                cardPicked:set_ability('m_phanta_coppergratefresh', nil, true)
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

['c_phanta_sculptor'] = {
    description = function(card)
        local description = {
            {{'Convert ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random card with no ', G.C.UI.TEXT_DARK}, },
            {{'enhancements ', G.C.FILTER}, {'held in to a ', G.C.UI.TEXT_DARK}, {'Marble ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['m_phanta_marblecard']
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
                cardPicked:set_ability('m_phanta_marblecard', nil, true)
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

['c_phanta_beekeeper'] = {
    description = function(card)
        local description = {
            {{'Apply ', G.C.UI.TEXT_DARK}, {'Waxed ', G.C.DARK_EDITION}, {'to ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random', G.C.UI.TEXT_DARK}, },
            {{'card with no ', G.C.UI.TEXT_DARK}, {'edition ', G.C.FILTER}, {'held in hand', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {
        G.P_CENTERS['e_phanta_waxed_showcase']
    },
    effect = function (card, context)
        if context.before and G.hand.cards then
            local eligible_hand_card = SMODS.Edition:get_edition_cards(G.hand, true)
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
                cardPicked:set_edition('e_phanta_waxed', true)
				check_for_unlock({ type = 'have_edition' })
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

['c_phanta_gatherer'] = {
    description = function(card)
        local description = {
            {{'Earn ', G.C.UI.TEXT_DARK}, {'$4 ', G.C.MONEY}, {'each hand', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.after and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    card:juice_up(0.3, 0.5)
                    ease_dollars(4, true)
                    return true
                end
            }))
		end
    end
},

['c_phanta_exorcist'] = {
    description = function(card)
        local description = {
            {{'Destroy up to ', G.C.UI.TEXT_DARK}, {'3 ', G.C.FILTER}, {'random playing cards', G.C.UI.TEXT_DARK}, },
            {{'held in hand at end of Blind', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.end_of_round and context.game_over == false then
            local cards = G.hand.cards
            local candidates = {}
            for i = 1, #cards do candidates[#candidates+1] = cards[i] end
            local selected = {}
            table.sort(candidates,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
            )
            local size = math.min(3, #candidates)
            HangedMan.better_pseudoshuffle(candidates, "hangedman_foolishJoker_exorcist")
            for i = 1, size do selected[#selected + 1] = candidates[i] end

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    card:juice_up(0.3, 0.5)
                    delay(0.2)
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            SMODS.destroy_cards(selected)
            delay(0.5)
		end
    end
},

['c_phanta_angel'] = {
    description = function(card)
        local description = {
            {{'Increase rank of cards held in hand', G.C.UI.TEXT_DARK}, },
            {{'by ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'at end of Blind', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.end_of_round and context.game_over == false then
            local candidates = G.hand.cards

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            for i = 1, #candidates do
                local percent = 1.15 - (i - 0.999) / (#candidates - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                    candidates[i]:flip()
                    play_sound("card1", percent)
                    candidates[i]:juice_up(0.3, 0.3)
                    return true
                    end
                }))
            end

            delay(0.2)

            for i = 1, #candidates do
                G.E_MANAGER:add_event(Event({
                    func = function()
                    assert(SMODS.modify_rank(candidates[i], 1))
                    return true
                    end
                }))
            end

            for i = 1, #candidates do
                local percent = 0.85 + (i - 0.999) / (#candidates - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                    candidates[i]:flip()
                    play_sound("tarot2", percent, 0.6)
                    candidates[i]:juice_up(0.3, 0.3)
                    return true
                    end
                }))
            end

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))

            delay(0.5)
		end
    end
},

['c_phanta_philosopher'] = {
    description = function(card)
        local description = {
            {{'When Blind is selected, choose ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'of ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, },
            {{'Tarot ', G.C.SECONDARY_SET.Tarot}, {'cards to create', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
				func = function()
					G.FUNCS.phanta_run_philo_menu(2)
					return true
				end
            }))

            G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                if not G.GAME.phanta_philo_cards then HangedMan.display_wheel_text(card, localize('k_nope_ex'), G.C.SECONDARY_SET.Tarot)
                else 
                    for i = 1, math.min(2, G.consumeables.config.card_limit - count_consumables()) do
                        G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.4,
                        blockable = false,
                        func = function()
                            if G.consumeables.config.card_limit > #G.consumeables.cards then
                            play_sound("timpani")
                            local _card = SMODS.add_card({ key = G.GAME.phanta_philo_cards[i].key, edition = G.GAME.phanta_philo_cards[i].edition })
                            for k, v in pairs(SMODS.Stickers) do
                                if _card.ability[k] or _card[k] then
                                _card:remove_sticker(k)
                                end
                            end
                            -- add any stickers it had
                            for _, v in ipairs(G.GAME.phanta_philo_cards[i].stickers) do
                                _card:add_sticker(v, true)
                            end
                            card:juice_up(0.3, 0.5)
                            end
                            return true
                        end
                        }))
                    end
                end
                return true
            end
            }))
            delay(0.4)
		end
    end
},

}

SMODS.merge_defaults(HangedMan.foolishJoker_effects, foolish_phanta)