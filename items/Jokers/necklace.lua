SMODS.Joker {
	-- How the code refers to the joker.
	key = 'necklace',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Necklace',
		text = {
			"{C:red}Destroy{} a random card held",
			"in hand, then create a random card",
			"with a random {C:attention}Seal{} or {C:dark_edition}Edition{}",
		}
	},
	config = { extra = { } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        return { vars = { } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_LingoBlocks',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'lingo_jokers', 'destroy_card', 'generation'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.before and G.hand and G.hand.cards and #G.hand.cards > 0 then
			local card_to_destroy = pseudorandom_element(G.hand.cards, 'random_destroy')
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					play_sound('tarot1')
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
			SMODS.destroy_cards(card_to_destroy)

			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.7,
				func = function()
					local cards = {}
					local negative_chance_flag = SMODS.pseudorandom_probability(card, 'HangedMan_necklace_negative', 1, 20)
					local seal = SMODS.poll_seal {key = 'HangedMan_necklace', guaranteed = true, type_key = 'HangedMan_necklace_seal'}
					local edition = SMODS.poll_edition {key = 'HangedMan_necklace', guaranteed = true, no_negative = negative_chance_flag}

					if SMODS.pseudorandom_probability(card, 'HangedMan_necklace_seal_or_edition', 1, 3) then
						cards[#cards+1] = SMODS.add_card { set = "Base", key_append = "HangedMan_necklace", edition = edition }
					else
						cards[#cards+1] = SMODS.add_card { set = "Base", key_append = "HangedMan_necklace", seal = seal }
					end
					
					SMODS.calculate_context({ playing_card_added = true, cards = cards })
					return true
				end
			}))
			delay(0.3)

		end
	end,
--[[
	set_card_type_badge = function(self, card, badges)

        badges[#badges+1] = create_badge('Fmxlnnlm', G.C.RARITY[2], G.C.WHITE, 1.2)
        badges[#badges+1] = create_badge('Szmtvw Nzm', HEX('A58544'))
        return true

    end,
]]
}