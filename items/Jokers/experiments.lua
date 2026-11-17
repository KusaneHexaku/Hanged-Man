SMODS.Joker {
	-- How the code refers to the joker.
	key = 'experiments',
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
	config = { extra = { 

		activeTriggers = {},
		activeEffects = {},
		experimentsPhrases = {'?','?','?','?','?','?','?','?'},
		experimentsActive = 0,

		chip = 0, mult = 0, xmult = 1, goldEnd = 0,

		flag_incrementHand = 0,
		flag_convergeSuit = 0,
		flag_randomSuit = 0,

	} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local mainend = {}

		if card.ability and card.ability.extra.experimentsActive > 0 and HangedMan.experiments_triggers and HangedMan.experiments_effects then
			local textrows = {{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = {
                            {n = G.UIT.T, config = {align = "cm", text = 'Active Experiments :', colour = G.C.BLUE, scale = 0.3}},
                    }}}

			local col = G.C.FILTER

			for experimentIndex = 1, card.ability.extra.experimentsActive, 1 do
				local textpiece = {}

				for _i, textcolourpair in ipairs(HangedMan.experiments_triggers[card.ability.extra.activeTriggers[experimentIndex]].textbit) do
					textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.3}}
				end

				for _i, textcolourpair in ipairs(HangedMan.experiments_effects[card.ability.extra.activeEffects[experimentIndex]].textbit) do
					textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.3}}
				end

				textrows[experimentIndex+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.05}, nodes = textpiece}
			end

			mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = textrows}
            }
		else
			mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = 
					{{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = {
                            {n = G.UIT.T, config = {align = "cm", text = 'No active experiments currently', colour = G.C.UI.TEXT_INACTIVE, scale = 0.3}},
                    }}}
				}
            }
		end

		return { 
			vars = { card.ability.extra.chip, card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.goldEnd, },
			main_end = mainend
		}
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 4 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'blue_prince','mult','chips','xmult','economy','generation','rank','suit','hand_type','scaling','face','destroy_card','hands','discard','hand_size','joker','tarot','planet','spectral','tag','skip','modify_card','perma_bonus','reroll','enhancements'},


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		for index, trigger_key in ipairs(card.ability.extra.activeTriggers) do
			if HangedMan.experiments_triggers[trigger_key].eval(card, context) then
				HangedMan.experiments_effects[card.ability.extra.activeEffects[index]].effect(card, context)
			end
			if HangedMan.experiments_triggers[trigger_key].after_effect then HangedMan.experiments_triggers[trigger_key].after_effect(card, context) end
		end

		-- Boss Blind beaten, generate a new Experiment

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.experimentsActive < 8 then
            if context.beat_boss then

				G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
						card:juice_up()
						play_sound('generic1', 0.7 + math.random() * 0.1, 0.8)
            			play_sound('holo1', 1.0 + math.random() * 0.1, 0.4)
						return true
				end
				}))

				-- select a trigger not currently in use
				local triggerobject = pseudorandom_element(HangedMan.experiments_triggers, pseudoseed('HangedMan_experiment'))
				local _tit = 0
				while (HangedMan.indexOf(card.ability.extra.activeTriggers, triggerobject.key)) or (not triggerobject.available()) do
					_tit = _tit + 1
					triggerobject = pseudorandom_element(HangedMan.experiments_triggers, pseudoseed('HangedMan_experiment_resample_'.._tit))
				end

				-- select an effect not currently in use
				local effectobject = pseudorandom_element(HangedMan.experiments_effects, pseudoseed('HangedMan_experiment'))
				local _eit = 0
				while (HangedMan.indexOf(card.ability.extra.activeEffects, effectobject.key)) or (not effectobject.available()) do
					_eit = _eit + 1
					effectobject = pseudorandom_element(HangedMan.experiments_effects, pseudoseed('HangedMan_experiment_resample_'.._eit))
				end

				card.ability.extra.activeTriggers[#card.ability.extra.activeTriggers + 1] = triggerobject.key
				card.ability.extra.activeEffects[#card.ability.extra.activeEffects + 1] = effectobject.key
				card.ability.extra.experimentsActive = card.ability.extra.experimentsActive + 1
				
            end
        end

		if context.joker_main then		
			return {
				chips = card.ability.extra.chip,
				extra = {
					mult = card.ability.extra.mult,
					extra = {
						xmult = card.ability.extra.xmult,
					}
				}
			}	
		end

		if context.after then

			-- Decrementing all the Next Hand flags counters
			if card.ability.extra.flag_incrementHand > 0 then card.ability.extra.flag_incrementHand = card.ability.extra.flag_incrementHand -1 end
			if card.ability.extra.flag_convergeSuit > 0 then card.ability.extra.flag_convergeSuit = card.ability.extra.flag_convergeSuit -1 end
			if card.ability.extra.flag_randomSuit > 0 then card.ability.extra.flag_randomSuit = card.ability.extra.flag_randomSuit -1 end

		end

	end,
	
	calc_dollar_bonus = function(self, card)
		if card.ability.extra.goldEnd > 0 then return card.ability.extra.goldEnd end
	end

}

