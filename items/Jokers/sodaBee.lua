SMODS.Joker {
	-- How the code refers to the joker.
	key = 'sodaBee',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { mult = 3, fizz = 3, buzz = 5, sum = 0, sumdisplay = 0, fizzFlag = false, buzzFlag = false } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.fizz, card.ability.extra.buzz, card.ability.extra.sum , card.ability.extra.sumdisplay, card.ability.extra.fizzFlag, card.ability.extra.buzzFlag} }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)


        if context.before and not context.blueprint then
            
            card.ability.extra.sum = 0
			card.ability.extra.sumdisplay = 0
			card.ability.extra.fizzFlag = false
			card.ability.extra.buzzFlag = false

            for i,v in ipairs(G.play.cards) do 
                
				if not v.debuff and v:get_id() then
                	if v:get_id() == 14 then
                    card.ability.extra.sum = card.ability.extra.sum + 1
                	else 
                    card.ability.extra.sum = card.ability.extra.sum + v:get_id() 
                	end
				end
            end

			if card.ability.extra.sum % card.ability.extra.fizz == 0 then
				card.ability.extra.fizzFlag = true
			end
			if card.ability.extra.sum % card.ability.extra.buzz == 0 then
				card.ability.extra.buzzFlag = true
			end

			return {
				message = tostring(card.ability.extra.sum),
				-- The return value, "card", is set to the variable "card", which is the joker.
				-- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
				-- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
				card = card
			}
			

        end

		-- Tests if context.joker_main == true.
		-- joker_main is a SMODS specific thing, and is where the effects of jokers that just give +stuff in the joker area area triggered, like Joker giving +Mult, Cavendish giving XMult, and Bull giving +Chips.
		if context.joker_main then
			-- Tells the joker what to do. In this case, it pulls the value of mult from the config, and tells the joker to use that variable as the "mult_mod".

            if card.ability.extra.fizzFlag then
			    return {
				mult_mod = card.ability.extra.mult,
				-- This is a localize function. Localize looks through the localization files, and translates it. It ensures your mod is able to be translated. I've left it out in most cases for clarity reasons, but this one is required, because it has a variable.
				-- This specifically looks in the localization table for the 'variable' category, specifically under 'v_dictionary' in 'localization/en-us.lua', and searches that table for 'a_mult', which is short for add mult.
				-- In the localization file, a_mult = "+#1#". Like with loc_vars, the vars in this message variable replace the #1#.
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
				-- Without this, the mult will stil be added, but it'll just show as a blank red square that doesn't have any text.
			    }
            end

		end

        if context.post_trigger and not context.blueprint then
            if card.ability.extra.buzzzFlag then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.buzz
			    return {
                    message = 'Upgraded!',
				    colour = G.C.RED,
				    -- The return value, "card", is set to the variable "card", which is the joker.
				    -- Basically, this tells the return value what it's affecting, which if it's the joker itself, it's usually card.
				    -- It can be things like card = context.other_card in some cases, so specifying card (return value) = card (variable from function) is required.
				    card = card
			    }
            end
			card.ability.extra.sum = 0
			card.ability.extra.sumdisplay = 0
        end


	end
}