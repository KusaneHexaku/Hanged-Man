SMODS.Seal {
    key = 'hiking',
    atlas = 'HangedMan_Seals',
    pos = { x = 0, y = 0 },
    config = { extra = { scale = 8 } },
    badge_colour = G.C.CHIPS,
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.scale } }
    end,

    calculate = function(self, card, context)

        if context.main_scoring and context.cardarea == G.play then
            card.ability.perma_bonus = (card.ability.perma_bonus or 0) + self.config.extra.scale
            return {
                message = ('Upgrade!'),
                colour = G.C.CHIPS
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