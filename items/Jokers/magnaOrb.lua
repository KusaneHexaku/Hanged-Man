SMODS.Joker {
	-- How the code refers to the joker.
	key = 'magnaOrb',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Magna Orb',
		text = {
			"Earn {C:money}$#2#{} for each {C:attention}empty{}",
			"Joker and Consumable slots",
			"at end of round",
			"{C:inactive}(Currently{} {C:money}$#1#{}{C:inactive}){}",
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { gold = 2 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local emptyCount = 0
		if G.consumeables and G.jokers then 
			emptyCount = math.max(0,((G.consumeables.config.card_limit or 0) - ((#G.consumeables.cards or 0) + (G.GAME.consumeable_buffer or 0)))) + math.max(0,((G.jokers.config.card_limit or 0) - ((#G.jokers.cards or 0) + (G.GAME.joker_buffer or 0))))
		end
		return { vars = { emptyCount*card.ability.extra.gold, card.ability.extra.gold } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Magna',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

	end,

	calc_dollar_bonus = function(self, card)
		local emptyCount = math.max(0,(G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer))) + math.max(0,(G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)))
		if emptyCount > 0 then return emptyCount*card.ability.extra.gold end
	end
}