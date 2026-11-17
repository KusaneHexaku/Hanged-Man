local experiments_effects_aikoshen = {

['aikoshen_bishopring'] = {
    key = 'aikoshen_bishopring',
    textbit = {
       {'increase level of ', G.C.UI.TEXT_DARK}, {'Pure Hands ', G.C.FILTER}, {'by ', G.C.UI.TEXT_DARK}, {'1', G.C.FILTER}
    },
    effect = function (card, context)
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
    end,
    available = function(card)
        return (next(SMODS.find_mod('aikoyorisshenanigans')))
    end,
},


}

SMODS.merge_defaults(HangedMan.experiments_effects, experiments_effects_aikoshen)