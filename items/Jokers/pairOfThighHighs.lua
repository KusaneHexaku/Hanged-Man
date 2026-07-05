SMODS.Joker {
	-- How the code refers to the joker.
	key = 'pairOfThighHighs',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Pair of Thigh Highs',
		text = {
			"If both {C:attention}Pair{} and {C:attention}High Card{} have been",
			"played this Blind, upgrade level of {C:attention}played hand{}",
			"if it's not a {C:attention}Pair{} or {C:attention}High Card{}",
		}
	},
	config = { extra = { pairplayed = false, highcardplayed = false } },
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
	pos = { x = 2, y = 2 },
	-- Cost of card in shop.
	cost = 5,
	attributes = {'hand_type'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.setting_blind and not context.blueprint then
			card.ability.extra.pairplayed = false
			card.ability.extra.highcardplayed = false
		end

		if context.before then
			card.ability.extra.pairplayed = (card.ability.extra.pairplayed or (context.scoring_name == 'Pair'))
			card.ability.extra.highcardplayed = (card.ability.extra.highcardplayed or (context.scoring_name == 'High Card'))

			if card.ability.extra.pairplayed and card.ability.extra.highcardplayed and not ((context.scoring_name == 'Pair') or (context.scoring_name == 'High Card')) then
				SMODS.upgrade_poker_hands({ hands = {context.scoring_name}})
			end
		end

	end
}