SMODS.Joker {
	-- How the code refers to the joker.
	key = 'magnaSpade',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Magna Spade',
		text = {
			"Each {C:spades}Spade{} cards held in hand",
			"at end of round gives {C:money}$1{}",
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { gold = 1, stack = {} } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.gold } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Magna',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'economy', 'suit', 'spades', 'magna'},
	calculate = function(self, card, context)

		if context.setting_blind then
			card.ability.extra.stack = {}
		end

		if context.before and not context.blueprint then
			card.ability.extra.stack = {}
			for i, v in ipairs(G.hand.cards) do
				if v:is_suit('Spades') then
					card.ability.extra.stack[#card.ability.extra.stack + 1] = v
				end
			end
		end

		if context.end_of_round and context.individual and context.cardarea == G.hand and context.other_card:is_suit('Spades') then
			local v = context.other_card
			if v.debuff then
				return {
					message = localize('k_debuffed'),
					colour = G.C.RED
				}
			else
				ease_dollars(card.ability.extra.gold)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						v:juice_up(0.3, 0.3)
						play_sound('tarot1', 0.3, 0.4)
					return true
					end
				}))
			end
		end

		--[[
		if context.game_over == false and context.end_of_round then
			for i, v in ipairs(card.ability.extra.stack) do
			local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
				 if v.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED
					}
				else
					ease_dollars(card.ability.extra.gold)
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							v:juice_up(0.3, 0.3)
							play_sound('tarot1', percent, 0.4)
						return true
						end
					}))
				end
				delay(0.075)
			end
			card.ability.extra.stack = {}
        end
		]]

	end,

}