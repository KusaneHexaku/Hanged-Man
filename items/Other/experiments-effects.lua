HangedMan.experiments_effects = {

['multScale1'] = {
    key = 'multScale1',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'1', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.mult = card.ability.extra.mult + 1
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 3)
    end,
},

['multScale2'] = {
    key = 'multScale2',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'2', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.mult = card.ability.extra.mult + 2
    end,
    available = function(card)
        return true
    end,
},

['multScale3'] = {
    key = 'multScale3',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'3', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.mult = card.ability.extra.mult + 3
    end,
    available = function(card)
        return true
    end,
},

['multScale5'] = {
    key = 'multScale5',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'5', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.mult = card.ability.extra.mult + 5
    end,
    available = function(card)
        return true
    end,
},

['chipScale5'] = {
    key = 'chipScale5',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'by ', G.C.UI.TEXT_DARK}, {'5', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.chip = card.ability.extra.chip + 5
    end,
    available = function(card)
        return true
    end,
},

['chipScale10'] = {
    key = 'chipScale10',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'by ', G.C.UI.TEXT_DARK}, {'10', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.chip = card.ability.extra.chip + 10
    end,
    available = function(card)
        return true
    end,
},

['chipScale15'] = {
    key = 'chipScale15',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'by ', G.C.UI.TEXT_DARK}, {'15', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.chip = card.ability.extra.chip + 15
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 2)
    end,
},

['chipScale25'] = {
    key = 'chipScale25',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'by ', G.C.UI.TEXT_DARK}, {'25', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.chip = card.ability.extra.chip + 25
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 3)
    end,
},

['xmultScale0.05'] = {
    key = 'xmultScale0.05',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'XMult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'0.05', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.xmult = card.ability.extra.xmult + 0.05
    end,
    available = function(card)
        return true
    end,
},

['xmultScale0.1'] = {
    key = 'xmultScale0.1',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'XMult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'0.1', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.xmult = card.ability.extra.xmult + 0.1
    end,
    available = function(card)
        return true
    end,
},

['xmultScale0.2'] = {
    key = 'xmultScale0.2',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'XMult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'0.2', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.xmult = card.ability.extra.xmult + 0.2
    end,
    available = function(card)
        return true
    end,
},

['xmultScale0.25'] = {
    key = 'xmultScale0.25',
    textbit = {
        {'increase this card\'s ', G.C.UI.TEXT_DARK}, {'XMult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'0.25', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.xmult = card.ability.extra.xmult + 0.25
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 2)
    end,
},

['randomTarot'] = {
    key = 'randomTarot',
    textbit = {
        {'spawn a random ', G.C.UI.TEXT_DARK}, {'Tarot ', G.C.SECONDARY_SET.Tarot}, {'card ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}
    },
    effect = function (card, context)
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
    end,
    available = function(card)
        return true
    end,
},

['randomPlanet'] = {
    key = 'randomPlanet',
    textbit = {
        {'spawn a random ', G.C.UI.TEXT_DARK}, {'Planet ', G.C.SECONDARY_SET.Planet}, {'card ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}
    },
    effect = function (card, context)
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
            func = (function()
                SMODS.add_card {set = 'Planet'}
                G.GAME.consumeable_buffer = 0
                play_sound('timpani')
                return true
            end)
            }))
        end
    end,
    available = function(card)
        return true
    end,
},

['1Gold'] = {
    key = '1Gold',
    textbit = {
        {'gain ', G.C.UI.TEXT_DARK}, {'$1', G.C.MONEY}
    },
    effect = function (card, context)
        ease_dollars(1)
    end,
    available = function(card)
        return true
    end,
},

['2Gold'] = {
    key = '2Gold',
    textbit = {
        {'gain ', G.C.UI.TEXT_DARK}, {'$2', G.C.MONEY}
    },
    effect = function (card, context)
        ease_dollars(2)
    end,
    available = function(card)
        return true
    end,
},

