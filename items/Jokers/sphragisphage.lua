SMODS.Joker {
	-- How the code refers to the joker.
	key = 'sphragisphage',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Sphragisphage',
		text = {
			"Consume certain {C:attention}seals{} from played cards",
			"and gain effect based on type of seal consumed",
		}
	},
	config = { extra = { 
		sealConsumed = {
			['Red'] = 0,
			['Blue'] = 0,
			['Purple'] = 0,
			['Gold'] = 0,
			['Glass'] = 0,
			['Hiking'] = 0,
			['Space'] = 0,
			['Stone'] = 0
		} ,
		sealNames = {
			['Red'] = 'Red',
			['Blue'] = 'Blue',
			['Purple'] = 'Purple',
			['Gold'] = 'Gold',
			['hangedman_glass'] = 'Glass',
			['hangedman_hiking'] = 'Hiking',
			['hangedman_space'] = 'Space',
			['hangedman_stone'] = 'Stone',

			-- cwossmod :3

			-- Seals from Phanta
			-- Ghost Seal
			['phanta_ghostseal'] = 'Ghost',

			-- Seals from BFDI
			-- Naily Seal
			['bfdi_naily'] = 'Naily',
		},
		supportedSeal = {'Red', 'Blue', 'Purple', 'Gold', 'hangedman_glass', 'hangedman_hiking', 'hangedman_space', 'hangedman_stone'},
		startChecking = false

	} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local mainend = {}

		local textrows = {}

		local sealcolour =
		{
			['Red'] = G.C.RED,
			['Blue'] = G.C.BLUE,
			['Purple'] = G.C.PURPLE,
			['Gold'] = G.C.GOLD,
			['Glass'] = G.C.GREEN,
			['Hiking'] = G.C.CHIPS,
			['Space'] = G.C.GREEN,
			['Stone'] = G.C.UI.TEXT_INACTIVE,

			-- Seals from Phanta
			-- Ghost Seal
			['Ghost'] = G.C.UI.TEXT_INACTIVE,

			-- Seals from BFDI
			-- Naily Seal
			['Naily'] = G.C.UI.TEXT_INACTIVE,
		}

		local textlookup = {
			['Red'] = {{'Retrigger playing cards ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'time for every ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'Red Seals ', G.C.RED}, {'consumed', G.C.UI.TEXT_DARK}},
			['Blue'] = {{'When Blind beaten, create ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'Planet ', G.C.SECONDARY_SET.Planet}, {'card of played hand for every ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'Blue Seals ', G.C.BLUE}, {'consumed ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['Purple'] = {{'Create ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random ', G.C.UI.TEXT_DARK}, {'Tarot ', G.C.SECONDARY_SET.Tarot}, {'card for every ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'Purple Seals ', G.C.PURPLE}, {'consumed ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['Gold'] = {{'Give ', G.C.UI.TEXT_DARK}, {'money ', G.C.MONEY}, {'equal to number of ', G.C.UI.TEXT_DARK}, {'Gold Seals ', G.C.GOLD}, {'consumed ', G.C.UI.TEXT_DARK}},
			['Glass'] = {{'Retrigger playing cards ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'time for every ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'Glass Seals ', G.C.GREEN}, {'consumed', G.C.UI.TEXT_DARK}},
			['Hiking'] = {{'Scored cards permanently gain ', G.C.UI.TEXT_DARK}, {'+4 ', G.C.CHIPS}, {'Chips for every ', G.C.UI.TEXT_DARK}, {'Hiking Seals ', G.C.BLUE}, {'consumed', G.C.UI.TEXT_DARK}},
			['Space'] = {{'Upgrade played ', G.C.UI.TEXT_DARK}, {'poker hand ', G.C.FILTER}, {'by ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'level for every ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'Space Seals ', G.C.GREEN}, {'consumed', G.C.UI.TEXT_DARK}},
			['Stone'] = {{'+1 ', G.C.FILTER}, {'to number of consumed seals of all other Seal types for every ', G.C.UI.TEXT_DARK}, {'3 ', G.C.FILTER}, {'Stone Seal ', G.C.UI.TEXT_INACTIVE}, {'consumed', G.C.UI.TEXT_DARK} },

			-- Seals from Phanta
			-- Ghost Seal
			['Ghost'] = {{'When playing a ', G.C.UI.TEXT_DARK}, {'Junk', G.C.FILTER}, {', create ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random ', G.C.UI.TEXT_DARK}, {'Spectral ', G.C.SECONDARY_SET.Spectral}, {'card for every ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'Ghost Seals ', G.C.UI.TEXT_INACTIVE}, {'consumed ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},

			-- Seals from BFDI
			-- Naily Seal
			['Naily'] = {{'Held cards with ', G.C.UI.TEXT_DARK}, {'Naily Seal ', G.C.UI.TEXT_INACTIVE}, {'also give ', G.C.UI.TEXT_DARK}, {'+15 ', G.C.RED}, {'Mult for every ', G.C.UI.TEXT_DARK}, {'3 ', G.C.FILTER}, {'Naily Seals ', G.C.UI.TEXT_INACTIVE}, {'consumed', G.C.UI.TEXT_DARK}}

			}
		
		for key, value in pairs(card.ability.extra.sealConsumed) do
			if value > 0 then card.ability.extra.startChecking = true end
		end

		if card.ability and card.ability.extra.startChecking then

			for key, value in pairs(card.ability.extra.sealConsumed) do

				local textpiece = {
					{n = G.UIT.T, config = {align = "cm", text = key .. ' Seal', colour = sealcolour[key], scale = 0.3}},
					{n = G.UIT.T, config = {align = "cm", text = ': ', colour = G.C.UI.TEXT_DARK, scale = 0.3}}
				}
				if value > 0 then

					for _i, textcolourpair in ipairs(textlookup[key]) do
						textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.3}}
					end

					textrows[#textrows+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.05}, nodes = textpiece}

					textrows[#textrows+1] = {n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = {
							{n = G.UIT.T, config = {align = "cm", text = '(', colour = G.C.UI.TEXT_INACTIVE, scale = 0.3}},
                            {n = G.UIT.T, config = {align = "cm", text = '' .. value .. ' ' , colour = G.C.FILTER, scale = 0.3}},
							{n = G.UIT.T, config = {align = "cm", text = '' .. key .. ' Seals ' , colour = sealcolour[key], scale = 0.3}},
							{n = G.UIT.T, config = {align = "cm", text = 'consumed)', colour = G.C.UI.TEXT_INACTIVE, scale = 0.3, max_h = 1}},
                    }}

				end

			end

			mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = textrows}
            }
		else
			mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = 
					{{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = {
                            {n = G.UIT.T, config = {align = "cm", text = 'No effect currently', colour = G.C.UI.TEXT_INACTIVE, scale = 0.3, max_h = 1, max_w = 8, padding = 0}},
                    }}}
				}
            }
		end

		return { vars = { }, main_end = mainend }

	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 2 },
	-- Cost of card in shop.
	cost = 8,
	attributes = {'seals', 'modify_card', 'retrigger', 'hand_type', 'tarot', 'planet', 'generation', 'spectral', 'mult'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.before then

			-- Adding seals from Supported mods into supportedSeal

			-- Seals from Phanta
			-- Ghost Seal
			if next(SMODS.find_mod('GSPhanta')) and not indexOf(card.ability.extra.supportedSeal, 'phanta_ghostseal') then
				card.ability.extra.supportedSeal[#card.ability.extra.supportedSeal+1] = 'phanta_ghostseal'
				card.ability.extra.sealConsumed['Ghost'] = card.ability.extra.sealConsumed['Ghost'] or 0
			end

			-- Seals from BFDI
			-- Naily Seal
			if next(SMODS.find_mod('GSBFDI')) and not indexOf(card.ability.extra.supportedSeal, 'bfdi_naily') then
				card.ability.extra.supportedSeal[#card.ability.extra.supportedSeal+1] = 'bfdi_naily'
				card.ability.extra.sealConsumed['Naily'] = card.ability.extra.sealConsumed['Naily'] or 0
			end

			
			
			if not context.blueprint then
				
				local sealed = {}
				for _, scored_card in ipairs(context.scoring_hand) do
					if scored_card.seal and scored_card:get_seal() and not scored_card.debuff and not scored_card.sphragisphaged and indexOf(card.ability.extra.supportedSeal, scored_card:get_seal()) then
						local sealtype = card.ability.extra.sealNames[scored_card:get_seal()]

						if sealtype == 'Stone' and card.ability.extra.sealConsumed['Stone'] % 3 == 2 then
							for key, value in pairs(card.ability.extra.sealConsumed) do
								if not (key == 'Stone') then card.ability.extra.sealConsumed[key] = (card.ability.extra.sealConsumed[key] or 0) + 1 end	
							end
						end
						card.ability.extra.sealConsumed[sealtype] = (card.ability.extra.sealConsumed[sealtype] or 0) + 1
						sealed[#sealed + 1] = scored_card
						scored_card.sphragisphaged = true
						G.E_MANAGER:add_event(Event({
							func = function()
								scored_card:set_seal(nil, nil, true)
								scored_card:juice_up()
								scored_card.sphragisphaged = nil
								return true
							end
						}))
					end
				end

			end

			local spacelevel = math.floor(card.ability.extra.sealConsumed['Space'] / 2)
			

			if spacelevel > 0 then
				SMODS.upgrade_poker_hands({hands = {context.scoring_name}, level_up = spacelevel })
			end

			-- Handle Ghost Seal's effect
			if indexOf(card.ability.extra.supportedSeal, 'phanta_ghostseal') then
				local ghostspawn = math.floor((card.ability.extra.sealConsumed['Ghost'] or 0) / 2)
				if context.scoring_name == 'phanta_junk' and ghostspawn and (ghostspawn > 0) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					for i = 1, math.min(ghostspawn, G.consumeables.config.card_limit - #G.consumeables.cards) do
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							func = function()
								if G.consumeables.config.card_limit > #G.consumeables.cards then
									play_sound('timpani')
									SMODS.add_card({ set = 'Spectral', key_append = "sphragisphage" })
									card:juice_up(0.3, 0.5)
								end
								return true
							end
						}))
					end
				end
			end

			


        end


		if context.repetition and not context.repetition_only then

			local redrep = math.floor(card.ability.extra.sealConsumed['Red'] / 2)
			local glassrep = math.floor(card.ability.extra.sealConsumed['Glass'] / 2) * 2

			if (redrep + glassrep) < 1 then
			elseif (redrep + glassrep) > 0 and context.cardarea == G.play then
				return {
                message = 'Again!',
                repetitions = redrep + glassrep,
            	}
			elseif (redrep + glassrep) > 0 and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
				return {
                message = 'Again!',
                repetitions = redrep + glassrep,
            	}
			end

        end

		if context.individual and context.cardarea == G.play then
			if context.other_card.debuff  then
				return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
			end

			if card.ability.extra.sealConsumed['Hiking'] > 0 then
				context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + (4 * card.ability.extra.sealConsumed['Hiking'])
				return {
                    message = 'Upgrade!',
                    colour = G.C.BLUE
                }
			end

		end

		if context.individual and context.cardarea == G.hand then

			local nailyMult = math.floor((card.ability.extra.sealConsumed['Naily'] or 0) / 3) * 15
			if nailyMult > 0 and context.other_card:get_seal() == 'bfdi_naily' and not context.end_of_round then return {mult = nailyMult} end

		end




		if context.after then
		
			local purplespawn = math.floor(card.ability.extra.sealConsumed['Purple'] / 2)
			local gold = card.ability.extra.sealConsumed['Gold']

			if card.ability.extra.sealConsumed['Gold'] > 0 then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						ease_dollars(gold)
						card:juice_up(0.3, 0.5)
						return true
					end
				}))
				
			end

			if purplespawn > 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				for i = 1, math.min(purplespawn, G.consumeables.config.card_limit - #G.consumeables.cards) do
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						func = function()
							if G.consumeables.config.card_limit > #G.consumeables.cards then
								play_sound('timpani')
								SMODS.add_card({ set = 'Tarot', key_append = "sphragisphage" })
								card:juice_up(0.3, 0.5)
							end
							return true
						end
					}))
				end
            end

		end

		if context.end_of_round then

			local bluespawn = math.floor(card.ability.extra.sealConsumed['Blue'] / 2)
			local _planet = nil

			if G.GAME.last_hand_played then
				for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
					if planet_center.config.hand_type == G.GAME.last_hand_played then
						_planet = planet_center.key
					end
				end
			end

			if _planet and (bluespawn > 0) and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
				for i = 1, math.min(bluespawn, G.consumeables.config.card_limit - #G.consumeables.cards) do
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						func = function()
							if G.consumeables.config.card_limit > #G.consumeables.cards then
								play_sound('timpani')
								SMODS.add_card({ key = _planet })
								card:juice_up(0.3, 0.5)
							end
							return true
						end
					}))
				end
			end


        end





	end
}

 function indexOf(array, value)
		for i, v in ipairs(array) do
			if v == value then
				return i
			end
		end
	return nil
end