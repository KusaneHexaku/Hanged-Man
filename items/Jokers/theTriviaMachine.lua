SMODS.Joker {
	-- How the code refers to the joker.
	key = 'theTriviaMachine',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,

	config = { extra = { chips = 0, question = -1, used = {}, accepting = false, answered = nil, wilded = false,
		choices = {
			['Spades'] = '?',
			['Hearts'] = '?',
			['Clubs'] = '?',
			['Diamonds'] = '?'
		},
		correct = '?'

} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)

		local mainend = {}
		local value = 0
		local textrows = {}
		local header = 'Welcome to the Trivia Machine!'

		if card.ability.extra.question > 0 then
			value = (HangedMan.triviaMachine_questions[card.ability.extra.question].value or 0)
			header = 'Question ID '.. card.ability.extra.question
			textrows = {
				{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
					{
	                    {n = G.UIT.T, config = {align = "cm", text = 'This question is worth ', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
						{n = G.UIT.T, config = {align = "cm", text = ''..value, colour = G.C.CHIPS, scale = 0.32}},
						{n = G.UIT.T, config = {align = "cm", text = ' Chips', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
            		}
				},
				{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
					{
	                    {n = G.UIT.T, config = {align = "cm", text = ' ', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
            		}
				}
			}

			-- append question
			for questionLine = 1, #HangedMan.triviaMachine_questions[card.ability.extra.question].question, 1 do
				local textpiece = {}
				for _i, textcolourpair in ipairs(HangedMan.triviaMachine_questions[card.ability.extra.question].question[questionLine]) do
					textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.32}}
				end

				textrows[questionLine+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = textpiece}
			end
			

			local col_table = {
				['Spades'] = G.C.SUITS.Spades,
				['Hearts'] = G.C.SUITS.Hearts,
				['Clubs'] = G.C.SUITS.Clubs,
				['Diamonds'] = G.C.SUITS.Diamonds,
			}

			if not card.ability.extra.accepting then
				col_table['Spades'] = G.C.UI.TEXT_INACTIVE
				col_table['Hearts'] = G.C.UI.TEXT_INACTIVE
				col_table['Clubs'] = G.C.UI.TEXT_INACTIVE
				col_table['Diamonds'] = G.C.UI.TEXT_INACTIVE
			end

			if card.ability.extra.answered and (not card.ability.extra.wilded) then 
				if card.ability.extra.answered == card.ability.extra.correct then col_table[card.ability.extra.answered] = G.C.GREEN
				else col_table[card.ability.extra.answered] = G.C.RED end
			end

			textrows[#textrows+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = {
				{n = G.UIT.T, config = {align = "cm", text = ' ', colour = G.C.UI.TEXT_DARK, scale = 0.2}},
			}}
			textrows[#textrows+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = {
				{n = G.UIT.T, config = {align = "cm", text = 'Spades: ', colour = col_table['Spades'], scale = 0.32}},
				{n = G.UIT.T, config = {align = "cm", text = card.ability.extra.choices['Spades'], colour = col_table['Spades'], scale = 0.32}}
			}}
			textrows[#textrows+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = {
				{n = G.UIT.T, config = {align = "cm", text = 'Hearts: ', colour = col_table['Hearts'], scale = 0.32}},
				{n = G.UIT.T, config = {align = "cm", text = card.ability.extra.choices['Hearts'], colour = col_table['Hearts'], scale = 0.32}}
			}}
			textrows[#textrows+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = {
				{n = G.UIT.T, config = {align = "cm", text = 'Clubs: ', colour = col_table['Clubs'], scale = 0.32}},
				{n = G.UIT.T, config = {align = "cm", text = card.ability.extra.choices['Clubs'], colour = col_table['Clubs'], scale = 0.32}}
			}}
			textrows[#textrows+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = {
				{n = G.UIT.T, config = {align = "cm", text = 'Diamonds: ', colour = col_table['Diamonds'], scale = 0.32}},
				{n = G.UIT.T, config = {align = "cm", text = card.ability.extra.choices['Diamonds'], colour = col_table['Diamonds'], scale = 0.32}}
			}}

			

		else

			textrows = {
				{n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = 
					{
	                    {n = G.UIT.T, config = {align = "cm", text = 'Play only ', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
						{n = G.UIT.T, config = {align = "cm", text = '1 ', colour = G.C.FILTER, scale = 0.32}},
						{n = G.UIT.T, config = {align = "cm", text = 'card with first hand', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
            		}
				},
				{n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = 
					{
	                    {n = G.UIT.T, config = {align = "cm", text = 'of Blind to answer the question', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
            		}
				},
			}

		end

		mainend = {
            { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = textrows}
        }
		
        return { vars = { card.ability.extra.chips, value, value*-1, card.ability.extra.question, header}, main_end = mainend }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_TriviaMachine',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	attributes = {'suit', 'chips'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.setting_blind and not context.blueprint then
			if #card.ability.extra.used > math.floor(#HangedMan.triviaMachine_questions*0.75) then
				table.remove(card.ability.extra.used, 1)
			end

			local _q = pseudorandom(pseudoseed('HangedMan_triviaMachine'), 1, #HangedMan.triviaMachine_questions)
			local _it = 0
			while HangedMan.indexOf(card.ability.extra.used, _q) do
    			_it = _it + 1
    			_q = pseudorandom(pseudoseed('HangedMan_triviaMachine_resample'.._it), 1, #HangedMan.triviaMachine_questions)
			end

			card.ability.extra.question = _q
			--print('Question #' .. card.ability.extra.question .. ' out of ' .. #HangedMan.triviaMachine_questions .. ' selected')

			local suitorder = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
			HangedMan.better_pseudoshuffle(suitorder, "HangedMan_triviaMachine")
			card.ability.extra.correct = suitorder[1]
			for i, suit in ipairs(suitorder) do
				card.ability.extra.choices[suit] = HangedMan.triviaMachine_questions[card.ability.extra.question].choices[i]
			end

			card.ability.extra.accepting = true
			card.ability.extra.answered = nil
			card.ability.extra.wilded = false
			card.ability.extra.used[#card.ability.extra.used+1] = card.ability.extra.question

			if HangedMan.triviaMachine_questions[card.ability.extra.question].reduceInfo then
				G.GAME.HangedMan_triviaMachine_reduceInfo = G.GAME.HangedMan_triviaMachine_reduceInfo or {}
				for _i, key in ipairs(HangedMan.triviaMachine_questions[card.ability.extra.question].reduceInfo) do
					G.GAME.HangedMan_triviaMachine_reduceInfo[key] = true
				end
			end
		end


		if context.before and card.ability.extra.accepting and not context.blueprint then

			if #context.full_hand == 1 then

				card.ability.extra.answered = context.full_hand[1].base.suit

				if SMODS.has_any_suit(context.full_hand[1]) then
					card.ability.extra.chips = card.ability.extra.chips + (HangedMan.triviaMachine_questions[card.ability.extra.question].value or 0)
					card.ability.extra.wilded = true
					return {
						message = 'Wilded!',
						colour = G.C.SECONDARY_SET.Tarot,
					}
				elseif context.full_hand[1]:is_suit(card.ability.extra.correct) and (not SMODS.has_any_suit(context.full_hand[1])) then
					card.ability.extra.chips = card.ability.extra.chips + (HangedMan.triviaMachine_questions[card.ability.extra.question].value or 0)
					return {
						message = 'Correct!',
						colour = G.C.BLUE,
					}
				else
					card.ability.extra.chips = math.max(0,card.ability.extra.chips - (HangedMan.triviaMachine_questions[card.ability.extra.question].value or 0))
					return {
						message = 'Incorrect!',
						colour = G.C.RED,
					}
				end
			else
				card.ability.extra.chips = math.max(0,card.ability.extra.chips - (HangedMan.triviaMachine_questions[card.ability.extra.question].value or 0))
				return {
					message = 'Skipped!',
					colour = G.C.UI.TEXT_DARK,
				}
			end

			if G.GAME.HangedMan_triviaMachine_reduceInfo and HangedMan.triviaMachine_questions[card.ability.extra.question].reduceInfo then
				G.GAME.HangedMan_triviaMachine_reduceInfo = G.GAME.HangedMan_triviaMachine_reduceInfo or {}
				for _i, key in ipairs(HangedMan.triviaMachine_questions[card.ability.extra.question].reduceInfo) do
					if G.GAME.HangedMan_triviaMachine_reduceInfo and G.GAME.HangedMan_triviaMachine_reduceInfo[key] then G.GAME.HangedMan_triviaMachine_reduceInfo[key] = nil end
				end
			end

			card.ability.extra.accepting = false

		end




		if context.joker_main then 
			card.ability.extra.accepting = false
			if card.ability.extra.chips > 0 then return { chips = card.ability.extra.chips } end
		end

		if context.end_of_round and not context.blueprint then

			if G.GAME.HangedMan_triviaMachine_reduceInfo and HangedMan.triviaMachine_questions[card.ability.extra.question].reduceInfo then
				G.GAME.HangedMan_triviaMachine_reduceInfo = G.GAME.HangedMan_triviaMachine_reduceInfo or {}
				for _i, key in ipairs(HangedMan.triviaMachine_questions[card.ability.extra.question].reduceInfo) do
					if G.GAME.HangedMan_triviaMachine_reduceInfo and G.GAME.HangedMan_triviaMachine_reduceInfo[key] then G.GAME.HangedMan_triviaMachine_reduceInfo[key] = nil end
				end
			end

			card.ability.extra.question = -1
			card.ability.extra.accepting = false
			card.ability.extra.answered = nil
			card.ability.extra.wilded = false

		end
		
	end
}