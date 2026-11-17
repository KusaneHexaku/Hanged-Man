local foolish_aikoshen = {

['c_akyrs_planet_bishop_ring'] = {
    description = function(card)
        local description = {
            {{'Convert ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random card with no ', G.C.UI.TEXT_DARK}, },
            {{'enhancements ', G.C.FILTER}, {'held in to a ', G.C.UI.TEXT_DARK}, {'Ghost ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.end_of_round and context.game_over == false then
            G.GAME.akyrs_pure_unlocked = true
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_akyrs_pure_hands'),chips = '...', mult = '...', level=''})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true end }))
            update_hand_text({delay = 0}, {mult = '+', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true end }))
            update_hand_text({delay = 0}, {chips = '+', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true end }))
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
            delay(1.3)
            G.GAME.akyrs_pure_hand_modifier.multiplier = G.GAME.akyrs_pure_hand_modifier.multiplier + 1 * 0.5 * G.GAME.akyrs_pure_hand_modifier.level
            G.GAME.akyrs_pure_hand_modifier.level = G.GAME.akyrs_pure_hand_modifier.level + 1
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
    end
},

['c_akyrs_p_microscopium'] = {
    description = function(card)
        local description = {
            {{'Convert ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random card with no ', G.C.UI.TEXT_DARK}, },
            {{'enhancements ', G.C.FILTER}, {'held in to a ', G.C.UI.TEXT_DARK}, {'Ghost ', G.C.FILTER}, {'card', G.C.UI.TEXT_DARK}, },
        }
        return description
    end,
    info_queue = {

    },
    effect = function (card, context)
        if context.end_of_round and context.game_over == false then
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_words_long'),chips = '...', mult = '...', level=''})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true end }))
            update_hand_text({delay = 0}, {mult = '+', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true end }))
            update_hand_text({delay = 0}, {chips = '+', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true end }))
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
            delay(1.3)
            SMODS.upgrade_poker_hands({ hands = upgradeHand, instant = true})
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})

            -- Catching Aikoshen's Factorio multi-hand Planets cards
            elseif string.find(fool_c.key, 'c_akyrs_planet', 1, true) then

                --print('Aikoshen Planet detected!')
                local lockey = {
                    ['c_akyrs_planet_vulcanus'] = 'k_akyrs_pairs',
                    ['c_akyrs_planet_nauvis'] = 'k_akyrs_unique_hand_combo',
                    ['c_akyrs_planet_fulgora'] = 'k_akyrs_unique_flush_hands',
                    ['c_akyrs_planet_gleba'] = 'k_akyrs_unique_straight_hands',
                    ['c_akyrs_planet_aquilo'] = 'k_akyrs_any_combo_hands',
                    ['c_akyrs_planet_shattered'] = 'k_akyrs_gt5_hands',
                }

                AKYRS.auto_planet_anim(card, localize(lockey[fool_c.key]))
                SMODS.upgrade_poker_hands{hands = SMODS.Attributes[upgradeHand].keys, instant = true}
        end
    end
},

}

SMODS.merge_defaults(HangedMan.foolishJoker_effects, foolish_aikoshen)