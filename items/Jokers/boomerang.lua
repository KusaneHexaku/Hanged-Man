SMODS.Joker {
	-- How the code refers to the joker.
	key = 'boomerang',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Boomerang',
		text = {
			"{C:chips}+#2#{} Chips for each time",
			"this card is {C:attention}sold{} this run",
			"{C:inactive}(Currently{} {C:chips}+#1#{}{C:inactive} Chips){}"
		}
	},
	config = { extra = { multiplier = 250} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format((G.GAME.HangedMan_boomerangSellCount or 0) * card.ability.extra.multiplier), card.ability.extra.multiplier} }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 1,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 4 },
	-- Cost of card in shop.
	cost = 3,

	add_to_deck = function(self, card, from_debuff)
		
		if not from_debuff then
			G.GAME.HangedMan_boomerangSellCount = G.GAME.HangedMan_boomerangSellCount or 0
			G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    card:juice_up()
                    return {
						message = 'Returned!',
						colour = G.C.BLUE
					}
                end
            }))
		end

	end,


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.selling_self and not context.blueprint then

			G.GAME.HangedMan_boomerangSellCount = G.GAME.HangedMan_boomerangSellCount or 0
			G.GAME.HangedMan_boomerangSellCount = G.GAME.HangedMan_boomerangSellCount + 1

			G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    card:juice_up()
                    return {
						message = 'Thrown!',
						colour = G.C.BLUE
					}
                end
            }))
		
		end

		if context.joker_main and not ((G.GAME.HangedMan_boomerangSellCount or 0) == 0) then
			return {
				chips = (G.GAME.HangedMan_boomerangSellCount or 0) * card.ability.extra.multiplier
			}
		end

	end
}