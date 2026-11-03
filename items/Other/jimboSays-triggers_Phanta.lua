local phanta_triggers = {

-- Jimbo Says crossmod triggers for GhostSalt's Phanta

-- always available

['phanta_playJunk'] = {
    key = 'phanta_playJunk',
    textbit = 'lay a Junk',
    eval = function (context)
        return context.scoring_name == 'phanta_junk'    
    end,
    available = function ()
        return next(SMODS.find_mod('GSPhanta'))
    end
},

-- enhancement gated triggers

['phanta_twoDifferentGrate'] = {
    key = 'phanta_twoDifferentGrate',
    textbit = 'lay a hand containing at least 2 Copper Grate cards with different oxidisation levels',
    eval = function (context)
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
        return (((levelcount[1] + levelcount[2] + levelcount[3] + levelcount[4]) > 1) and (count > 1))    
    end,
    available = function ()
        if not G.playing_cards then return false end
        local tally = 0
        local copper = {'m_phanta_coppergratefresh','m_phanta_coppergrateexposed','m_phanta_coppergrateweathered','m_phanta_coppergrateoxidised'}
       for _, playing_card in ipairs(G.playing_cards) do
            for i, level in ipairs(copper) do
                if SMODS.has_enhancement(playing_card, level) then tally = tally + 1 end
            end
        end
        return (tally > 3) and (next(SMODS.find_mod('GSPhanta')))
    end
},

['phanta_twoSameGrate'] = {
    key = 'phanta_twoSameGrate',
    textbit = 'lay a hand containing at least 2 Copper Grate cards where all of them are of the same oxidisation level',
    eval = function (context)
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
        return (((levelcount[1] + levelcount[2] + levelcount[3] + levelcount[4])) > 1 and (count == 1))    
    end,
    available = function ()
        if not G.playing_cards then return false end
        local tally = 0
        local copper = {'m_phanta_coppergratefresh','m_phanta_coppergrateexposed','m_phanta_coppergrateweathered','m_phanta_coppergrateoxidised'}
       for _, playing_card in ipairs(G.playing_cards) do
            for i, level in ipairs(copper) do
                if SMODS.has_enhancement(playing_card, level) then tally = tally + 1 end
            end
        end
        return (tally > 7) and (next(SMODS.find_mod('GSPhanta')))
    end
},


}

SMODS.merge_defaults(HangedMan.jimboSays_triggers, phanta_triggers)