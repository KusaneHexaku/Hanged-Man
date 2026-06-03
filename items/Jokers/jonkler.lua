SMODS.Joker {
	-- How the code refers to the joker.
	key = 'jonkler',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { valueTable = {40,9,2,1,3,15}, plusChips = 40, plusMult = 9, timesMult = 2, chanceRate = 1, chanceMax = 3, reserve = 15} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.plusChips, card.ability.extra.plusMult, card.ability.extra.timesMult, card.ability.extra.chanceRate, card.ability.extra.chanceMax, card.ability.extra.reserve} }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

        if context.setting_blind then
            card.ability.extra.plusChips = card.ability.extra.valueTable[1]
            card.ability.extra.plusMult = card.ability.extra.valueTable[2]
            card.ability.extra.timesMult = card.ability.extra.valueTable[3]
            card.ability.extra.chanceRate = card.ability.extra.valueTable[4] * (G.GAME.probabilities.normal or 1)
            card.ability.extra.chanceMax = card.ability.extra.valueTable[5]
            card.ability.extra.reserve = card.ability.extra.valueTable[6]
        end

		-- Tests if context.joker_main == true.
		-- joker_main is a SMODS specific thing, and is where the effects of jokers that just give +stuff in the joker area area triggered, like Joker giving +Mult, Cavendish giving XMult, and Bull giving +Chips.
		if context.joker_main then
			-- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
			return {
                chips = card.ability.extra.plusChips,
                mult = card.ability.extra.plusMult,
				Xmult = card.ability.extra.timesMult,			
			}
		end

		if context.after and not context.blueprint then

            card.ability.extra.plusChips = card.ability.extra.valueTable[1]
            card.ability.extra.plusMult = card.ability.extra.valueTable[2]
            card.ability.extra.timesMult = card.ability.extra.valueTable[3]
            card.ability.extra.chanceRate = card.ability.extra.valueTable[4] * (G.GAME.probabilities.normal or 1)
            card.ability.extra.chanceMax = card.ability.extra.valueTable[5]
            card.ability.extra.reserve = card.ability.extra.valueTable[6]

			if pseudorandom('jonklerShuffle') < card.ability.extra.chanceRate / card.ability.extra.chanceMax then
                
                local tempIndices = {1,2,3,4,5,6}

                pseudoshuffle(tempIndices, 'jonklerShuffle')

                card.ability.extra.valueTable[tempIndices[1]],card.ability.extra.valueTable[tempIndices[2]] = card.ability.extra.valueTable[tempIndices[2]],card.ability.extra.valueTable[tempIndices[1]]

                card.ability.extra.plusChips = card.ability.extra.valueTable[1]
                card.ability.extra.plusMult = card.ability.extra.valueTable[2]
                card.ability.extra.timesMult = card.ability.extra.valueTable[3]
                card.ability.extra.chanceRate = card.ability.extra.valueTable[4] * (G.GAME.probabilities.normal or 1)
                card.ability.extra.chanceMax = card.ability.extra.valueTable[5]
                card.ability.extra.reserve = card.ability.extra.valueTable[6]

				return {
					message = 'Swapped!',
				    card = card
				}
			end
		end

	end
}

