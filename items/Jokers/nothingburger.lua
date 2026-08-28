SMODS.Joker {
	-- How the code refers to the joker.
	key = 'nothingburger',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Nothingburger',
		text = {
			"Played {C:attention}unscored{} cards each",
			"add double its {C:attention}rank{}",
			"to {C:mult}Mult{} if they are",
			"between {C:attention}2{} scoring cards"
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 6 },
	-- Cost of card in shop.
	cost = 4,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'mult', 'rank', 'hand_type'},
	calculate = function(self, card, context)

		if context.individual and context.cardarea == 'unscored' and not context.other_card.debuff then

			local left = false
			local right = false
			local cardPos = HangedMan.indexOf(context.full_hand,context.other_card)
			if not cardPos or cardPos == 1 or cardPos == #context.full_hand then return true end

			for i = 1, #context.full_hand, 1 do
				if i < cardPos and HangedMan.indexOf(context.scoring_hand, context.full_hand[i]) then left = true end
				if i > cardPos and HangedMan.indexOf(context.scoring_hand, context.full_hand[i]) then right = true end
			end

            if left and right and context.other_card:get_id() then 
				local rank = context.other_card:get_id()
				if rank == 14 then rank = 11
				elseif rank > 10 then rank = 10
				end
				return {mult = 2*rank}
			end

        end
	end
}