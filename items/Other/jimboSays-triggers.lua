HangedMan.jimboSays_triggers = {

-- default triggers

['playFlush'] = {
    key = 'playFlush',
    textbit = 'lay a hand containing a Flush',
    eval = function (context)
        return next(context.poker_hands["Flush"])    
    end,
    available = function ()
        return true
    end
},

['playStraight'] = {
    key = 'playStraight',
    textbit = 'lay a hand containing a Straight',
    eval = function (context)
        return next(context.poker_hands["Straight"])    
    end,
    available = function ()
        return true
    end
},

['playFullHouse'] = {
    key = 'playFullHouse',
    textbit = 'lay a hand containing a Full House',
    eval = function (context)
        return next(context.poker_hands["Full House"])    
    end,
    available = function ()
        return true
    end
},

['playTwoPair'] = {
    key = 'playTwoPair',
    textbit = 'lay a hand containing a Two Pair',
    eval = function (context)
        return next(context.poker_hands["Two Pair"])    
    end,
    available = function ()
        return true
    end
},

['playHighCard'] = {
    key = 'playHighCard',
    textbit = 'lay a High Card',
    eval = function (context)
        return (context.scoring_name == 'High Card')    
    end,
    available = function ()
        return true
    end
},

['playNoFace'] = {
    key = 'playNoFace',
    textbit = 'lay a hand with no scoring face cards',
    eval = function (context)
        local flag = true
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_face() then flag = false end
        end
        return flag  
    end,
    available = function ()
        return true
    end
},

['playAllFace'] = {
    key = 'playAllFace',
    textbit = 'lay a hand with no scoring non-face cards',
    eval = function (context)
        local flag = true
        for _, playing_card in ipairs(context.scoring_hand) do
            if not (playing_card:is_face()) then flag = false end
        end
        return flag  
    end,
    available = function ()
        return true
    end
},

['playThreeSevens'] = {
    key = 'playThreeSevens',
    textbit = 'lay a hand with at least 3 scoring 7s',
    eval = function (context)
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:get_id() == 7 then count = count + 1 end
        end
        return (count > 2)  
    end,
    available = function ()
        return true
    end
},

['playThreeAces'] = {
    key = 'playThreeAces',
    textbit = 'lay a hand with at least 3 scoring Aces',
    eval = function (context)
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:get_id() == 14 then count = count + 1 end
        end
        return (count > 2)  
    end,
    available = function ()
        return true
    end
},

['playOneCard'] = {
    key = 'playOneCard',
    textbit = 'lay exactly 1 card',
    eval = function (context)
        return (#context.full_hand == 1) 
    end,
    available = function ()
        return true
    end
},

['playFourCard'] = {
    key = 'playOneCard',
    textbit = 'lay exactly 4 cards',
    eval = function (context)
        return (#context.full_hand == 4) 
    end,
    available = function ()
        return true
    end
},

['playFiveCard'] = {
    key = 'playFiveCard',
    textbit = 'lay exactly 5 cards',
    eval = function (context)
        return (#context.full_hand == 5) 
    end,
    available = function ()
        return true
    end
},

['playUnscored'] = {
    key = 'playUnscored',
    textbit = 'lay a hand containing an unscored card',
    eval = function (context)
        return not (#context.full_hand == #context.scoring_hand) 
    end,
    available = function ()
        return true
    end
},

['playAllScored'] = {
    key = 'playAllScored',
    textbit = 'lay a hand containing no unscored cards',
    eval = function (context)
        return (#context.full_hand == #context.scoring_hand) 
    end,
    available = function ()
        return true
    end
},

['playNoClubs'] = {
    key = 'playNoClubs',
    textbit = 'lay a hand containing no scoring Clubs',
    eval = function (context)
        local flag = true
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Clubs') then flag = false end
        end
        return flag
    end,
    available = function ()
        return true
    end
},

['playAnyClubs'] = {
    key = 'playAnyClubs',
    textbit = 'lay a hand containing at least 1 scoring Clubs',
    eval = function (context)
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Clubs') then flag = true end
        end
        return flag
    end,
    available = function ()
        return true
    end
},

['playOneClubs'] = {
    key = 'playOneClubs',
    textbit = 'lay a hand with exactly 1 scoring Clubs',
    eval = function (context)
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Clubs') then count = count + 1 end
        end
        return (count == 1)  
    end,
    available = function ()
        return true
    end
},

['playNoHearts'] = {
    key = 'playNoHearts',
    textbit = 'lay a hand containing no scoring Hearts',
    eval = function (context)
        local flag = true
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Hearts') then flag = false end
        end
        return flag
    end,
    available = function ()
        return true
    end
},

['playAnyHearts'] = {
    key = 'playAnyHearts',
    textbit = 'lay a hand containing at least 1 scoring Hearts',
    eval = function (context)
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Hearts') then flag = true end
        end
        return flag
    end,
    available = function ()
        return true
    end
},

['playOneHearts'] = {
    key = 'playOneHearts',
    textbit = 'lay a hand with exactly 1 scoring Hearts',
    eval = function (context)
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Hearts') then count = count + 1 end
        end
        return (count == 1)  
    end,
    available = function ()
        return true
    end
},

['playNoSpades'] = {
    key = 'playNoSpades',
    textbit = 'lay a hand containing no scoring Spades',
    eval = function (context)
        local flag = true
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Spades') then flag = false end
        end
        return flag
    end,
    available = function ()
        return true
    end
},

['playAnySpades'] = {
    key = 'playAnySpades',
    textbit = 'lay a hand containing at least 1 scoring Spades',
    eval = function (context)
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Spades') then flag = true end
        end
        return flag
    end,
    available = function ()
        return true
    end
},

['playOneSpades'] = {
    key = 'playOneSpades',
    textbit = 'lay a hand with exactly 1 scoring Spades',
    eval = function (context)
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Spades') then count = count + 1 end
        end
        return (count == 1)  
    end,
    available = function ()
        return true
    end
},

['playNoDiamonds'] = {
    key = 'playNoDiamonds',
    textbit = 'lay a hand containing no scoring Diamonds',
    eval = function (context)
        local flag = true
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Diamonds') then flag = false end
        end
        return flag
    end,
    available = function ()
        return true
    end
},

['playAnyDiamonds'] = {
    key = 'playAnyDiamonds',
    textbit = 'lay a hand containing at least 1 scoring Diamonds',
    eval = function (context)
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Diamonds') then flag = true end
        end
        return flag
    end,
    available = function ()
        return true
    end
},

['playOneDiamonds'] = {
    key = 'playOneDiamonds',
    textbit = 'lay a hand with exactly 1 scoring Diamonds',
    eval = function (context)
        local count = 0
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Diamonds') then count = count + 1 end
        end
        return (count == 1)  
    end,
    available = function ()
        return true
    end
},

['playFourSuit'] = {
    key = 'playFourSuit',
    textbit = 'lay a scoring Clubs, Hearts, Spades, and Diamonds',
    eval = function (context)
        local suit = {
            ['Clubs'] = false,
            ['Hearts'] = false,
            ['Spades'] = false,
            ['Diamonds'] = false,
        }
        for _, playing_card in ipairs(context.scoring_hand) do
            if playing_card:is_suit('Clubs') then suit['Clubs'] = true end
            if playing_card:is_suit('Hearts') then suit['Hearts'] = true end
            if playing_card:is_suit('Spades') then suit['Spades'] = true end
            if playing_card:is_suit('Diamonds') then suit['Diamonds'] = true end
        end
        return (suit['Clubs'] and suit['Hearts'] and suit['Spades'] and suit['Diamonds'])
    end,
    available = function ()
        return true
    end
},


-- enhancement gated triggers

['playAnyStone'] = {
    key = 'playAnyStone',
    textbit = 'lay a hand with at least one Stone Card',
    eval = function (context)
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_stone') then flag = true end
        end
        return flag
    end,
    available = function ()
        if not G.playing_cards then return false end
        local tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then tally = tally + 1 end
        end
        return (tally > 4)
    end
},

['playThreeStone'] = {
    key = 'playThreeStone',
    textbit = 'lay a hand with at least 3 Stone Cards',
    eval = function (context)
        local tally
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_stone') then tally = tally + 1 end
        end
        return (tally > 2)
    end,
    available = function ()
        if not G.playing_cards then return false end
        local tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then tally = tally + 1 end
        end
        return (tally > 7)
    end
},

['playAnyGold'] = {
    key = 'playAnyGold',
    textbit = 'lay a hand with at least one Gold Card',
    eval = function (context)
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_gold') then flag = true end
        end
        return flag
    end,
    available = function ()
        if not G.playing_cards then return false end
        local tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_gold') then tally = tally + 1 end
        end
        return (tally > 4)
    end
},

['playThreeGold'] = {
    key = 'playThreeGold',
    textbit = 'lay a hand with at least 3 Gold Cards',
    eval = function (context)
        local tally
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_gold') then tally = tally + 1 end
        end
        return (tally > 2)
    end,
    available = function ()
        if not G.playing_cards then return false end
        local tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_gold') then tally = tally + 1 end
        end
        return (tally > 7)
    end
},

['playAnySteel'] = {
    key = 'playAnySteel',
    textbit = 'lay a hand with at least one Steel Card',
    eval = function (context)
        local flag = false
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_steel') then flag = true end
        end
        return flag
    end,
    available = function ()
        if not G.playing_cards then return false end
        local tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_steel') then tally = tally + 1 end
        end
        return (tally > 4)
    end
},

['playThreeSteel'] = {
    key = 'playThreeSteel',
    textbit = 'lay a hand with at least 3 Steel Cards',
    eval = function (context)
        local tally
        for _, playing_card in ipairs(context.scoring_hand) do
           if SMODS.has_enhancement(playing_card, 'm_steel') then tally = tally + 1 end
        end
        return (tally > 2)
    end,
    available = function ()
        if not G.playing_cards then return false end
        local tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_steel') then tally = tally + 1 end
        end
        return (tally > 7)
    end
},

}