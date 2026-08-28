SMODS.Joker {
	-- How the code refers to the joker.
	key = 'doNotRedeem',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'DO NOT REDEEM',
		text = {
			"Gain {C:mult}+#2#{} Mult when a {C:attention}Blind{} is defeated",
			"{C:mult}-#3#{} Mult when a {C:attention}Voucher{} is bought",
			"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}"
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { mult = 0, increment = 5, penalty = 25 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.mult), card.ability.extra.increment, card.ability.extra.penalty } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 1,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 4 },
	-- Cost of card in shop.
	cost = 4,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'mult', 'scaling'},
	calculate = function(self, card, context)

		if context.buying_card and context.card.ability.set == 'Voucher' and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.penalty
			return {
				message = 'DO NOT REDEEM!!',
				colour = G.C.RED,
				card = card
			}
		end

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.increment
			return {
				message = 'Upgrade!',
				colour = G.C.RED,
				card = card
			}
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end

	end
}