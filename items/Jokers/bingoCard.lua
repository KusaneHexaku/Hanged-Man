SMODS.Joker {
	-- How the code refers to the joker.
	key = 'bingoCard',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
    allow_duplicates = false,
	-- loc_text is the actual name and description that show in-game for the card.

    --[[
	loc_txt = {
		name = 'Bingo Card',
		text = {

			"{C:white,X:mult}X#1#{} Mult,",
            "Gain {C:white,X:mult}X1{} Mult for",
            "each completed line",
            "{C:inactive}#6#{}",
            "{C:inactive}#7#{}",

		}
	},
    ]]

	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { XMult = 1, completedLines = 0, generated = false,
    bingoBoard = {' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? ',' ? '},
    cellColours ={
        ['C '] = G.C.SUITS.Clubs,
        ['H '] = G.C.SUITS.Hearts,
        ['S '] = G.C.SUITS.Spades,
        ['D '] = G.C.SUITS.Diamonds,
        ['0C'] = G.C.SUITS.Clubs,
        ['0H'] = G.C.SUITS.Hearts,
        ['0S'] = G.C.SUITS.Spades,
        ['0D'] = G.C.SUITS.Diamonds,
        ['X '] = G.C.GREEN,
        ['? '] = G.C.UI.TEXT_DARK,
    },
    line4text = 'Bingo board will be generated',
    line5text = 'when Joker is added to deck'

    } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        local mainend = {}

        if card.ability and card.ability.extra.generated then
            mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = {
                    
                    {n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.1}, nodes = {
                        
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[1], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[1], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[2], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[2], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[3], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[3], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[4], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[4], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[5], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[5], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}}
                        
                    }},
                    
                    {n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.1}, nodes = {
                        
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[6], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[6], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[7], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[7], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[8], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[8], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[9], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[9], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[10], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[10], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}}
                        
                    }},

                    {n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.1}, nodes = {
                       
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[11], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[11], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[12], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[12], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[13], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[13], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[14], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[14], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[15], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[15], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}}
                        
                    }},

                    {n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.1}, nodes = {
                        
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[16], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[16], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[17], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[17], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[18], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[18], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[19], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[19], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[20], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[20], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}}
                        
                    }},

                    {n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.1}, nodes = {
                       
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[21], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[21], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[22], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[22], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[23], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[23], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[24], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[24], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}},
                            {n = G.UIT.T, config = {align = "cm", text = card.ability.extra.bingoBoard[25], colour = card.ability.extra.cellColours[string.sub(card.ability.extra.bingoBoard[25], -2)], scale = 0.4, max_h = 1, max_w = 8, padding = 0.2}}
                        
                    }}

                }}
            }
        end

		return {
            vars = { card.ability.extra.XMult, card.ability.extra.completedLines, card.ability.extra.generated, card.ability.extra.bingoBoard, card.ability.extra.cellColours, card.ability.extra.line4text, card.ability.extra.line5text},
            main_end = mainend
        }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This carD 's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 1 },
	-- Cost of card in shop.
	cost = 8,
    attributes = {'xmult', 'rank', 'suit', 'scaling', 'dropout', 'game_changer'},

    add_to_deck = function(self, card, from_debuff)

        if not card.ability.extra.generated and not from_debuff then

            local cardPool = {'2C ','2H ','2S ','2D ','3C ','3H ','3S ','3D ','4C ','4H ','4S ','4D ','5C ','5H ','5S ','5D ','6C ','6H ','6S ','6D ','7C ','7H ','7S ','7D ','8C ','8H ','8S ','8D ','9C ','9H ','9S ','9D ','10C','10H','10S','10D','JC ','JH ','JS ','JD ','QC ','QH ','QS ','QD ','KC ','KH ','KS ','KD ','AC ','AH ','AS ','AD '}
            pseudoshuffle(cardPool, "bingoCarD")
            for i, v in ipairs(card.ability.extra.bingoBoard) do
                card.ability.extra.bingoBoard[i] = cardPool[i]
            end

            card.ability.extra.generated = true
            card.ability.extra.line4text = '(Currently ' .. tostring(card.ability.extra.completedLines) .. ' lines)'
            card.ability.extra.line5text = ''

        end
    end,
  
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

        if context.individual and not context.blueprint and context.cardarea == G.play then

            local cardToFind = ''

            if not context.other_card.debuff then
                if context.other_card:get_id() == 14 then
                    cardToFind = 'A'
                elseif context.other_card:get_id() == 13 then
                    cardToFind = 'K'
                elseif context.other_card:get_id() == 12 then
                    cardToFind = 'Q'
                elseif context.other_card:get_id() == 11 then
                    cardToFind = 'J'
                else
                    cardToFind = tostring(context.other_card:get_id())
                end

                if SMODS.has_any_suit(context.other_card) then
                    for i, v in pairs(card.ability.extra.bingoBoard) do
                        if string.sub(v, 1, 1) == cardToFind then
                            card.ability.extra.bingoBoard[i] = 'XX '
                            return {
                                message = 'Daubed!',
                            }
                        end
                    end

                else
                    cardToFind = cardToFind .. string.sub(context.other_card.base.suit, 1, 1)
                    for i, v in pairs(card.ability.extra.bingoBoard) do
                        if v == cardToFind or string.sub(v, 1, 2) == cardToFind then
                            card.ability.extra.bingoBoard[i] = 'XX '
                            return {
                                message = 'Daubed!',
                            }
                        end
                    end
                end
            end
        end

		if context.joker_main then
        
            card.ability.extra.completedLines = 0

            local tempCounter = 0
            local linesToCheck = {
                -- rows
                {1,2,3,4,5},
                {6,7,8,9,10},
                {11,12,13,14,15},
                {16,17,18,19,20},
                {21,22,23,24,25},
                -- columns
                {1,6,11,16,21},
                {2,7,12,17,22},
                {3,8,13,18,23},
                {4,9,14,19,24},
                {5,10,15,20,25},
                -- diagonals
                {1,7,13,19,25},
                {5,9,13,17,21}
            }

            for iBig, line in ipairs(linesToCheck) do
                tempCounter = 0
                for iSmall, cell in ipairs(linesToCheck[iBig]) do
                    if card.ability.extra.bingoBoard[cell] == 'XX ' then
                        tempCounter = tempCounter + 1
                    end
                end
                --print('Line ' .. tostring(iBig) .. ' : Found ' .. tostring(tempCounter) .. ' daubed cells ')
                if tempCounter == 5 then
                    card.ability.extra.completedLines = card.ability.extra.completedLines + 1
                    --print('That is a line! There are now ' .. tostring(card.ability.extra.completedLines) .. ' completed lines ')
                end
            end
            card.ability.extra.line4text = '(Currently ' .. tostring(card.ability.extra.completedLines) .. ' lines)'
            card.ability.extra.XMult = 1
            if card.ability.extra.completedLines > 0 then
                -- old loop for when Bingo Card used to double its xmult instead of gaining 1 xmult
                --[[for i = 1, card.ability.extra.completedLines, 1 do
                    card.ability.extra.XMult = card.ability.extra.XMult * 2
                end]]
                card.ability.extra.XMult = card.ability.extra.XMult + card.ability.extra.completedLines
                return {
                    Xmult = card.ability.extra.XMult
                }
            end
			
		end
	end

}

