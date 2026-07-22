SMODS.Joker {
	key = 'imposterous',
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
    allow_duplicates = true,
	no_mod_badges = true,
	config = { extra = { disguisingAs = nil, spriteX = 0, spriteY = 9,
                        purchased = false, failure = false, consequence = '',
                        xMult = 1,
                        evilYorickDiscard = 20,
                } },
	loc_vars = function(self, info_queue, card)

        local loc_ret = {}
        local loc_col = {HEX('FF00FF')}
        local loc_key = 'j_hangedman_imposterous'

        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) then _poker_hands[#_poker_hands + 1] = handname end
        end
        local random_hand = pseudorandom_element(_poker_hands, 'j_hangedman_imposterous')


        if not card.ability then
        elseif not card.ability.extra.consequence == '' then
            if card.ability.extra.consequence == 'halfFaceDown' then loc_ret = {''..(G.GAME and G.GAME.probabilities.normal or 1), 2}
            elseif card.ability.extra.consequence == 'xmultDecrease' then loc_ret = {card.ability.extra.xMult}
            elseif card.ability.extra.consequence == 'evilYorick' then loc_ret = {card.ability.extra.evilYorickDiscard}
            end
        elseif not card.ability.extra.disguisingAs then
		elseif card.ability.extra.disguisingAs == 'j_joker' then loc_ret = {4}
		elseif card.ability.extra.disguisingAs == 'j_greedy_joker' then loc_ret = {3, 'Diamond'}
		elseif card.ability.extra.disguisingAs == 'j_lusty_joker' then loc_ret = {3, 'Heart'}
		elseif card.ability.extra.disguisingAs == 'j_wrathful_joker' then loc_ret = {3, 'Spade'}
		elseif card.ability.extra.disguisingAs == 'j_gluttenous_joker' then loc_ret = {3, 'Club'}
		elseif card.ability.extra.disguisingAs == 'j_jolly' then loc_ret = {8, 'Pair'}
		elseif card.ability.extra.disguisingAs == 'j_zany' then loc_ret = {12, 'Three of a Kind'}
		elseif card.ability.extra.disguisingAs == 'j_mad' then loc_ret = {10, 'Two Pair'}
		elseif card.ability.extra.disguisingAs == 'j_crazy' then loc_ret = {12, 'Straight'}
		elseif card.ability.extra.disguisingAs == 'j_droll' then loc_ret = {10, 'Flush'}
		elseif card.ability.extra.disguisingAs == 'j_sly' then loc_ret = {50, 'Pair'}
		elseif card.ability.extra.disguisingAs == 'j_wily' then loc_ret = {100, 'Three of a Kind'}
		elseif card.ability.extra.disguisingAs == 'j_clever' then loc_ret = {80, 'Two Pair'}
		elseif card.ability.extra.disguisingAs == 'j_devious' then loc_ret = {100, 'Straight'}
		elseif card.ability.extra.disguisingAs == 'j_crafty' then loc_ret = {80, 'Flush'}
		elseif card.ability.extra.disguisingAs == 'j_half' then loc_ret = {20, 3}
		elseif card.ability.extra.disguisingAs == 'j_stencil' then loc_ret = {G.jokers and math.max(1, (G.jokers.config.card_limit - #G.jokers.cards) + #SMODS.find_card("j_stencil", true)) or 1}
		elseif card.ability.extra.disguisingAs == 'j_four_fingers' then
        elseif card.ability.extra.disguisingAs == 'j_mime' then
        elseif card.ability.extra.disguisingAs == 'j_credit_card' then loc_ret = {20}
        elseif card.ability.extra.disguisingAs == 'j_ceremonial' then loc_ret = {0}
        elseif card.ability.extra.disguisingAs == 'j_banner' then loc_ret = {30}
        elseif card.ability.extra.disguisingAs == 'j_mystic_summit' then loc_ret = {15,0}
        elseif card.ability.extra.disguisingAs == 'j_marble' then info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        elseif card.ability.extra.disguisingAs == 'j_loyalty_card' then loc_ret = {4, 6, '5 remaining'}
        elseif card.ability.extra.disguisingAs == 'j_8_ball' then loc_ret = {''..(G.GAME and G.GAME.probabilities.normal or 1), 4}
        elseif card.ability.extra.disguisingAs == 'j_misprint' then
            local r_mults = {}
            for i = 0, 23 do
                r_mults[#r_mults + 1] = tostring(i)
            end
            local loc_mult = ' ' .. (localize('k_mult')) .. ' '
            local main_start = {
                { n = G.UIT.T, config = { text = '  +', colour = G.C.MULT, scale = 0.32 } },
                { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.RED }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = {
                                { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
                                loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                                loc_mult, loc_mult, loc_mult, loc_mult },
                            colours = { G.C.UI.TEXT_DARK },
                            pop_in_rate = 9999999,
                            silent = true,
                            random_element = true,
                            pop_delay = 0.2011,
                            scale = 0.32,
                            min_cycle_time = 0
                        })
                    }
                },
            }
            return { key = 'j_misprint', main_start = main_start }
        elseif card.ability.extra.disguisingAs == 'j_dusk' then
        elseif card.ability.extra.disguisingAs == 'j_raised_fist' then
        elseif card.ability.extra.disguisingAs == 'j_chaos' then loc_ret = {1}
        elseif card.ability.extra.disguisingAs == 'j_fibonacci' then loc_ret = {8}
        elseif card.ability.extra.disguisingAs == 'j_steel_joker' then
            local steel_tally = 0
            if G.playing_cards then
                for _, playing_card in ipairs(G.playing_cards) do
                    if SMODS.has_enhancement(playing_card, 'm_steel') then steel_tally = steel_tally + 1 end
                end
            end
            loc_ret = {0.2, 1 + 0.2*(steel_tally or 0)}
            info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        elseif card.ability.extra.disguisingAs == 'j_stone' then
            loc_ret = {25, 25*(self.ability.stone_tally or 0)}
            info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        elseif card.ability.extra.disguisingAs == 'j_scary_face' then loc_ret = {30}
        elseif card.ability.extra.disguisingAs == 'j_abstract' then loc_ret = {3, (G.jokers and G.jokers.cards and #G.jokers.cards or 0)*3}
        elseif card.ability.extra.disguisingAs == 'j_delayed_grat' then loc_ret = {2}
        elseif card.ability.extra.disguisingAs == 'j_hack' then
        elseif card.ability.extra.disguisingAs == 'j_pareidolia' then
        elseif card.ability.extra.disguisingAs == 'j_gros_michel' then loc_ret = {15, ''..(G.GAME and G.GAME.probabilities.normal or 1), 6}
        elseif card.ability.extra.disguisingAs == 'j_even_steven' then loc_ret = {4}
        elseif card.ability.extra.disguisingAs == 'j_odd_todd' then loc_ret = {31}
        elseif card.ability.extra.disguisingAs == 'j_scholar' then loc_ret = {20,4}
        elseif card.ability.extra.disguisingAs == 'j_business' then loc_ret = {''..(G.GAME and G.GAME.probabilities.normal or 1), 2}
        elseif card.ability.extra.disguisingAs == 'j_supernova' then
        elseif card.ability.extra.disguisingAs == 'j_ride_the_bus' then loc_ret = {1,0}
        elseif card.ability.extra.disguisingAs == 'j_space' then loc_ret = {''..(G.GAME and G.GAME.probabilities.normal or 1), 4}
        elseif card.ability.extra.disguisingAs == 'j_egg' then loc_ret = {3}
        elseif card.ability.extra.disguisingAs == 'j_burglar' then loc_ret = {3}
        elseif card.ability.extra.disguisingAs == 'j_blackboard' then loc_ret = {3, localize('Spades', 'suits_plural'), localize('Clubs', 'suits_plural')}
        elseif card.ability.extra.disguisingAs == 'j_runner' then loc_ret = {0,15}
        elseif card.ability.extra.disguisingAs == 'j_ice_cream' then loc_ret = {100,5}
        elseif card.ability.extra.disguisingAs == 'j_splash' then
        elseif card.ability.extra.disguisingAs == 'j_blue_joker' then loc_ret = {2, 2*((G.deck and G.deck.cards) and #G.deck.cards or 52)}
        elseif card.ability.extra.disguisingAs == 'j_sixth_sense' then
        elseif card.ability.extra.disguisingAs == 'j_constellation' then loc_ret = {0.1,1}
        elseif card.ability.extra.disguisingAs == 'j_hiker' then loc_ret = {5}
        elseif card.ability.extra.disguisingAs == 'j_faceless' then loc_ret = {5, 3}
        elseif card.ability.extra.disguisingAs == 'j_green_joker' then loc_ret = {1, 1, 0}
        elseif card.ability.extra.disguisingAs == 'j_superposition' then
        elseif card.ability.extra.disguisingAs == 'j_fortune_teller' then loc_ret = {1, (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0)}
        elseif card.ability.extra.disguisingAs == 'j_drunkard' then loc_ret = {1}
        elseif card.ability.extra.disguisingAs == 'j_oops' then
        elseif card.ability.extra.disguisingAs == 'j_juggler' then loc_ret = {1}
        elseif card.ability.extra.disguisingAs == 'j_golden' then loc_ret = {4}
        elseif card.ability.extra.disguisingAs == 'j_trousers' then loc_ret = {2, localize('Two Pair', 'poker_hands'), 0}
        elseif card.ability.extra.disguisingAs == 'j_dna' then loc_ret = {1}
        elseif card.ability.extra.disguisingAs == 'j_todo_list' then loc_ret = {4, localize(random_hand, 'poker_hands')}
        elseif card.ability.extra.disguisingAs == 'j_smeared' then
        elseif card.ability.extra.disguisingAs == 'j_blueprint' then
        elseif card.ability.extra.disguisingAs == 'j_cartomancer' then
        elseif card.ability.extra.disguisingAs == 'j_astronomer' then
        elseif card.ability.extra.disguisingAs == 'j_ticket' then
            loc_ret = {4}
            info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        elseif card.ability.extra.disguisingAs == 'j_mr_bones' then
        elseif card.ability.extra.disguisingAs == 'j_acrobat' then loc_ret = {3}
        elseif card.ability.extra.disguisingAs == 'j_sock_and_buskin' then
        elseif card.ability.extra.disguisingAs == 'j_swashbuckler' then
            local swash = 0
            for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
                if joker ~= card then
                    swash = swash + joker.sell_cost
                end
            end  
            loc_ret = {swash}
        elseif card.ability.extra.disguisingAs == 'j_troubadour' then loc_ret = {2, 1}
        elseif card.ability.extra.disguisingAs == 'j_certificate' then
        elseif card.ability.extra.disguisingAs == 'j_throwback' then loc_ret = {0.25, 1 + (G.GAME.skips * 0.25)}
        elseif card.ability.extra.disguisingAs == 'j_hanging_chad' then loc_ret = {2}
        elseif card.ability.extra.disguisingAs == 'j_rough_gem' then loc_ret = {1}
        elseif card.ability.extra.disguisingAs == 'j_bloodstone' then loc_ret = {''..(G.GAME and G.GAME.probabilities.normal or 1), 2, 1.5}
        elseif card.ability.extra.disguisingAs == 'j_arrowhead' then loc_ret = {50}
        elseif card.ability.extra.disguisingAs == 'j_onyx_agate' then loc_ret = {7}
        elseif card.ability.extra.disguisingAs == 'j_glass' then
            loc_ret = {0.75, 1}
            info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        elseif card.ability.extra.disguisingAs == 'j_ring_master' then
        elseif card.ability.extra.disguisingAs == 'j_flower_pot' then loc_ret = {3}
        elseif card.ability.extra.disguisingAs == 'j_wee' then loc_ret = {0, 8}
        elseif card.ability.extra.disguisingAs == 'j_merry_andy' then loc_ret = {3, -1}
        elseif card.ability.extra.disguisingAs == 'j_idol' then
            loc_col = {G.C.SUITS[G.GAME.current_round.idol_card.suit]}
            loc_ret = {2, localize(G.GAME.current_round.idol_card.rank, 'ranks'), localize(G.GAME.current_round.idol_card.suit, 'suits_plural'), colours = loc_col }
        elseif card.ability.extra.disguisingAs == 'j_seeing_double' then loc_ret = {2}
        elseif card.ability.extra.disguisingAs == 'j_matador' then loc_ret = {8}
        elseif card.ability.extra.disguisingAs == 'j_hit_the_road' then loc_ret = {0.5, 1}
        elseif card.ability.extra.disguisingAs == 'j_duo' then loc_ret = {2, localize('Pair', 'poker_hands')}
        elseif card.ability.extra.disguisingAs == 'j_trio' then loc_ret = {3, localize('Three of a Kind', 'poker_hands')}
        elseif card.ability.extra.disguisingAs == 'j_family' then loc_ret = {4, localize('Four of a Kind', 'poker_hands')}
        elseif card.ability.extra.disguisingAs == 'j_order' then loc_ret = {3, localize('Straight', 'poker_hands')}
        elseif card.ability.extra.disguisingAs == 'j_tribe' then loc_ret = {2, localize('Flush', 'poker_hands')}
        elseif card.ability.extra.disguisingAs == 'j_cavendish' then loc_ret = {3, ''..(G.GAME and G.GAME.probabilities.normal or 1), 1000}
        elseif card.ability.extra.disguisingAs == 'j_card_sharp' then loc_ret = {3}
        elseif card.ability.extra.disguisingAs == 'j_red_card' then loc_ret = {3, 0}
        elseif card.ability.extra.disguisingAs == 'j_madness' then loc_ret = {0.5, 1}
        elseif card.ability.extra.disguisingAs == 'j_square' then loc_ret = {0, 4}
        elseif card.ability.extra.disguisingAs == 'j_seance' then loc_ret = {localize('Straight Flush', 'poker_hands')}
        elseif card.ability.extra.disguisingAs == 'j_riff_raff' then loc_ret = {2}
        elseif card.ability.extra.disguisingAs == 'j_vampire' then loc_ret = {0.1, 1}
        elseif card.ability.extra.disguisingAs == 'j_shortcut' then
        elseif card.ability.extra.disguisingAs == 'j_hologram' then loc_ret = {0.25, 1}
        elseif card.ability.extra.disguisingAs == 'j_vagabond' then loc_ret = {4}
        elseif card.ability.extra.disguisingAs == 'j_baron' then loc_ret = {1.5}
        elseif card.ability.extra.disguisingAs == 'j_cloud_9' then
            local nine_tally = 0
            if G.playing_cards then
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:get_id() == 9 then nine_tally = nine_tally + 1 end
                end
            end 
            loc_ret = {1, 1*(nine_tally or 0)}
        elseif card.ability.extra.disguisingAs == 'j_rocket' then loc_ret = {1, 2}
        elseif card.ability.extra.disguisingAs == 'j_obelisk' then loc_ret = {0.2, 1}
        elseif card.ability.extra.disguisingAs == 'j_midas_mask' then info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        elseif card.ability.extra.disguisingAs == 'j_luchador' then
        elseif card.ability.extra.disguisingAs == 'j_photograph' then loc_ret = {2}
        elseif card.ability.extra.disguisingAs == 'j_gift' then  loc_ret = {1}
        elseif card.ability.extra.disguisingAs == 'j_turtle_bean' then loc_ret = {5, 1}
        elseif card.ability.extra.disguisingAs == 'j_erosion' then loc_ret = {4, math.max(0,4*(G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0)), G.GAME.starting_deck_size}
        elseif card.ability.extra.disguisingAs == 'j_reserved_parking' then loc_ret = {1, ''..(G.GAME and G.GAME.probabilities.normal or 1), 2}
        elseif card.ability.extra.disguisingAs == 'j_mail' then loc_ret = {5, localize(G.GAME.current_round.mail_card.rank, 'ranks')}
        elseif card.ability.extra.disguisingAs == 'j_to_the_moon' then loc_ret = {1}
        elseif card.ability.extra.disguisingAs == 'j_hallucination' then loc_ret = {''..(G.GAME and G.GAME.probabilities.normal or 1), 2}
        elseif card.ability.extra.disguisingAs == 'j_lucky_cat' then loc_ret = {0.25, 1}
        elseif card.ability.extra.disguisingAs == 'j_baseball' then loc_ret = {1.5}
        elseif card.ability.extra.disguisingAs == 'j_bull' then loc_ret = {2, 2*math.max(0,G.GAME.dollars) or 0}
        elseif card.ability.extra.disguisingAs == 'j_diet_cola' then
            info_queue[#info_queue + 1] = { key = 'tag_double', set = 'Tag' }
            loc_ret = {localize{type = 'name_text', set = 'Tag', key = 'tag_double', nodes = {}}}
        elseif card.ability.extra.disguisingAs == 'j_trading' then loc_ret = {3}
        elseif card.ability.extra.disguisingAs == 'j_flash' then loc_ret = {2, 0}
        elseif card.ability.extra.disguisingAs == 'j_popcorn' then loc_ret = {20, 4}
        elseif card.ability.extra.disguisingAs == 'j_ramen' then loc_ret = {2, 0.01}
        elseif card.ability.extra.disguisingAs == 'j_ancient' then
            loc_col = {G.C.SUITS[G.GAME.current_round.ancient_card.suit]}
            loc_ret = {1.5, localize(G.GAME.current_round.ancient_card.suit, 'suits_singular'), colours = loc_col }
        elseif card.ability.extra.disguisingAs == 'j_walkie_talkie' then loc_ret = {10, 4}
        elseif card.ability.extra.disguisingAs == 'j_selzer' then loc_ret = {10}
        elseif card.ability.extra.disguisingAs == 'j_castle' then
            loc_col = {G.C.SUITS[G.GAME.current_round.castle_card.suit]}
            loc_ret = {3, localize(G.GAME.current_round.castle_card.suit, 'suits_singular'), 0, colours = loc_col}
        elseif card.ability.extra.disguisingAs == 'j_smiley' then loc_ret = {5}
        elseif card.ability.extra.disguisingAs == 'j_campfire' then loc_ret = {0.25, 1}
        elseif card.ability.extra.disguisingAs == 'j_stuntman' then loc_ret = {250, 2}
        elseif card.ability.extra.disguisingAs == 'j_invisible' then loc_ret = {2, 0}
        elseif card.ability.extra.disguisingAs == 'j_brainstorm' then
        elseif card.ability.extra.disguisingAs == 'j_satellite' then
            local planets_used = 0
            for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then planets_used = planets_used + 1 end end
            loc_ret = {1, planets_used*1}
        elseif card.ability.extra.disguisingAs == 'j_shoot_the_moon' then loc_ret = {13}
        elseif card.ability.extra.disguisingAs == 'j_drivers_license' then
            local driver_tally = 0
            for _, playing_card in pairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(playing_card)) then driver_tally = driver_tally + 1 end
            end
            loc_ret = {3, driver_tally or '0'}
        elseif card.ability.extra.disguisingAs == 'j_burnt' then
        elseif card.ability.extra.disguisingAs == 'j_bootstraps' then loc_ret = {2, 5, 2*math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/5)}
        elseif card.ability.extra.disguisingAs == 'j_caino' then loc_ret = {1, 1}
        elseif card.ability.extra.disguisingAs == 'j_triboulet' then loc_ret = {2}
        elseif card.ability.extra.disguisingAs == 'j_yorick' then loc_ret = {1, 23, 23, 1}
        elseif card.ability.extra.disguisingAs == 'j_chicot' then
        elseif card.ability.extra.disguisingAs == 'j_perkeo' then
            loc_ret = {1}
            info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        end

        

        if card.ability.extra.failure then loc_key = 'j_hangedman_imposterous_' .. card.ability.extra.consequence 
        elseif card.ability.extra.disguisingAs then loc_key = card.ability.extra.disguisingAs
        end

        return { key = loc_key,
				vars = loc_ret,
        }


        

	end,
	rarity = 2,
	atlas = 'HangedMan_imposterousJokers',
	pos = { x = 0, y = 9 },
	cost = 4,
    attributes = {'ktane','mult','chips','xmult','economy','generation','rank','suit','hand_type','hand_size','scaling','face','destroy_card','hands','discard','hand_size','joker','tarot','planet','spectral','tag','skip','modify_card','perma_bonus','reroll','enhancements'},

    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.extra.purchased = true
        end
    end,

	calculate = function(self, card, context)
		-- nothing yet just getting the everything else to work first


        if context.selling_self and not context.blueprint and not card.ability.extra.failure then
            
            local rewardKeys =
            {
                'gainTwoHandSize',
                'gainDiscard',
                'gainHand',
                'gainMoney',
                'randomRareJoker',
                'upgradeAllHands',
                'becomeReal',
                'fillUpConsumable',
                'deflation',
                'freeReroll',
                'overstock',
                'morebooster',
                'morevoucher'
            }

            local picked = false
            local reward = pseudorandom_element(rewardKeys, pseudoseed('j_hangedman_imposterous'))
            while not picked do
                if reward == 'fillUpConsumable' and G.consumeables.config.card_limit == #G.consumeables.cards + G.GAME.consumeable_buffer then
                    reward = pseudorandom_element(rewardKeys, pseudoseed('j_hangedman_imposterous'))
                else picked = true
                end
            end


            

            if reward == 'gainTwoHandSize' then
                G.hand:change_size(2)
            elseif reward == 'gainDiscard' then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 2
                ease_discard(2)
            elseif reward == 'gainHand' then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2
                ease_hands_played(2)
            elseif reward == 'gainMoney' then
                local possiblemoney = {5,7,10,10,12,12,13,13,15,15,17,20,21,22,25}
                ease_dollars(pseudorandom_element(possiblemoney, pseudoseed('j_hangedman_imposterous')))
            elseif reward == 'randomRareJoker' then
                SMODS.add_card({set = 'Joker', rarity = 'Rare', stickers = {""}})
            elseif reward == 'upgradeAllHands' then
                local handNames = {
                'High Card',
                'Pair',
                'Two Pair',
                'Three of a Kind',
                'Straight',
                'Flush',
                'Full House',
                'Four of a Kind',
                'Straight Flush',
                'Five of a Kind',
                'Flush House',
                'Flush Five'
    		    }

                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = 'All hands', chips = '...', mult = '...', level = '' })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = true
                        return true
                    end
                }))
                update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        return true
                    end
                }))
                update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = nil
                        return true
                    end
                }))
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '1' })
                delay(1.3)

                SMODS.upgrade_poker_hands({ hands = handNames, instant = true, from = card, level_up = 1 })


                update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                { mult = 0, chips = 0, handname = '', level = '' })
            elseif reward == 'becomeReal' then
                local key = card.ability.extra.disguisingAs
                SMODS.add_card({set = 'Joker', key = key, stickers = {""}})
            elseif reward == 'fillUpConsumable' then

                local spawnType = pseudorandom_element({'Tarot','Planet','Spectral'}, pseudoseed('j_hangedman_imposterous'))
                local count = G.consumeables.config.card_limit - #G.consumeables.cards + G.GAME.consumeable_buffer

                for i = 1, count, 1 do
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {set = spawnType}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))  
                end
            elseif reward == 'deflation' then G.GAME.inflation = (G.GAME.inflation or 0) - 1
            elseif reward == 'freeReroll' then SMODS.change_free_rerolls(1)
            elseif reward == 'overstock' then change_shop_size(1)
            elseif reward == 'morebooster' then SMODS.change_booster_limit(1)
            elseif reward == 'morevoucher' then SMODS.change_voucher_limit(1)
            end

            return {message = 'ELIMINATED', colour = HEX('FF00FF')}

        end








        if context.joker_main and card.ability.extra.purchased and not card.ability.extra.failure and not context.blueprint then

            local consequenceKeys = 
            {
                'halfFaceDown',
                'loseTwoHandSize',
                'loseDiscard',
                'loseHand',
                'voidDagger',
                'xmultDecrease',
                'loseMoneyOnDiscard',
                'loseMoneyPerCard',
                'pairOfEggs',
                'pairOfCards',
                'downgradeAllHand',
                'loseMoney',
                'evilYorick',
                'inflation',
                'expensiveReroll',
                'debuffFace',
                'debuffClubs',
                'debuffHearts',
                'debuffSpades',
                'debuffDiamonds',
                'fewerBoosters',
                'increaseCurrentBlindRequirement',
                'increaseBlindScaling'
            }
            card.ability.extra.consequence = pseudorandom_element(consequenceKeys, pseudoseed('j_hangedman_imposterous'))

            card.ability.extra.failure = true
            card.ability.extra.spriteX = 0
            card.ability.extra.spriteY = 9

            G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up()
                card.children.center:set_sprite_pos({x = card.ability.extra.spriteX, y = card.ability.extra.spriteY})
                imposterous_consequences(card)
                return true
            end
            }))
            return {message = 'FAILURE TO ELIMINATE', colour = HEX('FF00FF')}
        end

        if context.joker_main and card.ability.extra.failure and not context.blueprint then
            if card.ability.extra.consequence == 'xmultDecrease' then return {Xmult = card.ability.extra.xMult}
            end
           
        end

        if context.stay_flipped and context.to_area == G.hand and SMODS.pseudorandom_probability(card, 'j_hangedman_imposterous', 1, 2) and card.ability.extra.consequence == 'halfFaceDown' then 
			return {stay_flipped = true}
        end

		if context.setting_blind and not context.blueprint then

            if card.ability.extra.consequence == 'voidDagger' then
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        my_pos = i
                        break
                    end
                end
                if my_pos and G.jokers.cards[my_pos + 1] and not SMODS.is_eternal(G.jokers.cards[my_pos + 1], card) and not G.jokers.cards[my_pos + 1].getting_sliced then
                    local sliced_card = G.jokers.cards[my_pos + 1]
                    sliced_card.getting_sliced = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.joker_buffer = 0
                            card:juice_up(0.8, 0.8)
                            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                            play_sound('slice1', 0.96 + math.random() * 0.08)
                            return true
                        end
                    }))
                    return {
                        message = 'SLICED',
                        colour = HEX('FF00FF'),
                        no_juice = true
                    }
                end
            end
        end

        if context.debuff_card and context.debuff_card.area == G.hand then
            local debuffing = false
            if card.ability.extra.consequence == 'debuffFace' and context.debuff_card:is_face() then debuffing = true
            elseif card.ability.extra.consequence == 'debuffClubs' and context.debuff_card:is_suit('Clubs') then debuffing = true
            elseif card.ability.extra.consequence == 'debuffHearts' and context.debuff_card:is_suit('Hearts') then debuffing = true
            elseif card.ability.extra.consequence == 'debuffSpadess' and context.debuff_card:is_suit('Spades') then debuffing = true
            elseif card.ability.extra.consequence == 'debuffDiamonds' and context.debuff_card:is_suit('Diamonds') then debuffing = true
            end
            --if G.playing_cards then for k, v in pairs(G.playing_cards) do SMODS.recalc_debuff(v) end end
            return {debuff = debuffing}
        end

        if context.hand_drawn then
            if G.playing_cards then for k, v in pairs(G.playing_cards) do SMODS.recalc_debuff(v) end end
        end
        

        if context.discard and not context.blueprint then

            if card.ability.extra.consequence == 'loseMoneyOnDiscard' then
                for i, v in ipairs(G.hand.highlighted) do
				return {
					dollars = -1,
				}
			    end
            end


            if card.ability.extra.consequence == 'evilYorick' then
                for i, v in ipairs(G.hand.highlighted) do
                    if card.ability.extra.evilYorickDiscard == 1 then
                        G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
                        ease_discard(-1)
                        card.ability.extra.evilYorickDiscard = 20
                        if G.GAME.round_resets.discards == 0 then
                            card:set_eternal(false)
                            SMODS.destroy_cards(card, nil, nil, true)
                            return {
					            message = 'DEPLETED',
                                colour = HEX('FF00FF'),
                                no_juice = true
				            }
                        else
                            return {
					            message = '-1 DISCARD',
                                colour = HEX('FF00FF'),
                                no_juice = true
				            }
                        end
                    else
                        card.ability.extra.evilYorickDiscard = card.ability.extra.evilYorickDiscard - 1
                        return {
					        message = ''..card.ability.extra.evilYorickDiscard,
                            colour = HEX('FF00FF'),
                            no_juice = true
				        }
                    end
			    end
            end
		end

        if context.individual and not context.blueprint then
            
            if card.ability.extra.consequence == 'loseMoneyPerCard' and context.cardarea == G.play then
                return {
					dollars = -1,
				}
            end

        end


        function imposterous_consequences(card)
            local eternal_flag = true
            if card.ability.extra.consequence == 'loseTwoHandSize' then
                eternal_flag = false
                G.hand:change_size(-2)
            elseif card.ability.extra.consequence == 'loseDiscard' then
                eternal_flag = false
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - 2
                ease_discard(-2)
            elseif card.ability.extra.consequence == 'loseHand' then
                eternal_flag = false
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - 2
                ease_hands_played(-2)
            elseif card.ability.extra.consequence == 'xmultDecrease' then
                local possiblexmult = {0.99,0.95,0.9,0.85,0.85,0.8,0.8,0.75,0.75,0.7,0.7,0.65,0.6,0.55,0.5}
                card.ability.extra.xMult = pseudorandom_element(possiblexmult, pseudoseed('j_hangedman_imposterous'))
            elseif card.ability.extra.consequence == 'pairOfEggs' then
                eternal_flag = false
                SMODS.add_card({set = 'Joker', key = 'j_egg', stickers = {"eternal"}, force_stickers = true, no_edition = true})
                SMODS.add_card({set = 'Joker', key = 'j_egg', stickers = {"eternal"}, force_stickers = true, no_edition = true})
             elseif card.ability.extra.consequence == 'pairOfCards' then
                eternal_flag = false
                SMODS.add_card({set = 'Joker', key = 'j_credit_card', stickers = {"eternal"}, force_stickers = true, no_edition = true})
                SMODS.add_card({set = 'Joker', key = 'j_credit_card', stickers = {"eternal"}, force_stickers = true, no_edition = true})
            elseif card.ability.extra.consequence == 'downgradeAllHand' then
                eternal_flag = false
                local handNames = {
                'High Card',
                'Pair',
                'Two Pair',
                'Three of a Kind',
                'Straight',
                'Flush',
                'Full House',
                'Four of a Kind',
                'Straight Flush',
                'Five of a Kind',
                'Flush House',
                'Flush Five'
    		    }

                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = 'All hands', chips = '...', mult = '...', level = '' })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = true
                        return true
                    end
                }))
                update_hand_text({ delay = 0 }, { mult = '-', StatusText = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        return true
                    end
                }))
                update_hand_text({ delay = 0 }, { chips = '-', StatusText = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = nil
                        return true
                    end
                }))
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '-1' })
                delay(1.3)

                SMODS.upgrade_poker_hands({ hands = handNames, instant = true, from = card, level_up = -1 })


                update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                { mult = 0, chips = 0, handname = '', level = '' })
            elseif card.ability.extra.consequence == 'loseMoney' then
                local possiblemoney = {-10,-10,-12,-12,-15,-15,-18,-18,-20,-20,-22,-22,-25,-30,-45}
                ease_dollars(pseudorandom_element(possiblemoney, pseudoseed('j_hangedman_imposterous')))
                eternal_flag = false
            elseif card.ability.extra.consequence == 'inflation' then
                G.GAME.inflation = (G.GAME.inflation or 0) + 1
                eternal_flag = false
            elseif card.ability.extra.consequence == 'expensiveReroll' then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 1
                        G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + 1)
                        return true
                    end
                }))
            elseif card.ability.extra.consequence == 'fewerBoosters' then
                SMODS.change_booster_limit(-1)
                eternal_flag = false
            elseif card.ability.extra.consequence == 'increaseCurrentBlindRequirement' then
                local possibleincrement = {0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.75, 0.75, 1, 1.25}
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips + (G.GAME.blind.chips * pseudorandom_element(possibleincrement, pseudoseed('j_hangedman_imposterous'))))
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                eternal_flag = false
            elseif card.ability.extra.consequence == 'increaseBlindScaling' then
                G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
                eternal_flag = false
            end

            if eternal_flag then card:set_eternal(eternal_flag) else SMODS.destroy_cards(card, nil, nil, true) end
        end

	end,

	set_sprites = function(self, card, front)
		G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                if card.ability and card.ability.extra.disguisingAs then card.children.center:set_sprite_pos({x = card.ability.extra.spriteX, y = card.ability.extra.spriteY}) end 
                return true
            end
        }))
	end,

    set_card_type_badge = function(self, card, badges)

        if not card.ability then
        elseif card.ability and not card.ability.extra.disguisingAs and not card.ability.extra.failure then
            badges[#badges+1] = create_badge(localize('k_uncommon'), G.C.RARITY[2], G.C.WHITE, 1.2)
            badges[#badges+1] = create_badge('Hanged Man', HEX('A58544'))
        elseif card.ability and card.ability.extra.failure then
            badges[#badges+1] = create_badge('IMPOSTEROUS', HEX('FF00FF'), G.C.BLACK, 1.1)
            badges[#badges+1] = create_badge('Hanged Man', HEX('A58544'))
        elseif card.ability and card.ability.extra.disguisingAs then 
            badges[#badges+1] = create_badge(({localize('k_common'), localize('k_uncommon'), localize('k_rare'), localize('k_legendary')})[G.P_CENTERS[card.ability.extra.disguisingAs].rarity], G.C.RARITY[G.P_CENTERS[card.ability.extra.disguisingAs].rarity], G.C.WHITE, 1.2)
        end 
        return true

    end,

    in_pool = function(self, args)
        return true
    end

}

local smods_cc = SMODS.create_card
function SMODS.create_card(args)
    local card = smods_cc(args)
    --if card.config.center_key == "j_hangedman_imposterous" and args.key_append == "sho" then
    if card.config.center_key == "j_hangedman_imposterous" and card.ability then    
		local pool = get_current_pool('vanilla')
		local selected_key = pseudorandom_element(pool, 'j_hangedman_imposterous')
		local it = 1
		while selected_key == 'UNAVAILABLE' or
            selected_key == 'j_caino' or
            selected_key == 'j_triboulet' or 
            selected_key == 'j_yorick' or
            selected_key == 'j_chicot' or 
            selected_key == 'j_perkeo' do
    		it = it + 1
    		selected_key = pseudorandom_element(pool, 'j_hangedman_imposterous_resample'..it)
		end

		if card.ability then
			card.ability.extra.disguisingAs = selected_key
			card.ability.extra.spriteX = G.P_CENTERS[card.ability.extra.disguisingAs].pos.x
			card.ability.extra.spriteY = G.P_CENTERS[card.ability.extra.disguisingAs].pos.y
            card.cost = G.P_CENTERS[card.ability.extra.disguisingAs].cost
            card.rarity = G.P_CENTERS[card.ability.extra.disguisingAs].rarity
			card.children.center:set_sprite_pos({x = card.ability.extra.spriteX, y = card.ability.extra.spriteY})
		end

    end
    return card
end


