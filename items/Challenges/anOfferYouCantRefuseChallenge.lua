SMODS.Challenge {
    key = 'anOfferYouCantRefuseChal',

    rules = {
        custom = {
            { id = 'prevent_shop_exit_until_purchase' }
        },
    },

    
    calculate = function(self, context)

        if context.starting_shop then G.GAME.prevent_shop_exit = true end

        if (context.buying_card or context.open_booster) and G.GAME.prevent_shop_exit then G.GAME.prevent_shop_exit = false end

    end
}