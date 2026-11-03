SMODS.Joker {
	-- How the code refers to the joker.
	key = 'jimboSays',
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	-- loc_text is the actual name and description that show in-game for the card.
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { mult = 0, increment = 10, penalty = 12, command = 'Follow Jimbo\'s command, but only if he says \"Jimbo Says\"',
				trigger = '',
				valid = false,

				crossmodFlag = {
					['Phanta'] = false
				}
			} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.mult), card.ability.extra.increment, card.ability.extra.penalty, card.ability.extra.command } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 4 },
	-- Cost of card in shop.
	cost = 4,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'mult', 'scaling', 'hand_type', 'enhancements', 'dropout', 'game_changer'},
	calculate = function(self, card, context)

		local function generateCommand()

			local chanceChance = {1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 47}

			local triggerobject = pseudorandom_element(HangedMan.jimboSays_triggers, pseudoseed('jimboSays'))
			local _it = 0
			while not triggerobject.available() do
				_it = _it + 1
				triggerobject = pseudorandom_element(HangedMan.jimboSays_triggers, pseudoseed('jimboSays'.._it))
			end
			
			card.ability.extra.trigger = triggerobject.key
			local textbit = triggerobject.textbit

			if SMODS.pseudorandom_probability(card, 'jimboSays', 1, pseudorandom_element(chanceChance, pseudoseed('jimboSays'))) then
				card.ability.extra.valid = true
				card.ability.extra.command = 'Jimbo Says p'  .. textbit
			else
				card.ability.extra.valid = false
				card.ability.extra.command = pseudorandom_element(HangedMan.jimboSays_invalidCommandHeaders, pseudoseed('jimboSays'))  .. textbit
			end

		end

		local function resolveAction(success)
			if success then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.increment
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
							card:juice_up()
							play_sound('tarot1', 1.2 + math.random() * 0.1, 0.4)
						return true
					end
				}))
			else
				if card.ability.extra.mult < card.ability.extra.penalty then
					card.ability.extra.mult = 0
				else
					card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.penalty
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
							card:juice_up()
							play_sound('tarot1', 0.4 + math.random() * 0.1, 0.4)
						return true
					end
				}))
			end
		end

		if context.setting_blind and not context.blueprint then 

			if next(SMODS.find_mod('GSPhanta')) then card.ability.extra.crossmodFlag['Phanta'] = true else card.ability.extra.crossmodFlag['Phanta'] = false end

			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					generateCommand()
					card:juice_up()
					play_sound('tarot1', 0.8, 0.4)
					return true
				end
			}))
		 end

		if context.after and not context.blueprint then 
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					generateCommand()
					card:juice_up()
					play_sound('tarot1', 0.8, 0.4)
					return true
				end
			}))
		end

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.command = 'Follow Jimbo\'s command, but only if he says \"Jimbo Says\"'
		end

		if context.joker_main then
			resolveAction(card.ability.extra.valid == HangedMan.jimboSays_triggers[card.ability.extra.trigger].eval(context))
			return {mult = card.ability.extra.mult}
		end

	end
}
