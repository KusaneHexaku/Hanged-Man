SMODS.Joker {
	-- How the code refers to the joker.
	key = 'comet',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Comet',
		text = {
			"Gain +{C:mult}#1#{} Mult if played",
			"{C:attention}poker hand{} is contained in",
			"but not the same as previous hand",
			"{C:inactive}(Previous Hand: #2#){}",
			"{C:inactive}(Currently {}{C:mult}+#3#{}{C:inactive} Mult){}"
		}
	},
	config = { extra = { mult = 0, increment = 4, previous_hand = 'None',

	previousHandTable = {
		['None'] = false,
		['High Card'] = false,
		['phanta_junk'] = false,
        ['Pair']= false,
        ['Two Pair']= false,
        ['Three of a Kind']= false,
        ['Straight']= false,
        ['Flush']= false,
        ['Full House']= false,
        ['Four of a Kind']= false,
        ['Straight Flush']= false,
        ['Royal Flush']= false,
        ['Five of a Kind']= false,
        ['Flush House']= false,
        ['Flush Five']= false,
	}


	} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment, card.ability.extra.previous_hand, number_format(card.ability.extra.mult) } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_LingoBlocks',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'lingo_jokers', 'mult', 'scaling', 'hand_type'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.before and card.ability.extra.previousHandTable[context.scoring_name] then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.increment
			return {
                    message = 'Upgraded!',
				    colour = G.C.RED,
				    card = card
			}
		end

		if context.joker_main then return {mult = card.ability.extra.mult} end

		if context.after and not context.blueprint and G.handlist then
			for _i, hand in ipairs(G.handlist) do
				if next(context.poker_hands[hand]) then card.ability.extra.previousHandTable[hand] = true else card.ability.extra.previousHandTable[hand] = false end
			end
			card.ability.extra.previousHandTable[context.scoring_name] = false
			local handname = context.scoring_name
			G.E_MANAGER:add_event(Event({
				func = (function()
					if card.ability then card.ability.extra.previous_hand = localize(handname, 'poker_hands') end
					return true
				end)
			}))
		end
		
	end
}