SMODS.Joker {
	-- How the code refers to the joker.
	key = 'devilInTheDetails',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Devil in the Details',
		text = {
			"Played cards give {C:mult}+#1#{} Mult when scored",
			"if hand is played with {C:attention}#2#{} cards selected",
		}
	},
	config = { extra = { size = 6, mult = 6, flag = false } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.size } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 1,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 2 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'mult', 'rank', 'suit', 'tarot_joker'},


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.before and not context.blueprint then
			local handsize = #context.full_hand
			local jokerselected = (G.jokers and #G.jokers.highlighted) or 0
			local consumableselected = (G.consumeables and #G.consumeables.highlighted) or 0
			card.ability.extra.flag = (handsize + jokerselected + consumableselected == card.ability.extra.size)
		end

		if context.individual and context.cardarea == G.play and card.ability.extra.flag then return {mult = card.ability.extra.mult} end


	end
}