SMODS.Joker {
	-- How the code refers to the joker.
	key = 'ryb',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'RYB',
		text = {
			--[[
			The #1# is a variable that's stored in config, and is put into loc_vars.
			The {C:} is a color modifier, and uses the color "mult" for the "+#1# " part, and then the empty {} is to reset all formatting, so that Mult remains uncolored.
				There's {X:}, which sets the background, usually used for XMult.
				There's {s:}, which is scale, and multiplies the text size by the value, like 0.8
				There's one more, {V:1}, but is more advanced, and is used in Castle and Ancient Jokers. It allows for a variable to dynamically change the color. You can find an example in the Castle joker if needed.
				Multiple variables can be used in one space, as long as you separate them with a comma. {C:attention, X:chips, s:1.3} would be the yellow attention color, with a blue chips-colored background,, and 1.3 times the scale of other text.
				You can find the vanilla joker descriptions and names as well as several other things in the localization files.
				]]
			"{C:mult}+#1#{} Mult, {C:money}+$#2#{}, {C:chips}+#3#{} Chips",
            "Each {C:mult}Mult{}, {C:money}Gold{}, or {C:chips}Bonus{} card scored",
            "upgrades the other two values."
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { 	currentMult = 0, currentGold = 0, currentChip = 0,
							currentMultIncrement = 1, currentGoldIncrement = 1, currentChipIncrement = 5,
							currentMultCycle = 1, currentGoldCycle = 1, currentChipCycle = 1

	
} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS["m_mult"]
		info_queue[#info_queue + 1] = G.P_CENTERS["m_gold"]
		info_queue[#info_queue + 1] = G.P_CENTERS["m_bonus"]
		return { vars = { card.ability.extra.currentMult, card.ability.extra.currentGold, card.ability.extra.currentChip} }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 1 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context) 

        if context.individual and not context.blueprint and not context.other_card.debuff and context.cardarea == G.play then

				if SMODS.has_enhancement(context.other_card, 'm_mult') then
									
					-- Gold Upgrade
					card.ability.extra.currentGoldCycle = card.ability.extra.currentGoldCycle + 1
					if card.ability.extra.currentGoldCycle == 15 then
						card.ability.extra.currentGoldIncrement = card.ability.extra.currentGoldIncrement + 1
						card.ability.extra.currentGoldCycle = 0
					end
					card.ability.extra.currentGold = card.ability.extra.currentGold + card.ability.extra.currentGoldIncrement


					-- Chip Upgrade
					card.ability.extra.currentChipCycle = card.ability.extra.currentChipCycle + 1
					if card.ability.extra.currentChipCycle == 6 then
						card.ability.extra.currentChipIncrement = card.ability.extra.currentChipIncrement + 5
						card.ability.extra.currentChipCycle = 0
					end
					card.ability.extra.currentChip = card.ability.extra.currentChip + card.ability.extra.currentChipIncrement
				

					return {
                		message = 'RED',
						colour = G.C.RED,
							-- The return value, "card", is set to the variable "card", which is the joker.
							-- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
							-- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
						card = card
            		}
				
				elseif SMODS.has_enhancement(context.other_card, 'm_gold') then

					-- Mult Upgrade
					card.ability.extra.currentMultCycle = card.ability.extra.currentMultCycle + 1
					if card.ability.extra.currentMultCycle == 9 then
						card.ability.extra.currentMultIncrement = card.ability.extra.currentMultIncrement + 1
						card.ability.extra.currentMultCycle = 0
					end
					card.ability.extra.currentMult = card.ability.extra.currentMult + card.ability.extra.currentMultIncrement
					

					-- Chip Upgrade
					card.ability.extra.currentChipCycle = card.ability.extra.currentChipCycle + 1
					if card.ability.extra.currentChipCycle == 6 then
						card.ability.extra.currentChipIncrement = card.ability.extra.currentChipIncrement + 5
						card.ability.extra.currentChipCycle = 0
					end
					card.ability.extra.currentChip = card.ability.extra.currentChip + card.ability.extra.currentChipIncrement


					return {
                		message = 'YELLOW',
						colour = G.C.GOLD,
							-- The return value, "card", is set to the variable "card", which is the joker.
							-- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
							-- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
						card = card
            		}

				elseif SMODS.has_enhancement(context.other_card, 'm_bonus') then

					-- Mult Upgrade
					card.ability.extra.currentMultCycle = card.ability.extra.currentMultCycle + 1
					if card.ability.extra.currentMultCycle == 9 then
						card.ability.extra.currentMultIncrement = card.ability.extra.currentMultIncrement + 1
						card.ability.extra.currentMultCycle = 0
					end
					card.ability.extra.currentMult = card.ability.extra.currentMult + card.ability.extra.currentMultIncrement
					

					-- Gold Upgrade
					card.ability.extra.currentGoldCycle = card.ability.extra.currentGoldCycle + 1
					if card.ability.extra.currentGoldCycle == 15 then
						card.ability.extra.currentGoldIncrement = card.ability.extra.currentGoldIncrement + 1
						card.ability.extra.currentGoldCycle = 0
					end
					card.ability.extra.currentGold = card.ability.extra.currentGold + card.ability.extra.currentGoldIncrement


					return {
                		message = 'BLUE',
						colour = G.C.BLUE,
							-- The return value, "card", is set to the variable "card", which is the joker.
							-- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
							-- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
						card = card
            		}					
				end
        end

		-- Tests if context.joker_main == true.
		-- joker_main is a SMODS specific thing, and is where the effects of jokers that just give +stuff in the joker area area triggered, like Joker giving +Mult, Cavendish giving XMult, and Bull giving +Chips.
		if context.joker_main then
			-- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".

			return {
				mult = card.ability.extra.currentMult,
				extra = {
					dollars = card.ability.extra.currentGold,
					extra = {
						chips = card.ability.extra.currentChip,
					}
				}
			}
		end
	end
}

