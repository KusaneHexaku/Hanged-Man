SMODS.Challenge {
    key = 'ultimateDraftChal',
    rules = {
        custom = {
            { id = 'ultimate_draft_large_shop' },
            { id = 'ultimate_draft_close_shop_upon_leave'}
        },
        modifiers = {
            { id = 'dollars', value = 150 },
        }
    },

    apply = function(self)
        change_shop_size(3)
        SMODS.change_booster_limit(1)
        SMODS.change_voucher_limit(2)
                
        G.GAME.skip_shop = false
    end,

    calculate = function(self, context)

        if context.ending_shop and not G.GAME.skip_shop then
            G.GAME.skip_shop = true
            change_shop_size(-5)
            SMODS.change_voucher_limit(-3)
            SMODS.change_booster_limit(-3)
        end
        
    end
}