SMODS.Joker {
	-- How the code refers to the joker.
	key = 'peerPressure',
    unlocked = true,
    discovered = true,
	blueprint_compat = false,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Peer Pressure',
		text = {
			"If played hand contains at least {C:attention}3{} scoring cards",
			"with the same {C:attention}Enhancement{}, {C:attention}Seals{}, and/or {C:attention}Edition{},",
			"apply that {C:attention}Enhancement{}, {C:attention}Seals{}, and/or {C:attention}Edition{} to",
            "all scoring cards in played hand",
		}
	},
	config = { extra = {  } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)

        return { vars = { } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 1 },
	-- Cost of card in shop.
	cost = 8,


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.before and not context.blueprint then
			local enhancecount = {}
			local sealcount = {}
			local editioncount = {}
			local enhancecheckflag = false
			local sealcheckflag = false
			local editioncheckflag = false

			local toPressureChange = {}

			for _, scard in ipairs(context.scoring_hand) do

				if scard.debuff then goto continue else toPressureChange[#toPressureChange+1] = scard end

				local enhancementget = SMODS.get_enhancements(scard)

				if SMODS.get_enhancements(scard) then
					for enhancement, value in pairs(enhancementget) do
					enhancecount[enhancement] = enhancecount[enhancement] or 0
					enhancecount[enhancement] = enhancecount[enhancement] + 1
					if enhancecount[enhancement] > 2 then enhancecheckflag = true end
					end
				end
				
				if scard.seal and scard:get_seal() then 
					sealcount[scard:get_seal()] = sealcount[scard:get_seal()] or 0
					sealcount[scard:get_seal()] = sealcount[scard:get_seal()] + 1
					if sealcount[scard:get_seal()] > 2 then sealcheckflag = true end
				end

				if scard.edition then 
					editioncount[scard.edition.key] = editioncount[scard.edition.key] or 0
					editioncount[scard.edition.key] = editioncount[scard.edition.key] + 1
					if editioncount[scard.edition.key] > 2 then editioncheckflag = true end
				end

				::continue::
			end

			--print(enhancecount)
			--print(sealcount)
			--print(editioncount)

			if (enhancecheckflag or sealcheckflag or editioncheckflag) then
				for _, sscard in ipairs(toPressureChange) do
					if not sscard.debuff then
						G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
							sscard:flip()
							sscard:juice_up(0.3, 0.3)
							play_sound('tarot1', 0.8, 0.4)							
							return true
						end
						}))
					end
					delay(0.15)
				end

				delay(0.3)

				for _, sscard in ipairs(toPressureChange) do

					if enhancecheckflag then
						for key, value in pairs(enhancecount) do
							if value > 2 and not SMODS.has_enhancement(sscard, key) then 
								sscard:set_ability(key, nil, true)
							end
						end
					end
					
					if sealcheckflag then
						for key, value in pairs(sealcount) do
							if value > 2 then 
								sscard:set_seal(key, nil, true)
							end
						end
					end
					
					if editioncheckflag then
						for key, value in pairs(editioncount) do
							if value > 2 and ((not sscard.edition) or (sscard.edition and (not sscard.edition.key == key))) then 
								sscard:set_edition(key, nil, true)
							end
						end
					end

					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
							sscard:flip()
							sscard:juice_up(0.3, 0.3)
							play_sound('tarot2', 0.8, 0.6)
							return true
						end
					}))
					delay(0.15)
					
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