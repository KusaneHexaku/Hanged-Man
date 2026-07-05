SMODS.Joker {
	-- How the code refers to the joker.
	key = 'glassHouse',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Glass House',
		text = {
			"Retrigger played {C:attention}Glass{} cards",
			"once for each played {C:attention}Stone{} card,",
			"{C:mult}Destroy{} all {C:attention}Glass{} cards",
			"retriggered this way"
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { destroyFlag = false } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 6 },
	-- Cost of card in shop.
	cost = 8,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'retrigger', 'destroy_card', 'enhancements'},
	calculate = function(self, card, context)

		if context.before then card.ability.extra.destroyFlag = false end

		if context.individual and context.cardarea == G.play and not context.other_card.debuff and SMODS.has_enhancement(context.other_card, 'm_glass') then
			local rep = 0
			for _i, c in ipairs(context.full_hand) do
				if SMODS.has_enhancement(c, 'm_stone') then 
					rep = rep + 1 
					card.ability.extra.destroyFlag = true
				end
			end
			if rep > 0 then return {message = 'Again!', repetitions = rep} end
        end	

		if context.after and card.ability.extra.destroyFlag and not context.blueprint then
			for _i, c in ipairs(context.full_hand) do
				if SMODS.has_enhancement(c, 'm_glass') then 
					G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						c:shatter() 
						return { remove = true }
					end
					}))
				end
			end
			card.ability.extra.destroyFlag = false
		end

	end
}