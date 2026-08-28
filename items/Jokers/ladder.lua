SMODS.Joker {
	-- How the code refers to the joker.
	key = 'ladder',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Ladder',
		text = {
			"Gain +{C:chips}#1#{} Chips if played",
			"{C:attention}poker hand{} contains but",
			"is not the same as previous hand",
			"{C:inactive}(Previous Hand: #2#){}",
			"{C:inactive}(Currently {}{C:chips}+#3#{}{C:inactive} Chips){}"
		}
	},
	config = { extra = { chips = 0, increment = 20, previousHandKey = nil
	} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local hand = 'None'
		if card.ability and card.ability.extra.previousHandKey then hand = localize(card.ability.extra.previousHandKey, 'poker_hands') end
        return { vars = { card.ability.extra.increment, hand , number_format(card.ability.extra.chips) } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_LingoBlocks',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'lingo_jokers', 'chips', 'scaling', 'hand_type'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.before and card.ability.extra.previousHandKey and next(context.poker_hands[card.ability.extra.previousHandKey]) then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.increment
			return {
                    message = 'Upgraded!',
				    colour = G.C.BLUE,
				    card = card
			}
		end

		if context.joker_main then return {chips = card.ability.extra.chips} end

		if context.after and not context.blueprint then
			local handname = context.scoring_name
			G.E_MANAGER:add_event(Event({
				func = (function()
					if card.ability then card.ability.extra.previousHandKey = handname end
					return true
				end)
			}))
		end
		
	end
}