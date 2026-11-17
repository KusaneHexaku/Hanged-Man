SMODS.Joker {
	-- How the code refers to the joker.
	key = 'foolishJoker',
    unlocked = false,
	blueprint_compat = false,
	-- loc_text is the actual name and description that show in-game for the card.
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { deathActivating = false,

	supportedTarot = {
		-- list of Tarots with an implemented effect, used to check for the unsupported tarot message

		-- Vanilla Tarots
		'c_fool','c_magician','c_high_priestess','c_empress','c_emperor','c_heirophant','c_lovers','c_chariot','c_justice','c_hermit','c_wheel_of_fortune','c_strength','c_hanged_man','c_death','c_temperance','c_devil','c_tower','c_star','c_moon','c_sun','c_judgement','c_world',

		-- Phanta Tarots
		'c_phanta_gatherer','c_phanta_grave','c_phanta_brazier','c_phanta_sculptor','c_phanta_beekeeper','c_phanta_exorcist','c_phanta_angel','c_phanta_philosopher','c_phanta_sludge'

	},

	phanta_sludged = false

	} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)

		local mainend = {}
		local textrows = {}

		local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
		local last_tarot_planet = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or 'nothing'
		local colour1 = G.C.UI.TEXT_INACTIVE
		local professionalnoun = {'he', 'she', 'they'}

		if not fool_c then colour1 = G.C.UI.TEXT_INACTIVE
		elseif fool_c.set == 'Tarot' then colour1 = G.C.SECONDARY_SET.Tarot
		elseif fool_c.set == 'Planet' then
			colour1 = G.C.SECONDARY_SET.Planet
			info_queue[#info_queue + 1] = G.P_CENTERS[fool_c.key]
		else colour1 = G.C.UI.TEXT_INACTIVE
		end

		if fool_c and (fool_c.key == 'c_phanta_sludge') or (card.ability.extra.phanta_sludged) then
			last_tarot_planet = 'Sludge'
			card.ability.extra.phanta_sludged = true
			
			textrows = {
				{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
					{
	                    {n = G.UIT.T, config = {align = "cm", text = 'Sludged!', colour = G.C.RED, scale = 0.35}},
            		}
				},
				{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
					{
	                    {n = G.UIT.T, config = {align = "cm", text = 'All functionalities disabled', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
            		}
				},
			}

		elseif fool_c and (fool_c.key == 'c_fool') then
			colour1 = G.C.UI.TEXT_INACTIVE
			last_tarot_planet = 'nothing'

		elseif fool_c and (fool_c.set == 'Tarot') and (HangedMan.foolishJoker_effects[fool_c.key]) then

			local descobject = HangedMan.foolishJoker_effects[fool_c.key].description(card)
			-- append text
			for textLine = 1, #descobject, 1 do
				local textpiece = {}
				for _i, textcolourpair in ipairs(descobject[textLine]) do
					textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.32}}
				end
				textrows[textLine+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = textpiece}
			end

		elseif fool_c and (fool_c.set == 'Tarot') and (not HangedMan.foolishJoker_effects[fool_c.key]) then
			textrows = {
				{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
					{
	                    {n = G.UIT.T, config = {align = "cm", text = '[!] Incompatible Tarot [!]', colour = G.C.RED, scale = 0.35}},
            		}
				},
				{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = 
					{
	                    {n = G.UIT.T, config = {align = "cm", text = 'This card needs its Foolish effect implemented!', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
						{n = G.UIT.T, config = {align = "cm", text = 'If you\'re the creator of the mod this Tarot is from,', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
						{n = G.UIT.T, config = {align = "cm", text = 'check "Other/foolishJoker-effects.lua" to see how', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
						{n = G.UIT.T, config = {align = "cm", text = 'you can add your own Tarots\' effects to this card!', colour = G.C.UI.TEXT_DARK, scale = 0.32}},
            		}
				},
			}
		elseif fool_c and (fool_c.set == 'Planet') and (HangedMan.foolishJoker_effects[fool_c.key]) then
			local descobject = HangedMan.foolishJoker_effects[fool_c.key].description(card)
			-- append text
			for textLine = 1, #descobject, 1 do
				local textpiece = {}
				for _i, textcolourpair in ipairs(descobject[textLine]) do
					textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.32}}
				end

				textrows[textLine+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = textpiece}
			end

		elseif fool_c and (fool_c.set == 'Planet') and (not HangedMan.foolishJoker_effects[fool_c.key]) then
			local descobject = HangedMan.foolishJoker_effects['planet_replication_catchall'].description(card)
			-- append text
			for textLine = 1, #descobject, 1 do
				local textpiece = {}
				for _i, textcolourpair in ipairs(descobject[textLine]) do
					textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.32}}
				end

				textrows[textLine+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.025}, nodes = textpiece}
			end
		end

		mainend = {
            { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.025}, nodes = textrows}
        }


		return {
			vars = { last_tarot_planet, colours = {colour1} },
			main_end = mainend
		}
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 6 },
	-- Cost of card in shop.
	cost = 8,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'hangedman_tarot_jokers','economy','generation','rank','suit','hand_type','destroy_card','discard','joker','tarot','planet','tag','skip','modify_card','enhancements'},
	calculate = function(self, card, context)

		if card.ability.extra.phanta_sludged then return end

		local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
		if not fool_c then return end
		if fool_c.set == 'Tarot' then 
			if not HangedMan.foolishJoker_effects[fool_c.key] then return end
			HangedMan.foolishJoker_effects[fool_c.key].effect(card, context)
		elseif fool_c.set == 'Planet' then
			if HangedMan.foolishJoker_effects[fool_c.key] then HangedMan.foolishJoker_effects[fool_c.key].effect(card, context)
			else HangedMan.foolishJoker_effects['planet_replication_catchall'].effect(card, context) end
		end

		-- juice card if Hanged Man is active
		if context.first_hand_drawn and not card.ability.extra.phanta_sludged then
			local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
			if not fool_c then return true end
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES and fool_c and fool_c.key == 'c_hanged_man' end
            juice_card_until(card, eval, true)
        end

	end,

	locked_loc_vars = function(self, info_queue, card)
		return {
			vars = {

			}
		}
	end,


	-- unlock function
	-- Foolish Joker : Use the Fool 10 times in a single run
	check_for_unlock = function(self, args)
		local unlockflag = false
        if args.type == 'unlock_foolishJoker' then
			local fools_used = 0
        	for k, v in pairs(G.GAME.consumeable_usage) do
            	if v.key == 'c_fool' then fools_used = fools_used + 1 end
        	end
			if fools_used >= 10 then 
				unlockflag = true
				print("[HangedMan_Unlock] The Fools tarot has been used 10 times - Foolish Joker unlocked!")
			end
        end
		if unlockflag then unlock_card(self) end
    end
}