['3Gold'] = {
    key = '3Gold',
    textbit = {
        {'gain ', G.C.UI.TEXT_DARK}, {'$3', G.C.MONEY}
    },
    effect = function (card, context)
        ease_dollars(3)
    end,
    available = function(card)
        return true
    end,
},

['5Gold'] = {
    key = '5Gold',
    textbit = {
        {'gain ', G.C.UI.TEXT_DARK}, {'$5', G.C.MONEY}
    },
    effect = function (card, context)
        ease_dollars(5)
    end,
    available = function(card)
        return SMODS.pseudorandom_probability(card, 'experiments_weight_chance', 1, 2)
    end,
},

['endRoundGoldScale1'] = {
    key = 'endRoundGoldScale1',
    textbit = {
        {'increase end of Blind bonus by ', G.C.UI.TEXT_DARK}, {'$1', G.C.MONEY}
    },
    effect = function (card, context)
        card.ability.extra.goldEnd = card.ability.extra.goldEnd + 1
    end,
    available = function(card)
        return true
    end,
},

['endRoundGoldScale2'] = {
    key = 'endRoundGoldScale2',
    textbit = {
        {'increase end of Blind bonus by ', G.C.UI.TEXT_DARK}, {'$2', G.C.MONEY}
    },
    effect = function (card, context)
        card.ability.extra.goldEnd = card.ability.extra.goldEnd + 2
    end,
    available = function(card)
        return true
    end,
},

