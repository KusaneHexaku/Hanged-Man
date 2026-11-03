SMODS.Joker {
	-- How the code refers to the joker.
	key = 'magnaNut',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Magna Nut',
		text = {
			"Scoring {C:attention}6{} permanently gain",
			"{C:chips}+#1#{} Chips if played hand contains",
			"at least {C:attention}3{} scoring {C:attention}6{}"
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { bonus = 6 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Magna',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'chips', 'modify_card', 'perma_bonus', 'rank', 'six', 'magna'},
	calculate = function(self, card, context)



		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 6 then
			local six_tally = 0
			for _, c in ipairs(context.scoring_hand) do
				if c:get_id() == 6 then six_tally = six_tally + 1 end
			end

            if context.other_card.debuff and six_tally > 2 then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            elseif six_tally > 2 then

				context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.bonus

				local choiceOfNounOfChoice = HangedMan.magnaNut_nounsOfChoice or {}

				local fallbackChoiceOfNounOfChoice = {
					'the Badger',
					'the 6 of Bullets',
					'the 6 of Orbs',
					'the 6 of Spades',
					'the 6 of Hearts',
					'the 6 of Clubs',
					'the 6 of Diamonds',
					'the 6 of Stars',
					'the 6 of Nuts',
					'the Nouns of Choice file that has failed to load'
				}

				if not HangedMan.magnaNut_nounsOfChoice then choiceOfNounOfChoice = fallbackChoiceOfNounOfChoice end

				if SMODS.pseudorandom_probability(card, 'handedman_magnaNut', 1, 100) then

					--draw_card(G.deck, G.hand, some number, 'up' or 'down', nil, the card, delay)
					G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						draw_card(G.deck, G.hand, nil, "up", true, card)
						return true
					end
					}))

					return {
                    	message = 'All hail plus a noun of your choice',
                    	colour = G.C.RED,
						extra = {
							message = 'Talking',
							chips = -50,
                    		colour = G.C.BLUE,
							extra = {
								message = 'Failure to say \'All hail\' plus a noun of your choice',
                    			colour = G.C.BLUE,
								extra = {
                    				message = 'All hail ' .. choiceOfNounOfChoice[math.random(1, #choiceOfNounOfChoice)],
                    				colour = G.C.RED
                				}
							}
                		}
                	}
                else return {
                    message = 'All hail ' .. choiceOfNounOfChoice[math.random(1, #choiceOfNounOfChoice)],
                    colour = G.C.RED
                }
				end
            end
        end

	end,

}