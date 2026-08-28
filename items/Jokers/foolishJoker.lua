SMODS.Joker {
	-- How the code refers to the joker.
	key = 'foolishJoker',
    unlocked = false,
	blueprint_compat = false,
	-- loc_text is the actual name and description that show in-game for the card.
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { deathActivating = false } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
		local last_tarot_planet = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or 'nothing'
		local colour1 = G.C.UI.TEXT_INACTIVE

		if fool_c and fool_c.name == 'The Fool' then
			colour1 = G.C.UI.TEXT_INACTIVE
			last_tarot_planet = 'nothing'
		elseif fool_c and fool_c.name == 'The Wheel of Fortune' then
			colour1 = G.C.SECONDARY_SET.Tarot
			info_queue[#info_queue + 1] = G.P_CENTERS["c_wheel_of_fortune"]
		elseif fool_c and fool_c.set == "Tarot" then
			colour1 = G.C.SECONDARY_SET.Tarot
			info_queue[#info_queue + 1] = { set = fool_c.set, key = 'c_hangedman_foolishJoker_' .. last_tarot_planet:gsub("%s+", ""), vars = {} } 

			if fool_c.key == 'c_magician' then info_queue[#info_queue + 1] = G.P_CENTERS['m_lucky']
			elseif fool_c.key == 'c_empress' then info_queue[#info_queue + 1] = G.P_CENTERS['m_mult']
			elseif fool_c.key == 'c_heirophant' then info_queue[#info_queue + 1] = G.P_CENTERS['m_bonus']
			elseif fool_c.key == 'c_lovers' then info_queue[#info_queue + 1] = G.P_CENTERS['m_wild']
			elseif fool_c.key == 'c_chariot' then info_queue[#info_queue + 1] = G.P_CENTERS['m_steel']
			elseif fool_c.key == 'c_justice' then info_queue[#info_queue + 1] = G.P_CENTERS['m_glass']
			elseif fool_c.key == 'c_devil' then info_queue[#info_queue + 1] = G.P_CENTERS['m_gold']
			elseif fool_c.key == 'c_tower' then info_queue[#info_queue + 1] = G.P_CENTERS['m_stone']
			
			-- Phanta info_queues
			elseif fool_c.key == 'c_phanta_grave' then info_queue[#info_queue + 1] = G.P_CENTERS['m_phanta_ghostcard']
			elseif fool_c.key == 'c_phanta_brazier' then 
				info_queue[#info_queue + 1] = G.P_CENTERS['m_phanta_coppergratefreshshorter'] 
				info_queue[#info_queue + 1] = G.P_CENTERS['e_phanta_waxed_showcase']
			elseif fool_c.key == 'c_phanta_sculptor' then info_queue[#info_queue + 1] = G.P_CENTERS['m_phanta_marblecard']
			elseif fool_c.key == 'c_phanta_beekeeper' then info_queue[#info_queue + 1] = G.P_CENTERS['e_phanta_waxed_showcase']
			
			else 
				colour1 = G.C.UI.TEXT_INACTIVE
				info_queue[#info_queue + 1] = { set = "Tarot", key = 'c_hangedman_foolishJoker_incompatibleCardNotice', vars = {} } 
			end


		elseif fool_c and fool_c.set == "Planet" then
			local upgradeHand = HangedMan.get_hand_in_game(fool_c.key) or nil
			if not upgradeHand then
				colour1 = G.C.UI.TEXT_INACTIVE
				info_queue[#info_queue + 1] = { set = "Tarot", key = 'c_hangedman_foolishJoker_incompatibleCardNotice', vars = {} } 
			end
			colour1 = G.C.SECONDARY_SET.Planet
			info_queue[#info_queue + 1] = { set = "Tarot", key = 'c_hangedman_foolishJoker_UpgradePlanet', vars = {} } 
			info_queue[#info_queue + 1] = G.P_CENTERS[fool_c.key]
		end

		return { vars = { last_tarot_planet, colours = {colour1} } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 6 },
	-- Cost of card in shop.
	cost = 8,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'hangedman_tarot_jokers','economy','generation','rank','suit','hand_type','destroy_card','discard','joker','tarot','planet','tag','skip','modify_card','enhancements'},
	calculate = function(self, card, context)


		if context.before and not context.blueprint then

			local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
			if not fool_c then return true end
			
			local convertTarotGroup = {'c_magician','c_empress','c_lovers','c_heirophant','c_strength','c_devil','c_star','c_moon','c_sun','c_world'}

			-- handles the effects of Playing Cards manipulation type Tarots, activates when scored
			if fool_c and HangedMan.indexOf(convertTarotGroup, fool_c.key) then 
				local toEnhance = {}
	            for _, scored_card in ipairs(context.scoring_hand) do
					scored_card.foolishEnhance = nil
					if fool_c.key == 'c_magician' and not next(SMODS.get_enhancements(scored_card))
					or fool_c.key == 'c_empress' and not next(SMODS.get_enhancements(scored_card))
					or fool_c.key == 'c_lovers' and not next(SMODS.get_enhancements(scored_card))
					or fool_c.key == 'c_heirophant' and not next(SMODS.get_enhancements(scored_card))
					or fool_c.key == 'c_devil' and not next(SMODS.get_enhancements(scored_card))
					or fool_c.key == 'c_strength'
					or fool_c.key == 'c_star' and not scored_card:is_suit('Diamonds')
					or fool_c.key == 'c_moon' and not scored_card:is_suit('Clubs')
					or fool_c.key == 'c_sun' and not scored_card:is_suit('Hearts')
					or fool_c.key == 'c_world' and not scored_card:is_suit('Spades')
					then scored_card.foolishEnhance = true end

                	if not scored_card.debuff and scored_card.foolishEnhance then
	                    toEnhance[#toEnhance + 1] = scored_card
						G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
							scored_card:flip()
							scored_card:juice_up(0.3, 0.3)
							play_sound('tarot1', 0.8, 0.4)							
							return true
						end
						}))
                	end
				delay(0.25)
            	end

				delay(0.3)
				for _i, scored_card in ipairs(toEnhance) do
					if fool_c.key == 'c_magician' and not next(SMODS.get_enhancements(scored_card)) then scored_card:set_ability('m_lucky', nil, true)
					elseif fool_c.key == 'c_empress' and not next(SMODS.get_enhancements(scored_card)) then scored_card:set_ability('m_mult', nil, true)
					elseif fool_c.key == 'c_lovers' and not next(SMODS.get_enhancements(scored_card)) then scored_card:set_ability('m_wild', nil, true)
					elseif fool_c.key == 'c_heirophant' and not next(SMODS.get_enhancements(scored_card)) then scored_card:set_ability('m_bonus', nil, true)
					elseif fool_c.key == 'c_devil' and not next(SMODS.get_enhancements(scored_card)) then scored_card:set_ability('m_gold', nil, true)
					elseif fool_c.key == 'c_strength' then assert(SMODS.modify_rank(scored_card, 1))
					elseif fool_c.key == 'c_star' then scored_card:change_suit('Diamonds')
					elseif fool_c.key == 'c_moon' then scored_card:change_suit('Clubs')
					elseif fool_c.key == 'c_sun' then scored_card:change_suit('Hearts')
					elseif fool_c.key == 'c_world' then scored_card:change_suit('Spades')
					end
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
							scored_card:flip()
							scored_card:juice_up(0.3, 0.3)
							play_sound('tarot2', 0.8, 0.6)
							scored_card.foolishEnhance = nil
							return true
						end
					}))
					delay(0.25)
				end	
			end


			-- handles the effects of special cases Playing Cards manipulation type Tarots, picking 1 random card from hand
			local convertTo = nil
			local editionFlag = false
			if fool_c and fool_c.key == 'c_chariot' then convertTo = 'm_steel'
			elseif fool_c and fool_c.key == 'c_justice' then convertTo = 'm_glass' 
			elseif fool_c and fool_c.key == 'c_tower' then convertTo = 'm_stone'
			
			-- Phanta compat
			elseif fool_c and fool_c.key == 'c_phanta_grave' then convertTo = 'm_phanta_ghostcard'
			elseif fool_c and fool_c.key == 'c_phanta_brazier' then convertTo = 'm_phanta_coppergratefresh'
			elseif fool_c and fool_c.key == 'c_phanta_sculptor' then convertTo = 'm_phanta_marblecard'
			elseif fool_c and fool_c.key == 'c_phanta_beekeeper' then 
				convertTo = 'e_phanta_waxed'
				editionFlag = true
			else end
			
			if convertTo then
				local eligible_hand_card = {}

				if editionFlag then eligible_hand_card = SMODS.Edition:get_edition_cards(G.hand, true)
				else for _i, v in ipairs(G.hand.cards) do if not next(SMODS.get_enhancements(v)) then eligible_hand_card[#eligible_hand_card + 1] = v end end end
				local cardPicked = pseudorandom_element(eligible_hand_card, pseudoseed('foolishJoker'))

				if cardPicked then
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
							cardPicked:flip()
							cardPicked:juice_up(0.3, 0.3)
							play_sound('tarot1', 0.8, 0.4)							
							return true
						end
					}))

					delay(0.7)
		
					if editionFlag then cardPicked:set_edition(convertTo, true)
					else cardPicked:set_ability(convertTo, nil, true) end

					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
							cardPicked:flip()
							cardPicked:juice_up(0.3, 0.3)
							play_sound('tarot2', 0.8, 0.6)
							return true
						end
					}))

					delay(0.25)
				end
			end




		end

		if context.after and not context.blueprint then

			local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
			
			if not fool_c then return true end

			-- Crossmod compat : Phanta's Gatherer
			if fool_c and fool_c.key == 'c_phanta_gatherer' then
				G.E_MANAGER:add_event(Event({
            		trigger = 'after',
            		delay = 0.4,
            		func = function()
                		play_sound('timpani')
                		card:juice_up(0.3, 0.5)
                		ease_dollars(4, true)
                		return true
            		end
        		}))
			end


			

			-- handles Tarots effects that spawns a Consumable card
			local spawnType = nil
			if fool_c and fool_c.key == 'c_high_priestess' then spawnType = 'Planet'
			elseif fool_c and fool_c.key == 'c_emperor' then spawnType = 'Tarot' end

			if spawnType and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = spawnType,
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
            end

			-- handles Tarots that gives money
			if fool_c and fool_c.key == 'c_hermit' then
				G.E_MANAGER:add_event(Event({
            		trigger = 'after',
            		delay = 0.4,
            		func = function()
                		play_sound('timpani')
                		card:juice_up(0.3, 0.5)
                		ease_dollars(math.max(0, math.min(math.floor(G.GAME.dollars*0.2),20)), true)
                	return true
            	end
        		}))
        		delay(0.6)
			end

			if fool_c and fool_c.key == 'c_temperance' then
        		G.E_MANAGER:add_event(Event({
            		trigger = 'after',
            		delay = 0.4,
            		func = function()
                		play_sound('timpani')
                		card:juice_up(0.3, 0.5)
                		ease_dollars(pseudorandom_element(G.jokers.cards, pseudoseed('foolishJoker')).sell_cost, true)
                		return true
            		end
        		}))
        		delay(0.6)
			end


			-- handles Wheel of Fortune, code mostly yoinked directly from vremade's Wheel
			if fool_c and fool_c.key == 'c_wheel_of_fortune' then
				if SMODS.pseudorandom_probability(card, 'foolishJoker', 1, 4) then
            		local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
            		local eligible_card = pseudorandom_element(editionless_jokers, 'foolishJoker')
            		local edition = SMODS.poll_edition { key = 'foolishJoker', guaranteed = true, no_negative = true, options = { 'e_polychrome', 'e_holo', 'e_foil' } }

					G.E_MANAGER:add_event(Event({
                		trigger = 'after',
                		delay = 0.4,
                		func = function()
							eligible_card:set_edition(edition, true)
            				check_for_unlock({ type = 'have_edition' })
							return true
						end
                    }))

        		else
            		G.E_MANAGER:add_event(Event({
                		trigger = 'after',
                		delay = 0.4,
                		func = function()
                    		attention_text({
                        		text = localize('k_nope_ex'),
                        		scale = 1.3,
                        		hold = 1.4,
                        		major = card,
                        		backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        		align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and 'tm' or 'cm',
                        		offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        		silent = true
                    		})
                    		G.E_MANAGER:add_event(Event({
                        		trigger = 'after',
                        		delay = 0.06 * G.SETTINGS.GAMESPEED,
                        		blockable = false,
                        		blocking = false,
                        		func = function()
                            		play_sound('tarot2', 0.76, 0.4)
                            		return true
                        		end
                   			}))
                    	play_sound('tarot2', 1, 0.4)
                    	card:juice_up(0.3, 0.5)
                    	return true
                		end
            		}))
        		end
			end
		end

		-- end of round effects
		if context.end_of_round and context.game_over == false and not context.blueprint then
			local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil

			-- handles Judgement, spawning a Joker when Blind beaten
			if fool_c and fool_c.key == 'c_judgement' and #G.jokers.cards < G.jokers.config.card_limit then
				G.E_MANAGER:add_event(Event({
            		trigger = 'after',
            		delay = 0.4,
            		func = function()
            	  		play_sound('timpani')
            	  		SMODS.add_card({ set = 'Joker' })
            	   		card:juice_up(0.3, 0.5)
            	   		return true
           			end
        		}))
        		delay(0.6)
			end

			-- the rest of Planet cards effects

			if fool_c and fool_c.set == 'Planet' then
				--local upgradeHand = card.ability.extra.planetToHand[fool_c.key]

				-- catching special cases for non-standard Planet cards

				-- Aikoshen's Bishop Ring
				if fool_c.key == 'c_akyrs_planet_bishop_ring' then
				
					G.GAME.akyrs_pure_unlocked = true
					update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_akyrs_pure_hands'),chips = '...', mult = '...', level=''})
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
						play_sound('tarot1')
						card:juice_up(0.8, 0.5)
						G.TAROT_INTERRUPT_PULSE = true
						return true end }))
					update_hand_text({delay = 0}, {mult = '+', StatusText = true})
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
						play_sound('tarot1')
						card:juice_up(0.8, 0.5)
						return true end }))
					update_hand_text({delay = 0}, {chips = '+', StatusText = true})
					G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
						play_sound('tarot1')
						card:juice_up(0.8, 0.5)
						G.TAROT_INTERRUPT_PULSE = nil
						return true end }))
					update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
					delay(1.3)
					G.GAME.akyrs_pure_hand_modifier.multiplier = G.GAME.akyrs_pure_hand_modifier.multiplier + card.ability.extra * 0.5 * G.GAME.akyrs_pure_hand_modifier.level
					G.GAME.akyrs_pure_hand_modifier.level = G.GAME.akyrs_pure_hand_modifier.level + card.ability.extra
					update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})


				else
					-- standard Planet card handling

					local upgradeHand = HangedMan.get_hand_in_game(fool_c.key) or nil
					if not upgradeHand then return false end

					SMODS.upgrade_poker_hands({ hands = {upgradeHand}})
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.4,
						func = function()
							card:juice_up(0.3, 0.5)
							play_sound('tarot1', 0.8, 0.4)
							return true
						end
					}))
				end

        		delay(0.6)

			end

        end

		-- juice card if Hanged Man is active
		if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES and fool_c and fool_c.key == 'c_hanged_man' end
            juice_card_until(card, eval, true)
        end

		-- additional checks for Death's effect
		if context.pre_discard and not context.blueprint and #context.full_hand == 2 then 
			local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
			if fool_c and fool_c.key == 'c_death' and #context.full_hand == 2 then
				card.ability.extra.deathActivating = false
				local rightmost = G.hand.highlighted[1]
        		for i = 1, #G.hand.highlighted do
					if G.hand.highlighted[i].T.x > rightmost.T.x then
    	            	rightmost = G.hand.highlighted[i]
        	    	end
            		local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            			G.E_MANAGER:add_event(Event({
            	    		trigger = 'immediate',
            	    		func = function()
            	        		G.hand.highlighted[i]:flip()
            	        		play_sound('card1', percent)
            	        		G.hand.highlighted[i]:juice_up(0.3, 0.3)
            	        	return true
                		end
	            	}))
					delay(0.2)
        		end
        		delay(0.6)

        		for i = 1, #G.hand.highlighted do
					if G.hand.highlighted[i] ~= rightmost then
                    	copy_card(rightmost, G.hand.highlighted[i])
                    end
	            	local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            		G.E_MANAGER:add_event(Event({
	                	trigger = 'immediate',
                		func = function()
	                    	G.hand.highlighted[i]:flip()
                    		play_sound('tarot2', percent, 0.6)
                    		G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    		return true
                		end
            		}))
					delay(0.2)
        		end
				delay(0.5)
			end
		end

		-- handles effects that activates on Discards
		if context.discard and not context.blueprint then

			local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
			if not fool_c then return false
			elseif fool_c and fool_c.key == 'c_hanged_man' and G.GAME.current_round.discards_used <= 0 then
				for i, v in ipairs(G.hand.highlighted) do
					if SMODS.shatters(v) then
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							func = function()
								v:shatter() 
								return true
							end
						}))
					else
						G.E_MANAGER:add_event(Event({
							trigger = 'immediate',
							func = function()
								v:start_dissolve()
								return true
							end
						}))
					end
					delay(0.3)
					return { remove = true, delay = 0.3 }
					
				end
			end
			
		end

	end,

	locked_loc_vars = function(self, info_queue, card)
		return {
			vars = {

			}
		}
	end,


	-- unlock function
	-- Foolish Joker : Use the Fool 10 times in a single run
	check_for_unlock = function(self, args)
		local unlockflag = false
        if args.type == 'unlock_foolishJoker' then
			local fools_used = 0
        	for k, v in pairs(G.GAME.consumeable_usage) do
            	if v.key == 'c_fool' then fools_used = fools_used + 1 end
        	end
			if fools_used >= 10 then 
				unlockflag = true
				print("[HangedMan_Unlock] The Fools tarot has been used 10 times - Foolish Joker unlocked!")
			end
        end
		if unlockflag then unlock_card(self) end
    end
}