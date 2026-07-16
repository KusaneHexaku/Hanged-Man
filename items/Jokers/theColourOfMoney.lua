SMODS.Joker {
	-- How the code refers to the joker.
	key = 'theColourOfMoney',
    unlocked = true,
	discovered = false,
	blueprint_compat = false,
    allow_duplicates = true,
	-- loc_text is the actual name and description that show in-game for the card.
	
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { colourName = '???', colourID = -1, countdown = -1, spriteX = 6, spriteY = 2,

	nameTable = {
		'Black',
		'Blue',
		'Bronze',
		'Celeste',
		'Cobalt',
		'Cosmic Latte',
		'White',
		'Cyan',
		'Gold',
		'Gray',
		'Green',
		'Harlequin',
		'Honeydew',
		'Yellow',
		'Lavender',
		'Lime',
		'Magenta',
		'Maroon',
		'Mauve',
		'Orange',
		'Pink',
		'Purple',
		'Red',
		'Silver',
		'Teal',
		'Vermilion'
	},

} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.colourName } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_TCoM',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 2 },
	-- Cost of card in shop.
	cost = 6,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'economy', 'chance', 'hidden_mechanic'},

	add_to_deck = function(self, card, from_debuff)

        if card.ability.extra.colourID == -1 and not from_debuff then
			card.ability.extra.colourID = pseudorandom("colourOfMoney", 1, 26)
			card.ability.extra.colourName = card.ability.extra.nameTable[card.ability.extra.colourID]
			local countdownKey = G.PROFILES[G.SETTINGS.profile]["colourOfMoneyKey"][card.ability.extra.colourID]
			local letters = {'B','C','D','F','G','H','J','K','L','M','N','P','Q','R','S','T','V','W','X','Y','Z','A','E','I','O','U'}

			if indexOf(letters, countdownKey) >= 22 then
				card.ability.extra.countdown = pseudorandom("colourOfMoney", (indexOf(letters, countdownKey) - 21)*5, (indexOf(letters, countdownKey) - 20)*5) 
			else
				card.ability.extra.countdown = indexOf(letters, countdownKey) + 4
			end

			if card.ability.extra.colourID <= 14 then
				card.ability.extra.spriteX = (card.ability.extra.colourID - 1) % 7
				card.ability.extra.spriteY = math.floor((card.ability.extra.colourID - 1) / 7)
			elseif card.ability.extra.colourID >= 15 then
				card.ability.extra.spriteX = (card.ability.extra.colourID - 15) % 6
				card.ability.extra.spriteY = math.floor((card.ability.extra.colourID - 15) / 6) + 2
			end

			card.children.center:set_sprite_pos({x = card.ability.extra.spriteX, y = card.ability.extra.spriteY})

		end	
	end,


	calculate = function(self, card, context)

		card.children.center:set_sprite_pos({x = card.ability.extra.spriteX, y = card.ability.extra.spriteY})

		if context.after and not context.blueprint then
            
			card.ability.extra.countdown = card.ability.extra.countdown - 1

			if card.ability.extra.countdown <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'TOO LATE!',
                    colour = G.C.FILTER
                }
			else
            	card.ability.extra_value = card.ability.extra_value + 1
            	card:set_cost()
            	return {
                	message = '+$1',
                	colour = G.C.MONEY
            	}
			end
        end

		

	end,

	locked_loc_vars = function(self, info_queue, card)
		return {
			vars = {

			}
		}
	end,


	-- unlock function
	-- The Colour of Money - ?
	check_for_unlock = function(self, args)
        if args.type == 'unlock_theColourOfMoney' then
			
        end
    end,

	set_sprites = function(self, card, front)
		G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                if card.ability then card.children.center:set_sprite_pos({x = card.ability.extra.spriteX, y = card.ability.extra.spriteY}) end
                return true
            end
        }))
	end


}

