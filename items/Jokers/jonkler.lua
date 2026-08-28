SMODS.Joker {
	-- How the code refers to the joker.
	key = 'jonkler',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { valueTable = {40,9,2,1,3,15} } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.valueTable[4], card.ability.extra.valueTable[5], 'hangedman_jonkler')
		return { vars = { card.ability.extra.valueTable[1], card.ability.extra.valueTable[2], card.ability.extra.valueTable[3], numerator, denominator, card.ability.extra.valueTable[6]} }
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
	attributes = {'chips', 'mult', 'xmult', 'chance'},
	calculate = function(self, card, context)

        -- Tests if context.joker_main == true.
		-- joker_main is a SMODS specific thing, and is where the effects of jokers that just give +stuff in the joker area area triggered, like Joker giving +Mult, Cavendish giving XMult, and Bull giving +Chips.
		if context.joker_main then
			-- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".
			return {
                chips = card.ability.extra.valueTable[1],
                mult = card.ability.extra.valueTable[2],
				Xmult = card.ability.extra.valueTable[3]
			}
		end

		if context.after and not context.blueprint then

			if SMODS.pseudorandom_probability(card, 'hangedman_jonkler', card.ability.extra.valueTable[4], card.ability.extra.valueTable[5]) then
                
                local tempIndices = {1,2,3,4,5,6}

                HangedMan.better_pseudoshuffle(tempIndices, 'hangedman_jonkler')

				local temptemp = card.ability.extra.valueTable[tempIndices[1]]

                card.ability.extra.valueTable[tempIndices[1]] = card.ability.extra.valueTable[tempIndices[2]]
				card.ability.extra.valueTable[tempIndices[2]] = temptemp

				return {
					message = 'Swapped!',
				    card = card
				}
			end
		end

	end
}

