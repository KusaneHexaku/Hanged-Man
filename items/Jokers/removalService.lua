SMODS.Joker {
	-- How the code refers to the joker.
	key = 'removalService',
    unlocked = false,
	blueprint_compat = false,
	-- loc_text is the actual name and description that show in-game for the card.
	
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { removalCost = 2} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.removalCost } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 1 },
	-- Cost of card in shop.
	cost = 3,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)


		if context.discard and not context.blueprint and #context.full_hand == 1 then

			for i, v in ipairs(G.hand.highlighted) do
				if SMODS.shatters(v) then
					v:shatter()
				else
					v:start_dissolve()
				end

				--ease_dollars(-card.ability.extra.removalCost)
				card.ability.extra.removalCost = (card.ability.extra.removalCost or 0) + 1

				return {
					dollars = -card.ability.extra.removalCost,
					remove = true
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
	-- Removal Service : Destroy 10 playing cards in a single run
	check_for_unlock = function(self, args)
        if args.type == 'unlock_removalService' then
			if G.GAME.cards_destroyed_this_run > 9 then 
				print("[HangedMan_Unlock] 10 playing cards removed - Removal Service unlocked!")
				unlock_card(self)
			end
        end
    end


}