['randomFoodJoker'] = {
    key = 'randomFoodJoker',
    textbit = {
        {'spawn a random ', G.C.UI.TEXT_DARK}, {'Food ', G.C.FILTER}, {'Joker ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}
    },
    effect = function (card, context)
        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local foodJokerPool = {'j_cavendish','j_gros_michel','j_egg','j_ice_cream','j_turtle_bean','j_diet_cola','j_popcorn','j_ramen','j_selzer','j_gros_michel','j_egg','j_ice_cream','j_turtle_bean','j_diet_cola','j_popcorn','j_ramen','j_selzer','j_gros_michel','j_egg','j_ice_cream','j_turtle_bean','j_diet_cola','j_popcorn','j_ramen','j_selzer'}
            pseudoshuffle(foodJokerPool, "hangedMan_experiment_shuffle")
            local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card{ key = foodJokerPool[1] }
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
        end
    end,
    available = function(card)
        return true
    end,
},

['randomChipJoker'] = {
    key = 'randomChipJoker',
    textbit = {
        {'spawn a random ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'Joker ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}
    },
    effect = function (card, context)
        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local chipJokerPool = {'j_arrowhead','j_banner','j_blue_joker','j_bull','j_castle','j_clever','j_crafty','j_devious','j_hiker','j_ice_cream','j_odd_todd','j_runner','j_scary_face','j_sly','j_square_joker','j_stone','j_stuntman','j_wee','j_wily'}
            pseudoshuffle(chipJokerPool, "hangedMan_experiment_shuffle")
            local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card{ key = chipJokerPool[1] }
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
        end
    end,
    available = function(card)
        return true
    end,
},

['spawnOops'] = {
    key = 'spawnOops',
    textbit = {
        {'spawn an ', G.C.UI.TEXT_DARK}, {'Oops! All 6s ', G.C.GREEN}, {'Joker ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}
    },
    effect = function (card, context)
        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card{ key = "j_oops" }
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
        end
    end,
    available = function(card)
        return true
    end,
},

['topUpTag'] = {
    key = 'topUpTag',
    textbit = {
       {'spawn a ', G.C.UI.TEXT_DARK}, {'Top-Up ', G.C.FILTER}, {'tag', G.C.UI.TEXT_DARK}
    },
    effect = function (card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_top_up'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
    available = function(card)
        return true
    end,
},

['doubleTag'] = {
    key = 'doubleTag',
    textbit = {
       {'spawn a ', G.C.UI.TEXT_DARK}, {'Double ', G.C.FILTER}, {'tag', G.C.UI.TEXT_DARK}
    },
    effect = function (card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_double'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
    available = function(card)
        return true
    end,
},

['couponTag'] = {
    key = 'couponTag',
    textbit = {
       {'spawn a ', G.C.UI.TEXT_DARK}, {'Coupon ', G.C.FILTER}, {'tag', G.C.UI.TEXT_DARK}
    },
    effect = function (card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_coupon'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
    available = function(card)
        return true
    end,
},

['d6Tag'] = {
    key = 'd6Tag',
    textbit = {
       {'spawn a ', G.C.UI.TEXT_DARK}, {'D6 ', G.C.GREEN}, {'tag', G.C.UI.TEXT_DARK}
    },
    effect = function (card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_d_six'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
    available = function(card)
        return true
    end,
},

['investTag'] = {
    key = 'investTag',
    textbit = {
       {'spawn an ', G.C.UI.TEXT_DARK}, {'Investment ', G.C.MONEY}, {'tag', G.C.UI.TEXT_DARK}
    },
    effect = function (card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_investment'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
    available = function(card)
        return true
    end,
},

['resetMoneySpawnRare'] = {
    key = 'resetMoneySpawnRare',
    textbit = {
       {'lose ', G.C.UI.TEXT_DARK}, {'all of ', G.C.RED}, {'your current money and spawn ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random ', G.C.UI.TEXT_DARK}, {'Rare ', G.C.RARITY.Rare}, {'Joker ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}
    },
    effect = function (card, context)
        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Rare',
                            key_append = 'experiments'
                        }
                        play_sound('timpani')
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
        end
        ease_dollars(-G.GAME.dollars, true)
    end,
    available = function(card)
        return true
    end,
},

['halfMoneySpawnUncommon'] = {
    key = 'halfMoneySpawnUncommon',
    textbit = {
       {'lose ', G.C.UI.TEXT_DARK}, {'half of ', G.C.RED}, {'your current money and spawn up to ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'random ', G.C.UI.TEXT_DARK}, {'Uncommon ', G.C.RARITY.Uncommon}, {'Jokers ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}
    },
    effect = function (card, context)
        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(2, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Uncommon',
                            key_append = 'experiments'
                        }
                        play_sound('timpani')
                    end
                    G.GAME.joker_buffer = 0 
                return true
                end
            }))
        end
        ease_dollars(-math.floor(G.GAME.dollars/2), true)
    end,
    available = function(card)
        return true
    end,
},

['nextHandIncrement'] = {
    key = 'nextHandIncrement',
    textbit = {
       {'increase ', G.C.UI.TEXT_DARK}, {'rank ', G.C.FILTER}, {'of all scored cards in next hand by ', G.C.UI.TEXT_DARK}, {'1', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.flag_incrementHand = card.ability.extra.flag_incrementHand + 1
        local eval = function(card) return card.ability.extra.flag_incrementHand > 1 and not G.RESET_JIGGLES end
        juice_card_until(card, eval, true)
    end,
    after_effect = function (card, context)
        if context.joker_main and card.ability.extra.flag_incrementHand > 0 then

            for _, cardPlayed in ipairs(context.scoring_hand) do
                if SMODS.has_no_rank(cardPlayed) then
                elseif cardPlayed:get_id() == 14 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            assert(SMODS.modify_rank(cardPlayed, -12))
                            card:Playedjuice_up()
                            play_sound('tarot1', 0.8, 0.4)
                            return true
                        end
                    }))
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            assert(SMODS.modify_rank(cardPlayed, 1))
                            cardPlayed:juice_up()
                            play_sound('tarot1', 0.8, 0.4)
                            return true
                        end
                    }))
                end
            end

            card.ability.extra.flag_incrementHand = math.max(card.ability.extra.flag_incrementHand - 1, 0)

        end
    end,
    available = function(card)
        return true
    end,
},

