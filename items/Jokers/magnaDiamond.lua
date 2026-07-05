SMODS.Joker {
	-- How the code refers to the joker.
	key = 'magnaDiamond',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Magna Diamond',
		text = {
			"Each {C:diamonds}Diamonds{} cards held in hand",
			"give {C:mult}+#1#{} Mult for each",
			"{C:attention}9{} in your {C:attention}full deck{}",
			"{C:inactive}(Currently {}{C:mult}+#2#{}{C:inactive} Mult){}",
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { mult = 4 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local nine_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 9 then nine_tally = nine_tally + 1 end
            end
        end
		return { vars = { card.ability.extra.mult, card.ability.extra.mult*nine_tally } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Magna',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 0 },
	-- Cost of card in shop.
	cost = 4,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'mult', 'suit', 'diamonds', 'rank', 'nine', 'full_deck', 'magna'},
	calculate = function(self, card, context)

		local nine_tally = 0
        if G.playing_cards then
        	for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 9 then nine_tally = nine_tally + 1 end
        	end
        end

		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit('Diamonds') and nine_tally > 0 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {mult = card.ability.extra.mult*nine_tally, message = 'That\'s the Badger!', colour = G.C.BLUE}
            end
        end

	end,

}