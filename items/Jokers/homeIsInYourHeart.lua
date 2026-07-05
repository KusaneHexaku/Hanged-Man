SMODS.Joker {
	-- How the code refers to the joker.
	key = 'homeIsInYourHeart',
    unlocked = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	config = { extra = { multiplier = 6, mult = 0 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		--info_queue[#info_queue+1] = { set = 'Tarot', key = 'c_hangedman_homeIsInYourHeart_infoqueue', vars = {} }  
		local heartsInHand = 0
		if G.hand and G.hand.cards then
			for i, v in ipairs(G.hand.cards) do
				if v:is_suit('Hearts') then heartsInHand = heartsInHand + 1 end
			end
		end
        return { vars = { card.ability.extra.multiplier, number_format(card.ability.extra.multiplier*heartsInHand) } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 5 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'suit', 'mult', 'hand_type', 'hearts', 'suit', 'lirie', 'vtuber'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.before and not context.blueprint then 
			local heartsInHand = 0
			if G.hand and G.hand.cards then
				for i, v in ipairs(G.hand.cards) do
					if v:is_suit('Hearts') then heartsInHand = heartsInHand + 1 end
				end
			end
			card.ability.extra.mult = card.ability.extra.multiplier*heartsInHand
        end

		if context.individual and context.cardarea == G.play and context.other_card:is_suit('Hearts') and next(context.poker_hands['Full House']) then
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
	end,


	-- unlock function
	-- Home Is In Your Hear : Play a Flush House with Heart suit
	check_for_unlock = function(self, args)
        if args.type == 'unlock_homeIsInYourHeart' and args.handname == 'Flush House' then
            local tally = 0
            for i = 1, #args.cards do
                if args.cards[i]:is_suit('Hearts') then
                    tally = tally + 1
                end
                if tally >= 5 then
                    return true
                end
            end
        end
        return false
    end
}