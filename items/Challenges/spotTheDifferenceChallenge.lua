SMODS.Challenge {
    key = 'spotTheDifferenceChal',

    rules = {
        custom = {
            { id = 'imposterous_increase' }
        },
        vouchers = {
        { id = 'v_overstock_norm' },
        { id = 'v_money_tree' },
    }

    },
    
    calculate = function(self, context)

        --[[
        if context.modify_weights and context.pool_types.Joker then
            for idx, v in pairs(context.pool) do
                if not G.P_CENTERS[v.key] then 
                elseif v.key == 'j_hangedman_imposterous' then context.pool[idx].weight = (G.GAME.imposterous_challenge_rate or 1280)
                else end
            end
        end
        ]]
        
        if context.end_of_round and context.main_eval then
            G.GAME.imposterous_challenge_rate = G.GAME.imposterous_challenge_rate or 1280
            G.GAME.imposterous_challenge_rate = math.min(G.GAME.imposterous_challenge_rate * 2, 20480)
        end


    end
}