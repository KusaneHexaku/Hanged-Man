SMODS.Joker {
	-- How the code refers to the joker.
	key = 'magnaHeart',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Magna Heart',
		text = {
			"Each {C:hearts}Heart{} cards held in hand",
			"has a {C:green}#1# in #2# chance to",
			"give {C:white,X:mult}X#3#{} Mult",
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { xmult = 1.2, odds = 2 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'hangedman_magnaHeart')
		return { vars = { numerator, denominator, card.ability.extra.xmult } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Magna',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit('Hearts') and SMODS.pseudorandom_probability(card, 'hangedman_magnaHeart', 1, card.ability.extra.odds) then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end

	end,

}