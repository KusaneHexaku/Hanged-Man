SMODS.Seal {
    key = 'glass',
    atlas = 'HangedMan_Seals',
    pos = { x = 3, y = 0 },
    config = { extra = { retriggers = 2, chance = 5, breaking = false } },
    badge_colour = HEX('d9e8e9'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, self.config.extra.chance, 'HangedMan_glassSeal')
        return { vars = { self.config.extra.retriggers, numerator, denominator } }
    end,

    calculate = function(self, card, context)

        if context.repetition then
            
            if SMODS.pseudorandom_probability(self, 'HangedMan_glassSeal', 1, self.config.extra.chance) then card.ability.seal.extra.breaking = true end

            return {
                repetitions = card.ability.seal.extra.retriggers,
            }
        end

        if context.after and card.ability.seal.extra.breaking then

            G.E_MANAGER:add_event(Event({
				trigger = 'before',
				func = function()
					card:juice_up()
                    card:set_seal()
                    play_sound('glass' .. math.random(1,2), 0.85, 0.6)
                    return true
				end
				}))
	

        end

        
    end,


    -- Shiny seal effect used for Gold seal, enable if you want reflective seal
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end
}