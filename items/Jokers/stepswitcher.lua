SMODS.Joker {
	-- How the code refers to the joker.
	key = 'stepswitcher',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Stepswitcher',
		text = {
			"{C:attention}Retrigger{} the {C:attention}#1#{} and",
			"{C:attention}#2#{} card in played hand,",
			"switches after each hand played",
		}
	},
	config = { extra = { backbeat = false, repetitions = 1, in_blind = false } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local phrase = {'first', 'third', 'second', 'fourth'}
		local offset = 0
		if card.ability.extra.backbeat then offset = 2 end
        return { vars = { phrase[1 + offset], phrase[2 + offset] } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Stepswitcher',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	attributes = {'retrigger', 'rhythm_heaven'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.setting_blind and not context.blueprint then
			card.ability.extra.in_blind = true
			local offset = 0
			if card.ability.extra.backbeat then offset = 1 end
			G.E_MANAGER:add_event(Event({
                blockable = false,
                trigger = 'after',
                func = function()
                        card:juice_up()
                        card.children.center:set_sprite_pos({x = 1+offset, y = 0})
                    return true
                end
            }))
		end

		if context.repetition and context.cardarea == G.play then
			local offset = 0
			if card.ability.extra.backbeat then offset = 1 end
			if (context.other_card == context.scoring_hand[1+offset]) or (context.other_card == context.scoring_hand[3+offset]) then
				return {repetitions = card.ability.extra.repetitions}
			end
        end

		if context.after and not context.blueprint then
			card.ability.extra.backbeat = not card.ability.extra.backbeat
			local offset = 0
			if card.ability.extra.backbeat then offset = 1 end
			G.E_MANAGER:add_event(Event({
                blockable = false,
                trigger = 'after',
                func = function()
                        card:juice_up()
                        card.children.center:set_sprite_pos({x = 1+offset, y = 0})
                    return true
                end
            }))
		end

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                blockable = false,
                trigger = 'after',
                func = function()
                        card:juice_up()
                        card.children.center:set_sprite_pos({x = 0, y = 0})
                    return true
                end
            }))
			card.ability.extra.in_blind = false
        end
		
	end,

	set_sprites = function(self, card, front)
		G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
				local offset = 0
				if card.abilty and card.ability.extra.backbeat then offset = 1 end
				if not card.ability.extra.in_blind then card.children.center:set_sprite_pos({x = 0, y = 0})
				else card.children.center:set_sprite_pos({x = 1+offset, y = 0})
				end
                return true
            end
        }))
	end
}