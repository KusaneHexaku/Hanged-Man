SMODS.Seal {
    key = 'stone',
    atlas = 'HangedMan_Seals',
    pos = { x = 2, y = 0 },
    config = { extra = { } },
    badge_colour = HEX('d0d2d6'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.scale } }
    end,

    calculate = function(self, card, context)

        if context.modify_scoring_hand and context.cardarea == G.play then
            return {
                add_to_hand = true
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