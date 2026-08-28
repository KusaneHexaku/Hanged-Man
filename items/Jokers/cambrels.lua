SMODS.Joker {
	-- How the code refers to the joker.
	key = 'cambrels',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Cambrels',
		text = {
			"{C:attention}Shuffle{} Jokers held",
			"{C:white,X:mult}X#1#{} Mult if this card",
			"ends up in the {C:attention}leftmost{} slot",
		}
	},
	config = { extra = { xmult = 3, flag = false } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_LingoBlocks',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'lingo_jokers', 'xmult', 'joker_slot'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.press_play and not context.blueprint then
			card.ability.extra.flag = false
            if #G.jokers.cards > 0 and not context.blueprint then
                G.jokers:unhighlight_all()
                if #G.jokers.cards > 1 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.E_MANAGER:add_event(Event({
								trigger = 'immediate',
								func = function()
									G.jokers:shuffle('cambrels')
									play_sound('cardSlide1', math.random(0.85, 1.15))
									return true
								end
                   			}))
							delay(0.5)
							G.E_MANAGER:add_event(Event({
								trigger = 'immediate',
								func = function()
									G.jokers:shuffle('cambrels')
									play_sound('cardSlide1', math.random(0.85, 1.15))
									return true
								end
                   			}))
							delay(0.5)
							G.E_MANAGER:add_event(Event({
								trigger = 'immediate',
								func = function()
									G.jokers:shuffle('cambrels')
									play_sound('cardSlide1', math.random(0.85, 1.15))
									return true
								end
                   			}))
                            return true
                        end
                    }))
                end
            end
		end

		if context.before then
			if card.ability and G.jokers and G.jokers.cards and G.jokers.cards[1] == card then card.ability.extra.flag = true end
        end

		if context.joker_main and card.ability.extra.flag then
			return {xmult = card.ability.extra.xmult}
		end
	end,

}