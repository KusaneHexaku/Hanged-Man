SMODS.Joker {
	-- How the code refers to the joker.
	key = 'rideTheTide',
    unlocked = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { chips = 20, previousHandTier = nil, previousHandText = 'Previous hand : [none]',

    HandKey = {
        'High Card',
		'phanta_junk',
        'Pair',
        'Two Pair',
        'Three of a Kind',
        'Straight',
        'Flush',
        'Full House',
        'Four of a Kind',
        'Straight Flush',
        'Royal Flush',
        'Five of a Kind',
        'Flush House',
        'Flush Five'
    },
	HandName = {
        ['High Card'] = 'High Card',
		['phanta_junk'] = 'Junk',
        ['Pair']= 'Pair',
        ['Two Pair']= 'Two Pair',
        ['Three of a Kind']= 'Three of a Kind',
        ['Straight']= 'Straight',
        ['Flush']= 'Flush',
        ['Full House']= 'Full House',
        ['Four of a Kind']= 'Four of a Kind',
        ['Straight Flush']= 'Straight Flush',
        ['Royal Flush']= 'Royal Flush',
        ['Five of a Kind']= 'Five of a Kind',
        ['Flush House']= 'Flush House',
        ['Flush Five']= 'Flush Five'
    }



    } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.chips), card.ability.extra.previousHandText} }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 4 },
	-- Cost of card in shop.
	cost = 4,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'chips', 'hand_type', 'scaling'},
	calculate = function(self, card, context)

		if context.joker_main then

			local playedTier = indexOf(card.ability.extra.HandKey, context.scoring_name)

			if card.ability.extra.chips == 0 then
				card.children.center:set_sprite_pos({x = 5, y = 5})
				card.ability.extra.previousHandText = 'You\'ve Wiped Out!'
                card.ability.extra.previousHandTier = playedTier
				return false
			end

            if card.ability.extra.previousHandTier == nil then
                card.ability.extra.previousHandText = 'Previous hand : ' .. card.ability.extra.HandName[context.scoring_name]
                card.ability.extra.previousHandTier = playedTier
                return {
						chips = card.ability.extra.chips,
			    }
            end

            if playedTier > card.ability.extra.previousHandTier then
                card.ability.extra.chips = math.floor(card.ability.extra.chips * 2)
                card.ability.extra.previousHandText = 'Previous hand : ' .. card.ability.extra.HandName[context.scoring_name]
                card.ability.extra.previousHandTier = playedTier
                return {
				    message = 'Doubles!',
					colour = G.C.BLUE,
                    extra = {
						chips = card.ability.extra.chips,
					}
			    }
            end

            if playedTier < card.ability.extra.previousHandTier then
                card.ability.extra.chips = math.floor(card.ability.extra.chips / 10)

				if card.ability.extra.chips == 0 then
					G.E_MANAGER:add_event(Event({
                		trigger = 'immediate',
                		func = function()
							card.ability.extra.previousHandText = 'You\'ve Wiped Out!'
                    	    card:juice_up()
                    	    card.children.center:set_sprite_pos({x = 5, y = 5})
                    	    play_sound('crumpleLong2', 0.8, 0.4)
                    		return true
                		end
           	 		}))
					return {
				    	message = 'Wipeout!',
						colour = G.C.BLUE,
			    	}
				end


                card.ability.extra.previousHandText = 'Previous hand : ' .. card.ability.extra.HandName[context.scoring_name]
                card.ability.extra.previousHandTier = playedTier
                return {
				    message = 'Decimates!',
					colour = G.C.BLUE,
                    extra = {
						chips = card.ability.extra.chips,
					}
			    }
            end

		end

	end,

	-- unlock function
	-- Ride the Tide : Play 8 unique hand types in a single run
	check_for_unlock = function(self, args)
        if args.type == 'unlock_rideTheTide' then
			if #G.GAME.unique_hands_this_run >= 8 then
				unlock_card(self)
				print("[HangedMan_CalcEvent] 8 unique hand types has been played - Ride the Tide unlocked!" )
			end
        end
    end,

	set_sprites = function(self, card, front)
		G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                if card.ability and card.ability.extra.chips == 0 then card.children.center:set_sprite_pos({x = 5, y = 5}) end
                return true
            end
        }))
	end
}