['convergeSuit'] = {
    key = 'convergeSuit',
    textbit = {
       {'convert all ', G.C.UI.TEXT_DARK}, {'scored cards ', G.C.FILTER}, {'in next hand to a single random ', G.C.UI.TEXT_DARK}, {'suit', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.flag_convergeSuit = card.ability.extra.flag_convergeSuit + 1
        local eval = function(card) return card.ability.extra.flag_convergeSuit > 1 and not G.RESET_JIGGLES end
        juice_card_until(card, eval, true)
    end,
    after_effect = function (card, context)
        if context.joker_main and card.ability.extra.flag_convergeSuit > 0 then

            local suits = {'Clubs','Hearts','Spades','Diamonds'}
			local singlesuit = pseudorandom_element(suits, pseudoseed('experiments'))
            for _, cardPlayed in ipairs(context.scoring_hand) do
                if SMODS.has_no_suit(cardPlayed) then
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            cardPlayed:change_suit(singlesuit)
                            cardPlayed:juice_up()
                            play_sound('tarot1', 0.8, 0.4)
                            return true
                        end
					}))
                end
            end

           card.ability.extra.flag_convergeSuit = math.max(card.ability.extra.flag_convergeSuit - 1, 0)

        end
    end,
    available = function(card)
        return true
    end,
},

['randomSuit'] = {
    key = 'randomSuit',
    textbit = {
       {'convert each ', G.C.UI.TEXT_DARK}, {'scored cards ', G.C.FILTER}, {'in next hand to a random ', G.C.UI.TEXT_DARK}, {'suit', G.C.FILTER}
    },
    effect = function (card, context)
        card.ability.extra.flag_randomSuit = card.ability.extra.flag_randomSuit + 1
        local eval = function(card) return card.ability.extra.flag_randomSuit > 1 and not G.RESET_JIGGLES end
        juice_card_until(card, eval, true)
    end,
    after_effect = function (card, context)
        if context.joker_main and card.ability.extra.flag_randomSuit > 0 then
            
            local suits = {'Clubs','Hearts','Spades','Diamonds'}
            for _, cardPlayed in ipairs(context.scoring_hand) do
                if SMODS.has_no_suit(cardPlayed) then
                else
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            cardPlayed:change_suit(pseudorandom_element(suits, pseudoseed('experiments')))
                            cardPlayed:juice_up()
                            play_sound('tarot1', 0.8, 0.4)
                            return true
                        end
                    }))
                end
            end

           card.ability.extra.flag_randomSuit = math.max(card.ability.extra.flag_randomSuit - 1, 0)

        end
    end,
    available = function(card)
        return true
    end,
},

['freeReroll'] = {
    key = 'freeReroll',
    textbit = {
       {'lose ', G.C.UI.TEXT_DARK}, {'$10 ', G.C.MONEY}, {'and gain ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'permanent free ', G.C.UI.TEXT_DARK}, {'shop reroll ', G.C.GREEN}
    },
    effect = function (card, context)
        SMODS.change_free_rerolls(1)
		ease_dollars(-10)
    end,
    available = function(card)
        return true
    end,
},

['moreBooster'] = {
    key = 'moreBooster',
    textbit = {
       {'permanently add 1 ', G.C.UI.TEXT_DARK}, {'Booster Pack', G.C.FILTER}, {'to each shop ', G.C.UI.TEXT_DARK}
    },
    effect = function (card, context)
        SMODS.change_booster_limit(1)
    end,
    available = function(card)
        return true
    end,
},

['threeOfClubsFlood'] = {
    key = 'threeOfClubsFlood',
    textbit = {
       {'add ', G.C.UI.TEXT_DARK}, {'16', G.C.FILTER}, {'3 of ', G.C.UI.TEXT_DARK}, {'Clubs', G.C.SUITS.Clubs}, {'to your deck', G.C.UI.TEXT_DARK}
    },
    effect = function (card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _ = 1, 16 do
                    SMODS.add_card{ 
                        set = "Playing Card",
                        key_append = "experiments",
                        rank = "3",
                        suit = "Clubs",
                        area = G.deck
                    }
                end
            return true
            end
        }))
    end,
    available = function(card)
        return true
    end,
},


}