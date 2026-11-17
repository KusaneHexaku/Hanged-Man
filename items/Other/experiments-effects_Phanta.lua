local experiments_effects_phanta = {

['phanta_randomHanafuda'] = {
    key = 'phanta_randomHanafuda',
    textbit = {
       {'spawn a random ', G.C.UI.TEXT_DARK}, {'Hanafuda ', HEX("DB534A")}, {'(Phanta) ', HEX("4d1575")}, {'card ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}
    },
    effect = function (card, context)
        local phanta_hanaset = pseudorandom_element({"phanta_chaff", "phanta_chaff", "phanta_chaff", "phanta_chaff", "phanta_chaff", "phanta_ribbon", "phanta_ribbon", "phanta_animal", "phanta_animal", "phanta_bright" }, pseudoseed('j_hangedman_experiments'))
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('timpani')
                    local new_card = SMODS.create_card({ set = phanta_hanaset, key_append = "experiments" })
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                    card:juice_up(0.3, 0.5)
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
        end
    end,
    available = function(card)
        return (next(SMODS.find_mod('GSPhanta')))
    end,
},


}

SMODS.merge_defaults(HangedMan.experiments_effects, experiments_effects_phanta)