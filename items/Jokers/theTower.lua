SMODS.Joker {
	-- How the code refers to the joker.
	key = 'theTower',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'The Tower',
		text = {
			"{C:attention}Leave{} the tower",
			"if the condition is statisfied",
			"Otherwise, {C:green}#1# in #2#{} chance",
            "to go up a floor after each hand",
		}
	},
	config = { extra = { 
		current_floor = 1,
		escape_condition = {},
		going_down = false,
		floor7_count = 0,
		freedom_countdown_reset = 20,
		freedom_countdown = 0
	 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local retvars = {}
		local retkey = 'j_hangedman_theTower'
		if #card.ability.extra.escape_condition > 0 then retkey = retkey..'_floor'..card.ability.extra.current_floor end

		if card.ability.extra.current_floor == 0 then
			local numerator, denominator = SMODS.get_probability_vars(card, 1, 4, 'hangedman_theTower_floor1')

			local enhanceinhandcount = 0
			local stoneindeckcount = 0

			for _, playing_card in ipairs(G.hand.cards or {}) do
				if next(SMODS.get_enhancements(playing_card)) then enhanceinhandcount = enhanceinhandcount + 20 end
			end
			for _, playing_card in ipairs(G.playing_cards or {}) do
				if next(SMODS.get_enhancements(playing_card)) and SMODS.has_enhancement(playing_card, 'm_stone') then stoneindeckcount = stoneindeckcount + 88 end
			end

        	retvars = {numerator, denominator, number_format(enhanceinhandcount + stoneindeckcount), number_format(5 * (#G.vouchers.cards or 0)), card.ability.extra.freedom_countdown_reset, card.ability.extra.freedom_countdown}
		end


		if card.ability.extra.current_floor == 1 then
			local numerator, denominator = SMODS.get_probability_vars(card, 1, 3, 'hangedman_theTower_floor1')
        	retvars = {numerator, denominator}
		end

		if card.ability.extra.current_floor == 2 then
			local chipscount = 0
			for _, playing_card in ipairs(G.hand.cards or {}) do
				if next(SMODS.get_enhancements(playing_card)) then chipscount = chipscount + 20 end
			end
			retvars = {chipscount}



		end

		if card.ability.extra.current_floor == 5 then retvars = {5 * (#G.vouchers.cards or 0)} end

		if card.ability.extra.current_floor == 4 then
			local numerator, denominator = SMODS.get_probability_vars(card, 1, 4, 'hangedman_theTower_floor1')
        	retvars = {numerator, denominator}
		end

		if card.ability.extra.current_floor == 8 then
			for index, card_table in ipairs(card.ability.extra.escape_condition) do
				local constructed_string = card_table[2]
				local ranktext = {'Jack', 'Queen', 'King', 'Ace'}
				if card_table[1] > 10 then constructed_string = ranktext[card_table[1]-10]..' of '..constructed_string
				else constructed_string = card_table[1]..' of '..constructed_string end
				retvars[#retvars+1] = constructed_string
			end
		end


        return { key = retkey, vars = retvars }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_TheTower',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 0 },
	-- Cost of card in shop.
	cost = 8,
	attributes = {'mult', 'chips', 'xmult', 'economy', 'rank', 'four', 'six', 'eight', 'chance', 'enhancements', 'stone', 'tarot', 'consumeables', 'hangedman_tarot_jokers'},

	add_to_deck = function(self, card, from_debuff)

        if #card.ability.extra.escape_condition < 1 and not from_debuff then

            local ranks = {2,3,4,5,6,7,8,9,10,11,12,13,14}
			local suits = {'Clubs','Hearts','Spades','Diamonds'}

			for i = 1, 5, 1 do
				local constructed_card = {}
				constructed_card[#constructed_card+1] = pseudorandom_element(ranks, pseudoseed('hangedman_constructTowerCondition'))
				constructed_card[#constructed_card+1] = pseudorandom_element(suits, pseudoseed('hangedman_constructTowerCondition'))
				card.ability.extra.escape_condition[#card.ability.extra.escape_condition+1] = constructed_card
			end
			print(card.ability.extra.escape_condition)

			card.ability.extra.freedom_countdown = card.ability.extra.freedom_countdown_reset

        end
    end,

	remove_from_deck = function(self, card, from_debuff)

    end,

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.setting_blind then 
			card.ability.extra.going_down = false
			card.ability.extra.floor7_count = 0
		end

		if card.ability.extra.current_floor == 0 then

			if context.discard and context.other_card:get_id() == 7 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {set = 'Tarot'}
                        G.GAME.consumeable_buffer = 0
						play_sound('timpani')
                        return true
                    end)
                }))
			end

			if context.individual and context.cardarea == G.play then

				local ret = {}

				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED
					}
				end

				if (context.other_card:get_id() or 0) == 4 and SMODS.pseudorandom_probability(card, 'hangedman_theTower', 1, 4) then ret.dollars = 4 end
				if (context.other_card:get_id() or 0) == 6 then ret.chips = 66 end
				if SMODS.has_enhancement(context.other_card, 'm_stone') then 
					if card.ability.extra.freedom_countdown - 1 < 1 then
						card.ability.extra.freedom_countdown = card.ability.extra.freedom_countdown_reset
						G.E_MANAGER:add_event(Event({
							func = (function()
								SMODS.add_card {set = 'Tarot', key = 'c_tower', edition = 'e_negative'}
								play_sound('timpani')
								return true
							end)
						}))
					else
						card.ability.extra.freedom_countdown = card.ability.extra.freedom_countdown - 1
					end
				end

				return ret

        	end

		
			if context.joker_main then
				local ret = {}
				local enhanceinhandcount = 0
				local stoneindeckcount = 0

				for _, playing_card in ipairs(G.hand.cards or {}) do
					if next(SMODS.get_enhancements(playing_card)) then enhanceinhandcount = enhanceinhandcount + 20 end
				end
				for _, playing_card in ipairs(G.playing_cards or {}) do
					if next(SMODS.get_enhancements(playing_card)) and SMODS.has_enhancement(playing_card, 'm_stone') then stoneindeckcount = stoneindeckcount + 88 end
				end

				if enhanceinhandcount + stoneindeckcount > 0 then ret.chips = enhanceinhandcount + stoneindeckcount end
				if (#G.vouchers.cards or 0) > 0 then ret.mult = 5 * (#G.vouchers.cards or 0) end

				return ret

			end

			if context.starting_shop then
				G.GAME.free_booster_packs_count = G.GAME.free_booster_packs_count + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						for _, other_card in pairs(G.I.CARD or {}) do
							if other_card.set_cost then other_card:set_cost() end
						end
						return true
					end
				}))
			end

			if context.ending_shop then
				if G.GAME.free_booster_packs_count > 0 then G.GAME.free_booster_packs_count = G.GAME.free_booster_packs_count - 1 end
				G.E_MANAGER:add_event(Event({
					func = function()
						for _, other_card in pairs(G.I.CARD or {}) do
							if other_card.set_cost then other_card:set_cost() end
						end
						return true
					end
				}))
			end

			if context.other_consumeable and context.other_consumeable.ability.set == 'Tarot' then
				return {
					x_mult = 1.25,
					message_card = context.other_consumeable
				}
        	end
		end





		if card.ability.extra.current_floor == 1 then
			if context.before and not context.blueprint then
				card.ability.extra.going_down = true
				if #context.full_hand < 5 then card.ability.extra.going_down = false
				else
					for i, playing_card in ipairs(context.full_hand or {}) do
						if not (playing_card:get_id() and playing_card:get_id() == card.ability.extra.escape_condition[i][1]) then card.ability.extra.going_down = false break end
						if not (playing_card:is_suit(card.ability.extra.escape_condition[i][2])) then card.ability.extra.going_down = false break end
					end
				end
			end

			if context.after and not context.blueprint then
				if card.ability.extra.going_down then 
					card.ability.extra.current_floor = 0
					G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('explosion_release1')
						return true
					end)
					}))
				elseif SMODS.pseudorandom_probability(card, 'hangedman_theTower', 1, 3) then 
					card.ability.extra.current_floor = 2
					G.E_MANAGER:add_event(Event({
						func = (function()
							card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
							card:juice_up(0.3, 0.5)
							play_sound('timpani')
							return true
						end)
					}))
				end
				return false
			end

		end

		if card.ability.extra.current_floor == 2 then

			if context.joker_main then
				local chipscount = 0
				for _, playing_card in ipairs(G.hand.cards or {}) do
					if next(SMODS.get_enhancements(playing_card)) then chipscount = chipscount + 20 end
				end
				return {chips = chipscount}
			end

			if context.before and not context.blueprint then
				local count = 0
				for _, playing_card in ipairs(context.full_hand or {}) do
					if next(SMODS.get_enhancements(playing_card)) then count = count + 1 end
				end
				if count > 2 and not card.ability.extra.going_down then card.ability.extra.going_down = true end
			end

			if context.after and not context.blueprint then
				if card.ability.extra.going_down then card.ability.extra.current_floor = 1 end
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				return false
			end

			if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				if card.ability.extra.going_down then card.ability.extra.current_floor = 1
				else card.ability.extra.current_floor = 3 end
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				return false
			end

		end

		if card.ability.extra.current_floor == 3 then

			if G.GAME.free_booster_packs_count < 1 then G.GAME.free_booster_packs_count = G.GAME.free_booster_packs_count + 1 end
			card.ability.extra.going_down = false

			if context.open_booster and not context.blueprint then 
				G.E_MANAGER:add_event(Event({
					func = function()
						for _, other_card in pairs(G.I.CARD or {}) do
							if other_card.set_cost then other_card:set_cost() end
						end
					return true
					end
				}))

				if context.booster.kind == 'Standard' or context.booster.kind == 'Spectral' then card.ability.extra.current_floor = 2
				else card.ability.extra.current_floor = 4 end
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				return false
			end

		end

		if card.ability.extra.current_floor == 4 then

			if context.individual and context.cardarea == G.play and (context.other_card:get_id() or 0) == 4 and SMODS.pseudorandom_probability(card, 'hangedman_theTower', 1, 4) then
				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED
					}
				else
					return {
						dollars = 4
					}
				end
        	end

			if context.before and not context.blueprint then
				local count = 0
				for _, playing_card in ipairs(context.full_hand) do
					if (playing_card:get_id() or 0) == 4 then count = count + 1 end
				end
				if count > 3 and not card.ability.extra.going_down then card.ability.extra.going_down = true end
			end

			if context.after and not context.blueprint then
				if card.ability.extra.going_down then 
					card.ability.extra.current_floor = 3
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				end
				return false
			end

			if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				if card.ability.extra.going_down then card.ability.extra.current_floor = 3
				else card.ability.extra.current_floor = 5 end
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				return false
			end

		end

		if card.ability.extra.current_floor == 5 then

			if context.joker_main and (#G.vouchers.cards or 0) > 0 then
				return {mult = 5 * (#G.vouchers.cards or 0)}
			end

			if context.buying_card and context.card.ability.set == 'Voucher' and not context.blueprint then
				card.ability.extra.current_floor = 4
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				return false
			end

			if context.setting_blind and not context.blueprint then
				card.ability.extra.current_floor = 6
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				return false
			end

		end

		if card.ability.extra.current_floor == 6 then

			if context.individual and context.cardarea == G.play and (context.other_card:get_id() or 0) == 6 then
				if context.other_card.debuff then
					return {
						message = localize('k_debuffed'),
						colour = G.C.RED
					}
				else
					return {
						chips = 66
					}
				end
        	end

			if context.before and not context.blueprint then
				local count = 0
				for _, playing_card in ipairs(G.playing_cards or {}) do
					if (playing_card:get_id() or 0) == 6 then count = count + 1 end
				end
				if count > 5 and not card.ability.extra.going_down then card.ability.extra.going_down = true end
			end

			if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				if card.ability.extra.going_down then card.ability.extra.current_floor = 5
				else card.ability.extra.current_floor = 7 end
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				return false
			end

		end

		if card.ability.extra.current_floor == 7 then

			if context.discard then
				
				if context.other_card:get_id() == 7 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	G.E_MANAGER:add_event(Event({
						func = (function()
							SMODS.add_card {set = 'Tarot'}
							G.GAME.consumeable_buffer = 0
							play_sound('timpani')
							return true
						end)
					}))
				end

				if not context.blueprint then card.ability.extra.floor7_count = card.ability.extra.floor7_count + 1 end

			end

			if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
				if card.ability.extra.floor7_count == 7 then card.ability.extra.current_floor = 6
				else card.ability.extra.current_floor = 8 end
				G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))
				return false
			end

		end

		if card.ability.extra.current_floor == 8 then
			
			if context.after and not context.blueprint then
				local flag = false
				for _, playing_card in ipairs(context.full_hand or {}) do
					if next(SMODS.get_enhancements(playing_card)) and SMODS.has_enhancement(playing_card, 'm_stone') then flag = true end
				end
				if flag then 
					card.ability.extra.current_floor = 7
					G.E_MANAGER:add_event(Event({
					func = (function()
						card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0})
						card:juice_up(0.3, 0.5)
						play_sound('timpani')
						return true
					end)
				}))

				end
				return false
			end

		end

	end,

	set_sprites = function(self, card, front)
		G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                if card.ability then card.children.center:set_sprite_pos({x = card.ability.extra.current_floor, y = 0}) end
                return true
            end
        }))
	end

	
}

