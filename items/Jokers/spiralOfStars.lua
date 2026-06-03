SMODS.Joker {
	-- How the code refers to the joker.
	key = 'spiralOfStars',
    unlocked = false,
	blueprint_compat = false,
	-- loc_text is the actual name and description that show in-game for the card.

	--[[

	loc_txt = {
		name = 'Spiral of Stars',
		text = {

			"Each {C:planet}Planet{} card used adds a word to this description.",
			"#1#",
			"#2#",
			"#3#",
			"#4#",
			"#5#"
			-- Plus twenty-five Chips and six Mult for each Queens held in hand,				Breaks at 13
			-- then spawn a random Tarot if hand contains four scoring cards below seven,		Breaks at 26
			-- then double Mult for each held Planet card corresponding to played hand,			Breaks at 38
			-- then gain one dollar if this description does not have an even number			Breaks at 51
			-- of words on it, otherwise this card no longer gets a new word					Breaks at 64
		},
		unlock = {
			"Use {C:attention}8{} {C:mult}unique{}",
			" {C:planet}Planet{} cards",
			"in a single run",
			"OR",
			"Use any {C:attention}16{}",
			"{C:planet}Planet{} cards",
			"in a single run"
		}
	},

	]]


	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = {
					currentText = {'','','','',''},
					fullText = {
						'Plus ','twenty','-five ','Chips ',								-- 4	 +25 Chips
						'and ','six ','Mult ',											-- 7	 +25 Chips and +6 Mult
						'for ', 'each ', 'Queen ',										-- 10	Each Queen played gives +25 Chips and +6 Mult
						'held ',														-- 11	Each Queen held in hand gives +25 Chips and +6 Mult
						'in ', 'hand,', 'then ', 'spawn ', 'a ', 'random ', 'Tarot ',	-- 18	Each Queen held in hand gives +25 Chips and +6 Mult, then spawn a random Tarot card
						'if ', 'hand ', 'contains ', 'four ',							-- 22	Each Queen held in hand gives +25 Chips and +6 Mult. If hand contains a scoring 4, spawn a random Tarot card
						'scoring ', 'cards ',											-- 24	Each Queen held in hand gives +25 Chips and +6 Mult. If hand contains four scoring cards, spawn a random Tarot card
						'below ', 'seven, ',											-- 26	Each Queen held in hand gives +25 Chips and +6 Mult. If hand contains four scoring cards with rank 2 to 6, spawn a random Tarot card
						'then ', 'doubles ', 											-- 28	Trigger all prior effects twice
						'Mult ',														-- 29	Each Queen held in hand gives +25 Chips and +6 Mult. Then X2 Mult. If hand contains four scoring cards with rank 2 to 6, spawn a random Tarot card
						'for ', 'each ', 'held ', 'Planet ',							-- 33	Each Queen held in hand gives +25 Chips and +6 Mult. Then each Planet card held gives X2 Mult. If hand contains four scoring cards with rank 2 to 6, spawn a random Tarot card
						'card ', 'corresponding ', 'to ', 'played ', 'hand,',			-- 38	Each Queen held in hand gives +25 Chips and +6 Mult. Then each Planet card held that matches the played hand type gives X2 Mult. If hand contains four scoring cards with rank 2 to 6, spawn a random Tarot card
						'then ', 'gain ', 'one ', 'dollar ',							-- 42
						'if ', 'this ', 'description ', 'does ', 'not ', 'have ', 'an', -- 49
						'even ', 'number ', 'of ', 'words ',											-- 53
						'on ', 'it', ', otherwise ', 'this ', 'card ', 'no ', 'longer ', 'gets ', 'a ', 'new ', 'word'	-- 64
						},
						wordAdded = 0
				
				
				
			} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.currentText[1], card.ability.extra.currentText[2], card.ability.extra.currentText[3], card.ability.extra.currentText[4], card.ability.extra.currentText[5] } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 4 },
	-- Cost of card in shop.
	cost = 4,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Planet' and card.ability.extra.wordAdded < 64 then

			card.ability.extra.wordAdded = card.ability.extra.wordAdded + 1
			if card.ability.extra.wordAdded < 14 then card.ability.extra.currentText[1] = card.ability.extra.currentText[1] .. card.ability.extra.fullText[card.ability.extra.wordAdded]
			elseif card.ability.extra.wordAdded < 27 then card.ability.extra.currentText[2] = card.ability.extra.currentText[2] .. card.ability.extra.fullText[card.ability.extra.wordAdded]
			elseif card.ability.extra.wordAdded < 39 then card.ability.extra.currentText[3] = card.ability.extra.currentText[3] .. card.ability.extra.fullText[card.ability.extra.wordAdded]
			elseif card.ability.extra.wordAdded < 52 then card.ability.extra.currentText[4] = card.ability.extra.currentText[4] .. card.ability.extra.fullText[card.ability.extra.wordAdded]
			elseif card.ability.extra.wordAdded < 65 then card.ability.extra.currentText[5] = card.ability.extra.currentText[5] .. card.ability.extra.fullText[card.ability.extra.wordAdded] end
		
		end


		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 12 and card.ability.extra.wordAdded > 10 then

			local chip = 25
			local mult = 6
			if card.ability.extra.wordAdded == 28 then
				chip = 50
				mult = 12
			end

            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
					chips = chip,
                    mult = mult
                }
            end
        end

		if context.individual and not context.blueprint and context.cardarea == G.play and context.other_card:get_id() == 12 and card.ability.extra.wordAdded == 10 then
			if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
					chips = 25,
                    mult = 6
                }
            end
		end

		if context.other_consumeable and context.other_consumeable.ability.set == 'Planet' and 32 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 36 then
            return {
                x_mult = 2,
                message_card = context.other_consumeable
            }
        end

		if context.other_consumeable and context.other_consumeable.ability.set == 'Planet' and context.other_consumeable.ability.consumeable.hand_type == context.scoring_name and 37 < card.ability.extra.wordAdded then
            return {
                x_mult = 2,
                message_card = context.other_consumeable
            }
        end
		

		if context.joker_main then

			local chip = 0
			local mult = 0
			local xmult = 1


			if card.ability.extra.wordAdded < 4 then 
				-- do nothing lmao
			elseif card.ability.extra.wordAdded < 7 then

				chip = 25

			elseif card.ability.extra.wordAdded < 10 then

				chip = 25
				mult = 6

			elseif 17 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 22 then

				-- Spawn Random Tarot
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end

			elseif 21 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 24 then

				local fourcheck = false
            	for i = 1, #context.scoring_hand do
                	if context.scoring_hand[i]:get_id() == 4 then
                    	fourcheck = true
                    	break
                	end
            	end

				-- Spawn Random Tarot if fourcheck passes
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and fourcheck then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end

			elseif 23 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 26 then

				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and #context.scoring_hand > 3 then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end

			elseif 25 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 28 then

				local sixorlesscheck = 0
            	for i = 1, #context.scoring_hand do
                	if context.scoring_hand[i]:get_id() < 7 then
                    	sixorlesscheck = sixorlesscheck + 1
                    	break
                	end
            	end

				-- Spawn Random Tarot if fourcheck passes
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and sixorlesscheck > 3 then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end

			elseif card.ability.extra.wordAdded == 28 then

				local sixorlesscheck = 0
            	for i = 1, #context.scoring_hand do
                	if context.scoring_hand[i]:get_id() < 7 then
                    	sixorlesscheck = sixorlesscheck + 1
                    	break
                	end
            	end

				-- Spawn Random Tarot if fourcheck passes
				for i = 1, 2, 1 do
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and sixorlesscheck > 3 then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                	}))
					end
				end
				

			elseif 28 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 33 then

				local sixorlesscheck = 0
            	for i = 1, #context.scoring_hand do
                	if context.scoring_hand[i]:get_id() < 7 then
                    	sixorlesscheck = sixorlesscheck + 1
                    	break
                	end
            	end

				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and sixorlesscheck > 3 then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end

				xmult = 2

			elseif 32 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 42 then

				local sixorlesscheck = 0
            	for i = 1, #context.scoring_hand do
                	if context.scoring_hand[i]:get_id() < 7 then
                    	sixorlesscheck = sixorlesscheck + 1
                    	break
                	end
            	end

				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and sixorlesscheck > 3 then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end

			elseif 41 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 49 then

				local sixorlesscheck = 0
            	for i = 1, #context.scoring_hand do
                	if context.scoring_hand[i]:get_id() < 7 then
                    	sixorlesscheck = sixorlesscheck + 1
                    	break
                	end
            	end

				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and sixorlesscheck > 3 then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end
				ease_dollars(1, true)

			elseif 48 < card.ability.extra.wordAdded and card.ability.extra.wordAdded < 53 then

				local sixorlesscheck = 0
            	for i = 1, #context.scoring_hand do
                	if context.scoring_hand[i]:get_id() < 7 then
                    	sixorlesscheck = sixorlesscheck + 1
                    	break
                	end
            	end

				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and sixorlesscheck > 3 then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end

			else

				local sixorlesscheck = 0
            	for i = 1, #context.scoring_hand do
                	if context.scoring_hand[i]:get_id() < 7 then
                    	sixorlesscheck = sixorlesscheck + 1
                    	break
                	end
            	end

				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and sixorlesscheck > 3 then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
				end

				if card.ability.extra.wordAdded % 2 == 1 then
					ease_dollars(1, true)
				end

			end



			return {
				chips = chip,
				extra = {
					mult = mult,
					extra = {
						Xmult = xmult,
					}
				}
			}
		end

	end,

	locked_loc_vars = function(self, info_queue, card)
		return {
			vars = {

			}
		}
	end,


	-- unlock function
	-- Spiral of Stars : Use 8 unique Planet Cards in a single run, OR use any 16 Planet Cards in a single run.
	check_for_unlock = function(self, args)
		local unlockflag = false
        if args.type == 'unlock_spiralOfStars' then
			local planets_used = 0
        	for k, v in pairs(G.GAME.consumeable_usage) do
            	if v.set == 'Planet' then planets_used = planets_used + 1 end
        	end
			if planets_used >= 8 then 
				unlockflag = true
				print("[HangedMan_Unlock] 8 unique Planet cards have been used - Spiral of Stars unlocked!")
			end
			if (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0) >= 16 then
				unlockflag = true
				print("[HangedMan_Unlock] 16 Planet cards have been used - Spiral of Stars unlocked!")
			end
        end
		if unlockflag then unlock_card(self) end
    end

}