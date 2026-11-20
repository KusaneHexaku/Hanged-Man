SMODS.Joker {
	-- How the code refers to the joker.
	key = 'theTriviaMachine',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,

	config = { extra = { chips = 0, question = -1, used = {}, fallback = false,
		choices = {
			['Spades'] = '?',
			['Hearts'] = '?',
			['Clubs'] = '?',
			['Diamonds'] = '?'
		},
		correct = '?',
		streak = 0

		} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips} }
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

		local function HangedMan_triviaMachine_createQuestionMenu(q_ID, options)
			return create_UIBox_generic_options({
				contents = G.FUNCS.HangedMan_triviaMachine_createQuestionObject(q_ID, options),
				no_back = true
			})
		end

		G.FUNCS.HangedMan_triviaMachine_showQuestionMenu = function(q_ID, options)
			-- clears user selection from previous question
			G.GAME.HangedMan_triviaMachine_selected = nil
			-- pause the action
			G.SETTINGS.paused = true
			-- create the menu
			G.FUNCS.overlay_menu {
				definition = HangedMan_triviaMachine_createQuestionMenu(q_ID, options)
			}
		end

		G.FUNCS.HangedMan_triviaMachine_createQuestionObject = function(q_ID, options)
			-- this is the menu code itself

			local mainend = {}
			local value = 0
			local textrows = {}
			local question = {}
			local answer = {}
			local header = 'Welcome to the Trivia Machine!'

			if (not q_ID) or (not options) then

				textrows = {
					{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
						{
							{n = G.UIT.T, config = {align = "cm", text = 'ERROR LOADING QUESTIONS', colour = G.C.RED, scale = 0.35}},
						}
					},
					{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
						{
							{n = G.UIT.T, config = {align = "cm", text = 'Missing Question ID or Options table', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
						}
					},
					{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
						{
							{n = G.UIT.T, config = {align = "cm", text = 'Please report this to Kusane!', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
						}
					},
				}

			elseif q_ID > 0 then
				value = (HangedMan.triviaMachine_questions[q_ID].value or 0)
				header = 'Question ID '.. q_ID
				question = {
					{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
						{
							{n = G.UIT.T, config = {align = "cm", text = header, colour = G.C.UI.TEXT_INACTIVE, scale = 0.32}},
						}
					},
					{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
						{
							{n = G.UIT.T, config = {align = "cm", text = 'This question is worth ', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
							{n = G.UIT.T, config = {align = "cm", text = ''..value, colour = G.C.CHIPS, scale = 0.32}},
							{n = G.UIT.T, config = {align = "cm", text = ' Chips', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
						}
					},
				}

				-- append question
				for questionLine = 1, #HangedMan.triviaMachine_questions[q_ID].question, 1 do
					local textpiece = {}
					for _i, textcolourpair in ipairs(HangedMan.triviaMachine_questions[q_ID].question[questionLine]) do
						textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.36}}
					end

					question[#question+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = textpiece}
				end
				

				local col_table = {
					['Spades'] = G.C.SUITS.Spades,
					['Hearts'] = G.C.SUITS.Hearts,
					['Clubs'] = G.C.SUITS.Clubs,
					['Diamonds'] = G.C.SUITS.Diamonds,
				}

				answer[#answer+1] = {n = G.UIT.R, config = {button = "HangedMan_triviaMachine_button", answer_choice='Spades', align = "cm", h = 1.6, minw = 10, padding = 0.04, colour = col_table['Spades'], r = 0.02, hover = true}, nodes = {
					{n=G.UIT.C, config={}, nodes={
						{n = G.UIT.T, config = {align = "cm", text = options['Spades'], colour = G.C.WHITE, scale = 0.36}}
					}},
				}}
				answer[#answer+1] = {n = G.UIT.R, config = {button = "HangedMan_triviaMachine_button", answer_choice='Hearts', align = "cm", h = 1.6, minw = 10, padding = 0.04, colour = col_table['Hearts'], r = 0.02, hover = true}, nodes = {
					{n=G.UIT.C, config={}, nodes={
						{n = G.UIT.T, config = {align = "cm", text = options['Hearts'], colour = G.C.WHITE, scale = 0.36}}
					}},
				}}
				answer[#answer+1] = {n = G.UIT.R, config = {button = "HangedMan_triviaMachine_button", answer_choice='Clubs', align = "cm", h = 1.6, minw = 10, padding = 0.04, colour = col_table['Clubs'], r = 0.02, hover = true}, nodes = {
					{n=G.UIT.C, config={}, nodes={
						{n = G.UIT.T, config = {align = "cm", text = options['Clubs'], colour = G.C.WHITE, scale = 0.36}}
					}},
				}}
				answer[#answer+1] = {n = G.UIT.R, config = {button = "HangedMan_triviaMachine_button", answer_choice='Diamonds', align = "cm", h = 1.6, minw = 10, padding = 0.04, colour = col_table['Diamonds'], r = 0.02, hover = true}, nodes = {
					{n=G.UIT.C, config={}, nodes={
						{n = G.UIT.T, config = {align = "cm", text = options['Diamonds'], colour = G.C.WHITE, scale = 0.36}}
					}},
				}}

			end

			local question_ob = {
				{ n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = question}
			}

			local answer_ob = {
				{ n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = answer}
			}



			-- and then, return the ui
			local t = {
				{
				n = G.UIT.C,
				config = { align = "cm" },
				nodes = {
					{
					n = G.UIT.R,
					config = { align = "cm" },
					nodes = {
						{
						n = G.UIT.B,
						config = { w = 3, h = 0.2 },
						nodes = {}
						}
					}
					},
					{
					n = G.UIT.R,
					config = { align = "cm", r = 0.1, colour = G.C.WHITE, emboss = 0.05 },
					nodes = {
						{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.07, no_fill = false },
						nodes = question_ob
						},
					}
					},
					{
					n = G.UIT.R,
					config = { align = "cm", r = 0.1, colour = G.C.WHITE, emboss = 0.05 },
					nodes = {
						{
						n = G.UIT.R,
						config = { align = "cm", padding = 0.1, no_fill = false },
						nodes = answer_ob
						}
					}
					}
				}
				}
			}
			return t
		end

		G.FUNCS.HangedMan_triviaMachine_button = function(e)
			G.GAME.HangedMan_triviaMachine_selected = G.GAME.HangedMan_triviaMachine_selected or nil
			G.GAME.HangedMan_triviaMachine_selected = e.config.answer_choice
			G.FUNCS.HangedMan_triviaMachine_closeQuestionMenu()
		end

		-- called when leaving the menu
		G.FUNCS.HangedMan_triviaMachine_closeQuestionMenu = function(e)
		if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
		G.SETTINGS.paused = false
		end


		if context.setting_blind and not context.blueprint then

			if not HangedMan.triviaMachine_questions then card.ability.extra.fallback = true end

			-- IMPROBABLE FAILSAFE: if, somehow, atleast 75% of all questions in the packet has already been seen this run,
			-- allows the earliest seen question to be used again
			if #card.ability.extra.used > math.floor(#HangedMan.triviaMachine_questions*0.75) then
				table.remove(card.ability.extra.used, 1)
			end

			-- select a question that is not in the "used" list
			local _q = pseudorandom(pseudoseed('HangedMan_triviaMachine'), 1, #HangedMan.triviaMachine_questions)
			local _it = 0
			while HangedMan.indexOf(card.ability.extra.used, _q) do
    			_it = _it + 1
    			_q = pseudorandom(pseudoseed('HangedMan_triviaMachine_resample'.._it), 1, #HangedMan.triviaMachine_questions)
			end

			card.ability.extra.question = _q
			--print('Question #' .. card.ability.extra.question .. ' out of ' .. #HangedMan.triviaMachine_questions .. ' selected')

			local suitorder = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
			-- select correct suit and set it to the correct answer
			HangedMan.better_pseudoshuffle(suitorder, "HangedMan_triviaMachine")
			card.ability.extra.correct = suitorder[1]
			local correct = HangedMan.triviaMachine_questions[card.ability.extra.question].correct
			HangedMan.better_pseudoshuffle(correct, "HangedMan_triviaMachine")
			card.ability.extra.choices[suitorder[1]] = correct[1]

			-- pick 3 random incorrect answers to give to the other suits
			local incorrect = HangedMan.triviaMachine_questions[card.ability.extra.question].other_choices
			HangedMan.better_pseudoshuffle(incorrect, "HangedMan_triviaMachine")
			for i = 2, #suitorder, 1 do
				card.ability.extra.choices[suitorder[i]] = incorrect[i-1]
			end

			card.ability.extra.used[#card.ability.extra.used+1] = card.ability.extra.question

			-- if question has a reduceInfo key, set a flag to make that card shows an alternative description
			if HangedMan.triviaMachine_questions[card.ability.extra.question].reduceInfo then
				G.GAME.HangedMan_triviaMachine_reduceInfo = G.GAME.HangedMan_triviaMachine_reduceInfo or {}
				for _i, key in ipairs(HangedMan.triviaMachine_questions[card.ability.extra.question].reduceInfo) do
					G.GAME.HangedMan_triviaMachine_reduceInfo[key] = true
				end
			end

			G.E_MANAGER:add_event(Event({
			func = function()
				G.FUNCS.HangedMan_triviaMachine_showQuestionMenu(card.ability.extra.question,card.ability.extra.choices)
				return true
			end
			}))

			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.4,
				func = function()
					if (not G.GAME.HangedMan_triviaMachine_selected) or (not (card.ability.extra.correct == G.GAME.HangedMan_triviaMachine_selected)) then
						card.ability.extra.chips = math.max(0,card.ability.extra.chips - (HangedMan.triviaMachine_questions[card.ability.extra.question].value or 0))
						card.ability.extra.streak = 0
						HangedMan.display_wheel_text(card, 'Incorrect!', G.C.RED)
					else 
						card.ability.extra.chips = card.ability.extra.chips + (HangedMan.triviaMachine_questions[card.ability.extra.question].value or 0)
						card.ability.extra.streak = (card.ability.extra.streak or 0) + 1
						check_for_unlock({ type = 'who_wants_to_be_a_triviaMachine', streak = card.ability.extra.streak })
						HangedMan.display_wheel_text(card, 'Correct!', G.C.BLUE, 'timpani')
					end
					return true
				end
				}))
			delay(0.6)


		end

		if context.joker_main then 
			if card.ability.extra.chips > 0 then return { chips = card.ability.extra.chips } end
		end

		if context.end_of_round and not context.blueprint and not card.ability.extra.fallback then

			HangedMan.emptyTable(G.GAME.HangedMan_triviaMachine_reduceInfo)

			G.GAME.HangedMan_triviaMachine_reduceInfo = G.GAME.HangedMan_triviaMachine_reduceInfo or {}
			HangedMan.emptyTable(G.GAME.HangedMan_triviaMachine_reduceInfo)

			card.ability.extra.question = -1

		end
		
	end
}