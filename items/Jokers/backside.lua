SMODS.Joker {
	-- How the code refers to the joker.
	key = 'backside',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Backside',
		text = {
			"{C:attention}Face down{} cards in hand",
			"each give {C:mult}+#3#{} Mult",
			"{C:green}#1# in #2#{} chance for each",
            "card to be drawn face down",
		}
	},
	config = { extra = { odds = 7, mult = 13 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'hangedman_backside')
        return { vars = { numerator, denominator, card.ability.extra.mult } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 1,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 6 },
	-- Cost of card in shop.
	cost = 4,


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.stay_flipped and context.to_area == G.hand and SMODS.pseudorandom_probability(card, 'hangedman_backside', 1, card.ability.extra.odds) then 
			return {stay_flipped = true}
        end

		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card.facing == 'back' then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
	end
}