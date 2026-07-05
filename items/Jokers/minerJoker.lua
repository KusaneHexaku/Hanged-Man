SMODS.Joker {
	-- How the code refers to the joker.
	key = 'minerJoker',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Miner Joker',
		text = {
			"{C:green}#1# in #2#{} chance to upgrade level",
            "of all but played {C:attention}poker hand{}"
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { odds = 8 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'hangedman_miner')
        return { vars = { numerator, denominator } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 5 },
	-- Cost of card in shop.
	cost = 6,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'chance', 'hand_type'},
	calculate = function(self, card, context)

		if context.before and SMODS.pseudorandom_probability(card, 'hangedman_miner', 1, card.ability.extra.odds) then

			local handNames = {
        		'High Card',
        		'Pair',
        		'Two Pair',
        		'Three of a Kind',
        		'Straight',
        		'Flush',
        		'Full House',
        		'Four of a Kind',
        		'Straight Flush',
        		'Five of a Kind',
        		'Flush House',
        		'Flush Five'
    		}

			table.remove(handNames,indexOf(handNames, context.scoring_name))

			update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            { handname = 'All but ' .. context.scoring_name, chips = '...', mult = '...', level = '' })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true
            end
        }))
        update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true
            end
        }))
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
        delay(1.3)

        SMODS.upgrade_poker_hands({ hands = handNames, instant = true })


        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })


        end    

		function indexOf(array, value)
    		for i, v in ipairs(array) do
        		if v == value then
            		return i
        		end
    		end
    	return nil
		end

	end
}