SMODS.Seal {
    key = 'space',
    atlas = 'HangedMan_Seals',
    pos = { x = 1, y = 0 },
    config = { extra = { chance = 7 } },
    badge_colour = G.C.UI.TEXT_INACTIVE,
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, self.config.extra.chance, 'HangedMan_spaceSeal')
        return { vars = { numerator, denominator } }
    end,

    calculate = function(self, card, context)

        if context.main_scoring and context.cardarea == G.play and SMODS.pseudorandom_probability(self, 'HangedMan_spaceSeal', 1, self.config.extra.chance) then
            SMODS.upgrade_poker_hands({ hands = {context.scoring_name}, instant = true })
            return {
                message = 'Level Up!'
            }
        end
        
    end,


    -- Shiny seal effect used for Gold seal, enable if you want reflective seal
    --[[draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end]]
}