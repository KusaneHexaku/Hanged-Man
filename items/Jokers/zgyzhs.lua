SMODS.Joker {
	-- How the code refers to the joker.
	key = 'zgyzhs',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Zgyzhs',
		text = {
			"Kozbvw {C:hearts}Wrznlmwh{} xziwh trev",
			"{C:chips}Nfog{} vjfzo gl {C:attention}hrcgvvm{}",
			"nrmfh rgh {C:attention}izmp{} ezofv",
		}
	},
	config = { extra = { atbashBase = 16 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        return { vars = { } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 1,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_LingoBlocks',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'lingo_jokers', 'mult', 'suit', 'diamonds', 'atbash'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.individual and context.cardarea == G.play and not context.end_of_round and context.other_card:is_suit('Diamonds') and context.other_card:get_id() then
            if context.other_card.debuff then
                return { message = localize('k_debuffed'), colour = G.C.RED }
            else
                return { mult = card.ability.extra.atbashBase - context.other_card:get_id(), colour = G.C.BLUE}
            end
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