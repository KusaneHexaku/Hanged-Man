SMODS.Joker {
	-- How the code refers to the joker.
	key = 'pickACardAnyCard',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	
	config = { extra = { chips = 13, mult = 13, xmult = 1.3, rank = 0, suit = '', incrementmult = 1.3, cyclomancy_index = -1 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.incrementmult } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_pickacardanycard',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 8,
	attributes = {'chips', 'mult', 'xmult', 'scaling', 'chance', 'hidden_mechanic', 'hidden_interaction'},


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)


		if context.before and not context.blueprint then

			local suitorder = {'Hearts','Clubs','Diamonds','Spades'}
			local suitindex = pseudorandom(pseudoseed('anycard'), 1, 4)

			if G.GAME.cyclomancy_active then
				-- if Cyclomancy is present, use the global Cyclomancy stack instead of selecting a random card
				if card.ability.extra.cyclomancy_index < 1 then card.ability.extra.cyclomancy_index = pseudorandom(pseudoseed('cyclomancy'), 1, 52)
				elseif card.ability.extra.cyclomancy_index == 52 then card.ability.extra.cyclomancy_index = 1
				else card.ability.extra.cyclomancy_index = card.ability.extra.cyclomancy_index + 1 end

				card.ability.extra.rank = (G.GAME.cyclomancy_stack[card.ability.extra.cyclomancy_index])[1] 
				card.ability.extra.suit = (G.GAME.cyclomancy_stack[card.ability.extra.cyclomancy_index])[2]

				print('Card #' .. card.ability.extra.cyclomancy_index .. ' of the Cyclomancy stack : ' .. card.ability.extra.rank .. ' of ' .. card.ability.extra.suit )

				local suitsorderindex = {
					['Hearts'] = 1,
					['Clubs'] = 2,
					['Diamonds'] = 3,
					['Spades'] = 4,
				}
				suitindex = suitsorderindex[card.ability.extra.suit]
			else
				-- otherwise, generate a random playing card normally
				card.ability.extra.rank = pseudorandom(pseudoseed('pickacard'), 2, 14)
				card.ability.extra.suit = suitorder[suitindex]
			end

			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					card.children.center:set_sprite_pos({x = card.ability.extra.rank - 2, y = suitindex})
					card:juice_up(0.4, 0.4)
					play_sound('tarot1', 1, 0.4)
					return true
				end
			}))


			

		end


		if context.individual and context.cardarea == G.play and not context.end_of_round then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
				local chips = 0
				local mult = 0
				local xmult = 1
				local colourflag = true
				local upgradeCheck = 0

				if card.ability.extra.suit == 'Clubs' or card.ability.extra.suit == 'Spades' then colourflag = not colourflag end
				if context.other_card:is_suit('Clubs') or context.other_card:is_suit('Spades') then colourflag = not colourflag end

				if colourflag then chips = card.ability.extra.chips end
				if context.other_card:is_suit(card.ability.extra.suit) then
					mult = card.ability.extra.mult
					upgradeCheck = upgradeCheck + 1
				end
				if context.other_card:get_id() == card.ability.extra.rank then
					xmult = card.ability.extra.xmult
					upgradeCheck = upgradeCheck + 1
				end

				if upgradeCheck == 2 then
					card.ability.extra.chips = HangedMan.round(card.ability.extra.chips * card.ability.extra.incrementmult, 2)
					card.ability.extra.mult = HangedMan.round(card.ability.extra.mult * card.ability.extra.incrementmult, 2)
					card.ability.extra.xmult = HangedMan.round(card.ability.extra.xmult * card.ability.extra.incrementmult, 2)
					--card.ability.extra.incrementmult = HangedMan.round(card.ability.extra.incrementmult * card.ability.extra.incrementmult, 2)
				end

				if chips + mult + xmult < 2 then return true else
					return {
						chips = chips,
						extra = {
							mult = mult,
							extra = {
								xmult = xmult,
							}
						}
					}
				end
            end
        end


		if context.after then
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					card.children.center:set_sprite_pos({x = 0, y = 0})
					card:juice_up(0.4, 0.4)
					play_sound('tarot2', 1, 0.4)
					return true
				end
			}))
		end

	end

	
}