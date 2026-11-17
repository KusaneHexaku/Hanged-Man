HangedMan.experiments_triggers = {

['containPair'] = {
    key = 'containPair',
    textbit = {
        {'If hand contains a ', G.C.UI.TEXT_DARK}, {'Pair', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.joker_main and next(context.poker_hands["Pair"])
    end,
    available = function(card)
        return true
    end,
},

['containThree'] = {
    key = 'containThree',
    textbit = {
        {'If hand contains a ', G.C.UI.TEXT_DARK}, {'Three of a Kind', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.joker_main and next(context.poker_hands["Three of a Kind"])
    end,
    available = function(card)
        return true
    end,
},

['containFlush'] = {
    key = 'containFlush',
    textbit = {
        {'If hand contains a ', G.C.UI.TEXT_DARK}, {'Flush', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.joker_main and next(context.poker_hands["Flush"])
    end,
    available = function(card)
        return true
    end,
},

['containStraight'] = {
    key = 'containStraight',
    textbit = {
        {'If hand contains a ', G.C.UI.TEXT_DARK}, {'Straight', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.joker_main and next(context.poker_hands["Straight"])
    end,
    available = function(card)
        return true
    end,
},

['3+Clubs'] = {
    key = '3+Clubs',
    textbit = {
        {'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring ', G.C.FILTER}, {'Clubs ', G.C.SUITS.Clubs}, {'cards, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Clubs') then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return true
    end,
},

['3+Hearts'] = {
    key = '3+Hearts',
    textbit = {
        {'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring ', G.C.FILTER}, {'Hearts ', G.C.SUITS.Hearts}, {'cards, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Hearts') then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return true
    end,
},

['3+Spades'] = {
    key = '3+Spades',
    textbit = {
        {'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring ', G.C.FILTER}, {'Spades ', G.C.SUITS.Spades}, {'cards, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Spades') then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return true
    end,
},

['3+Diamonds'] = {
    key = '3+Diamonds',
    textbit = {
        {'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring ', G.C.FILTER}, {'Diamonds ', G.C.SUITS.Diamonds}, {'cards, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Diamonds') then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return true
    end,
},

['3+Aces'] = {
    key = '3+Aces',
    textbit = {
        {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring Aces', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:get_id() and playing_card:get_id() == 14 then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 2)
    end,
},

['3+Kings'] = {
    key = '3+Kings',
    textbit = {
        {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring Kings', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:get_id() and playing_card:get_id() == 13 then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 2)
    end,
},

['3+Queens'] = {
    key = '3+Queens',
    textbit = {
        {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring Queens', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:get_id() and playing_card:get_id() == 12 then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 2)
    end,
},

['3+Jacks'] = {
    key = '3+Jacks',
    textbit = {
        {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring Jacks', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:get_id() and playing_card:get_id() == 11 then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 2)
    end,
},

['NoFace'] = {
    key = 'NoFace',
    textbit = {
        {'If hand contains ', G.C.UI.TEXT_DARK}, {'NO ', G.C.RED}, {'scoring face cards, ', G.C.FILTER}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local flag = true
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_face() then flag = false end
        end
        return context.joker_main and flag
    end,
    available = function(card)
        return true
    end,
},

['OnlyFace'] = {
    key = 'OnlyFace',
    textbit = {
        {'If hand contains ', G.C.UI.TEXT_DARK}, {'ONLY ', G.C.BLUE}, {'scoring face cards, ', G.C.FILTER}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local flag = true
        for _, playing_card in ipairs(context.scoring_hand) do
            if not (playing_card:is_face()) then flag = false end
        end
        return context.joker_main and flag
    end,
    available = function(card)
        return true
    end,
},

['hasGoldCard'] = {
    key = 'hasGoldCard',
    textbit = {
        {'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Gold ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_gold') then flag = true end
        end
        return context.joker_main and flag
    end,
    available = function(card)
        return true
    end,
},

['hasSteelCard'] = {
    key = 'hasSteelCard',
    textbit = {
        {'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Steel ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_steel') then flag = true end
        end
        return context.joker_main and flag
    end,
    available = function(card)
        return true
    end,
},

['hasStoneCard'] = {
    key = 'hasStoneCard',
    textbit = {
        {'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Stone ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_stone') then flag = true end
        end
        return context.joker_main and flag
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 2)
    end,
},

['glassBreak'] = {
    key = 'glassBreak',
    textbit = {
        {'When a ', G.C.UI.TEXT_DARK}, {'Glass ', G.C.FILTER}, {'card breaks, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        local flag = false
        if context.remove_playing_cards and not context.blueprint then
            for _, removed_card in ipairs(context.removed) do
                if removed_card.shattered then flag = true end
            end
        end

        if context.using_consumeable and context.consumeable.config.center.key == 'c_hanged_man' then
            for _, removed_card in ipairs(G.hand.highlighted) do
                if SMODS.has_enhancement(removed_card, 'm_glass') then flag = true end
            end
        end

        return (context.remove_playing_cards or context.using_consumeable) and flag
    end,
    available = function(card)
        return true
    end,
},

['tarotUse'] = {
    key = 'tarotUse',
    textbit = {
        {'When a ', G.C.UI.TEXT_DARK}, {'Tarot ', G.C.SECONDARY_SET.Tarot}, {'card is used, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.using_consumeable and (context.consumeable.ability.set == 'Tarot')
    end,
    available = function(card)
        return true
    end,
},

['planetUse'] = {
    key = 'planetUse',
    textbit = {
        {'When a ', G.C.UI.TEXT_DARK}, {'Planet ', G.C.SECONDARY_SET.Planet}, {'card is used, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.using_consumeable and (context.consumeable.ability.set == 'Planet')
    end,
    available = function(card)
        return true
    end,
},

['discard1Card'] = {
    key = 'discard1Card',
    textbit = {
        {'When discarding ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.discard and (#context.full_hand == 1)
    end,
    available = function(card)
        return true
    end,
},

['cardSold'] = {
    key = 'cardSold',
    textbit = {
        {'When a card is ', G.C.UI.TEXT_DARK}, {'sold', G.C.MONEY}, {', ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.selling_card
    end,
    available = function(card)
        return true
    end,
},

['voucherBuy'] = {
    key = 'voucherBuy',
    textbit = {
        {'When a ', G.C.UI.TEXT_DARK}, {'Voucher ', G.C.FILTER}, {'is purchased, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.buying_card and context.card.ability.set == 'Voucher'
    end,
    available = function(card)
        return true
    end,
},

['shopSkipped'] = {
    key = 'shopSkipped',
    textbit = {
        {'When a ', G.C.UI.TEXT_DARK}, {'Shop ', G.C.FILTER}, {'is left without any purchases, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.ending_shop and G.GAME.HangedMan_have_not_bought_something_in_shop
    end,
    available = function(card)
        return true
    end,
},


}