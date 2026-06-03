SMODS.Joker {
	-- How the code refers to the joker.
	key = 'magnaStar',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Magna Star',
		text = {
			"Draw an additional card for each",
			"{C:attention}7{} in previous {C:attention}played hand",
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { extra_draw = 0 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		
		return { vars = {  } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Magna',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) and card.ability.extra.extra_draw > 0 then
            return {
                cards_to_draw = context.amount + card.ability.extra.extra_draw
            }
        end

		if context.before and not context.blueprint then
			card.ability.extra.extra_draw = 0
		end

		if context.individual and context.cardarea == G.play and not context.end_of_round and context.other_card:get_id() == 7 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
				card.ability.extra.extra_draw = card.ability.extra.extra_draw + 1
                return {message = 'Have a nice day', colour = G.C.RARITY.Legendary}
            end
        end


	end,

}