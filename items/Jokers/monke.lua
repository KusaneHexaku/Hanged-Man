SMODS.Joker {
	-- How the code refers to the joker.
	key = 'monke',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
    allow_duplicates = true,
	-- loc_text is the actual name and description that show in-game for the card.
	
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { baseMult = 5, monkeyFound = 0, cumulativeMult = 5, timesMult = 3} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS["j_gros_michel"]
		info_queue[#info_queue + 1] = G.P_CENTERS["j_cavendish"]
		return { vars = { card.ability.extra.cumulativeMult, card.ability.extra.timesMult, card.ability.extra.baseMult } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 1,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 0 },
	-- Cost of card in shop.
	cost = 3,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

        if context.setting_blind and context.cardarea == G.jokers then

            card.ability.extra.cumulativeMult = 0

            for i, v in ipairs(G.jokers.cards) do
                --print(v.config.center.key)
                if v.config.center.key == 'j_hangedman_monke' then
                    card.ability.extra.cumulativeMult = card.ability.extra.cumulativeMult + card.ability.extra.baseMult
                end   
                --print(card.ability.extra.cumulativeMult)
            end
        end

        if context.before and not context.blueprint and context.cardarea == G.jokers then

            card.ability.extra.cumulativeMult = 0

            for i, v in ipairs(G.jokers.cards) do
                --print(v.config.center.key)
                if v.config.center.key == 'j_hangedman_monke' then
                    card.ability.extra.cumulativeMult = card.ability.extra.cumulativeMult + card.ability.extra.baseMult
                end     
                --print(card.ability.extra.cumulativeMult)
            end
        end


		if context.joker_main then
			return {
				mult = card.ability.extra.cumulativeMult
			}
		end

		if context.other_joker then
			if context.other_joker.ability.name == 'Gros Michel' or context.other_joker.ability.name == 'Cavendish' then
                return {
                    Xmult = card.ability.extra.timesMult,
                    card = context.other_joker
                }
            end
		end

	end
}

