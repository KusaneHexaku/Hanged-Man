SMODS.Joker {
	-- How the code refers to the joker.
	key = 'laughingJoker',
    unlocked = false,
	blueprint_compat = true,

	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { mult = 5, count = 0 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 6 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		 if context.before and not context.blueprint then
			card.ability.extra.count = 0
            for i,v in ipairs(context.scoring_hand) do if not v.debuff and v:get_id() == 5 then card.ability.extra.count = card.ability.extra.count + 1 end end	      
        end

        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 5 then
            return {
                mult = card.ability.extra.mult * card.ability.extra.count
            }
        end

	end,

	-- unlock function
	-- Laughing Joker : Discard five 5s at the same time.
	check_for_unlock = function(self, args)
        if args.type == 'discard_custom' then
            local tally = 0
            for i = 1, #args.cards do
                if args.cards[i]:get_id() == 5 then
                    tally = tally + 1
                end
                if tally >= 5 then
                    return true
                end
            end
        end
        return false
    end,
}

