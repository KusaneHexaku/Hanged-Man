SMODS.Joker {
	-- How the code refers to the joker.
	key = 'keeperOfTithe',
    unlocked = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	
	config = { extra = { mult = 0 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        return { vars = { number_format(card.ability.extra.mult) } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 5 },
	-- Cost of card in shop.
	cost = 8,
	attributes = {'economy', 'mult', 'scaling', 'on_sell', 'blue_prince'},


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.setting_blind and not context.blueprint then
			local tithe = G.GAME.dollars
			ease_dollars(-tithe)
			card.ability.extra.mult = card.ability.extra.mult + tithe

			return {
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
				colour = G.C.RED,
			}

        end

		if context.joker_main then return { mult = card.ability.extra.mult } end

		if context.selling_self then
			ease_dollars(card.ability.extra.mult)
		end
		
	end,

	check_for_unlock = function(self, args)
		local max = G.GAME.max_money_this_run or 0
        return args.type == 'win_custom' and max < 21
    end,
}