local experiments_triggers_phanta = {

['phanta_playJunk'] = {
    key = 'phanta_playJunk',
    textbit = {
        {'When playing a ', G.C.UI.TEXT_DARK}, {'Junk', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        return context.joker_main and context.scoring_name == 'phanta_junk'
    end,
    available = function(card)
        return (next(SMODS.find_mod('GSPhanta')))
    end,
},

['phanta_hasGhostCard'] = {
    key = 'phanta_hasGhostCard',
    textbit = {
        {'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Ghost ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_phanta_ghostcard') then flag = true end
        end
        return context.joker_main and flag
    end,
    available = function(card)
        return (next(SMODS.find_mod('GSPhanta')))
    end,
},

['phanta_has3+GhostCard'] = {
    key = 'phanta_has3+GhostCard',
    textbit = {
        {'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ ', G.C.FILTER}, {'scoring ', G.C.UI.TEXT_DARK}, {'Ghost ', G.C.FILTER}, {'cards, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_phanta_ghostcard') then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return (next(SMODS.find_mod('GSPhanta'))) and SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 3)
    end,
},

['phanta_hasMarbleCard'] = {
    key = 'phanta_hasMarbleCard',
    textbit = {
        {'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Marble ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_phanta_marblecard') then flag = true end
        end
        return context.joker_main and flag
    end,
    available = function(card)
        return (next(SMODS.find_mod('GSPhanta')))
    end,
},

['phanta_has3+MarbleCard'] = {
    key = 'phanta_has3+MarbleCard',
    textbit = {
        {'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ ', G.C.FILTER}, {'scoring ', G.C.UI.TEXT_DARK}, {'Marble ', G.C.FILTER}, {'cards, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_phanta_marblecard') then count = count + 1 end
        end
        return context.joker_main and (count > 2)
    end,
    available = function(card)
        return (next(SMODS.find_mod('GSPhanta'))) and SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 3)
    end,
},

['phanta_fourGrates'] = {
    key = 'phanta_fourGrates',
    textbit = {
        {'If scoring hand contains all ', G.C.UI.TEXT_DARK}, {'4 ', G.C.FILTER}, {'Copper Grate ', HEX("904931")}, {'oxidisation ', G.C.FILTER}, {'levels, ', G.C.UI.TEXT_DARK}
    },
    eval = function (card, context)
        if not context.joker_main then return end
        local copper = {'m_phanta_coppergratefresh','m_phanta_coppergrateexposed','m_phanta_coppergrateweathered','m_phanta_coppergrateoxidised'}
        local levelcount = {0,0,0,0}
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            for i, level in ipairs(copper) do
                if SMODS.has_enhancement(playing_card, level) then levelcount[i] = levelcount[i] + 1 end
            end
        end
        for i = 1, 4, 1 do
            if levelcount[i] > 0 then count = count + 1 end
        end
        return context.joker_main and (count == 4)
    end,
    available = function(card)
        return (next(SMODS.find_mod('GSPhanta'))) and SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 3)
    end,
},


}

SMODS.merge_defaults(HangedMan.experiments_triggers, experiments_triggers_phanta)