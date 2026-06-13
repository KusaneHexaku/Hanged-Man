SMODS.Joker {
	-- How the code refers to the joker.
	key = 'experiments',
    unlocked = true,
    discovered = true,
	blueprint_compat = false,
	-- loc_text is the actual name and description that show in-game for the card.
	
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { 

		experimentsTriggersKey = {
			'containPair',
			'containThree',
			'containFlush',
			'containStraight',
			'3+Clubs',
			'3+Hearts',
			'3+Spades',
			'3+Diamonds',
			'3+Aces',
			'3+Kings',
			'3+Queen',
			'3+Jack',
			'NoFace',
			'OnlyFace',
			'hasGoldCard',
			'hasSteelCard',
			'hasStoneCard',
			'glassBreak',
			'tarotUse',
			'planetUse',
			'discard1Card',
			'play1Card',
			'cardSold',
			'voucherBuy'
		},

		experimentsEffectsKey = {
			'multScale1',
			'multScale2',
			'multScale3',
			'multScale5',
			'chipScale5',
			'chipScale10',
			'chipScale15',
			'chipScale25',
			'xmultScale0.05',
			'xmultScale0.1',
			'xmultScale0.2',
			'xmultScale0.25',
			'randomTarot',
			'randomPlanet',
			'1Gold',
			'2Gold',
			'3Gold',
			'5Gold',
			'endRoundGoldScale1',
			'endRoundGoldScale2',
			'randomFoodJoker',
			'randomChipJoker',
			'spawnOops',
			'topUpTag',
			'doubleTag',
			'couponTag',
			'd6Tag',
			'investTag',
			'resetMoneySpawnRare',
			'halfMoneySpawnUncommon',
			'nextHandIncrement',
			'threeOfClubsFlood',
			'convergeSuit',
			'randomSuit',
			'freeReroll',
			'moreBooster'
		},
		experimentsTriggersPhrase = {
			['containPair'] = 'If hand contains Pair,',
			['containThree'] = 'If hand contains Three of a Kind,',
			['containFlush'] = 'If hand contains Flush,',
			['containStraight'] = 'If hand contains Straight,',
			['3+Clubs'] = 'If hand contains 3+ scoring Clubs cards,',
			['3+Hearts'] = 'If hand contains 3+ scoring Hearts cards,',
			['3+Spades'] = 'If hand contains 3+ scoring Spades cards,',
			['3+Diamonds'] = 'If hand contains 3+ scoring Diamonds cards,',
			['3+Aces'] = 'If hand contains 3+ scoring Aces,',
			['3+Kings'] = 'If hand contains 3+ scoring Kings,',
			['3+Queen'] = 'If hand contains 3+ scoring Queens,',
			['3+Jack'] = 'If hand contains 3+ scoring Jacks,',
			['NoFace'] = 'If hand contains no scoring face cards,',
			['OnlyFace'] = 'If hand contains only scoring face cards,',
			['hasGoldCard'] = 'If hand contains a scoring Gold card,',
			['hasSteelCard'] = 'If hand contains a scoring Steel card,',
			['hasStoneCard'] = 'If hand contains a Stone card,',
			['glassBreak'] = 'When a Glass card breaks,',
			['tarotUse'] = 'When a Tarot card is used,',
			['planetUse'] = 'When a Planet card is used,',
			['discard1Card'] = 'When discarding 1 card,',
			['play1Card'] = 'When playing 1 card,',
			['cardSold'] = 'When a card is sold,',
			['voucherBuy'] = 'When a Voucher is purchased,'
			-- 24
		},
		experimentsEffectsPhrase = {
			['multScale1'] = 'increase this card\'s Mult by 1',
			['multScale2']= 'increase this card\'s Mult by 2',
			['multScale3']= 'increase this card\'s Mult by 3',
			['multScale5']= 'increase this card\'s Mult by 5',
			['chipScale5']= 'increase this card\'s Chips by 5',
			['chipScale10']= 'increase this card\'s Chips by 10',
			['chipScale15']= 'increase this card\'s Chips by 15',
			['chipScale25']= 'increase this card\'s Chips by 25',
			['xmultScale0.05']= 'increase this card\'s XMult by 0.05',
			['xmultScale0.1']= 'increase this card\'s XMult by 0.1',
			['xmultScale0.2']= 'increase this card\'s XMult by 0.2',
			['xmultScale0.25']= 'increase this card\'s  XMult by 0.25',
			['randomTarot']= 'spawn a random Tarot card',
			['randomPlanet']= 'spawn a random Planet card',
			['1Gold']= 'gain $1',
			['2Gold']= 'gain $2',
			['3Gold']= 'gain $3',
			['5Gold']= 'gain $5',
			['endRoundGoldScale1']= 'gain $1 more at end of Blind',
			['endRoundGoldScale2']= 'gain $2 more at end of Blind',
			['randomFoodJoker']= 'spawn a random Food Joker',
			['randomChipJoker']= 'spawn a random Chips Joker',
			['spawnOops']= 'spawn an Oops! All 6s Joker',
			['topUpTag']= 'spawn a Top-Up Tag',
			['doubleTag']= 'spawn a Double Tag',
			['couponTag']= 'spawn a Coupon Tag',
			['d6Tag']= 'spawn a D6 Tag',
			['investTag']= 'spawn an Investment Tag',
			['resetMoneySpawnRare'] = 'lose all your money and spawn a random Rare Joker (must have room)',
			['halfMoneySpawnUncommon'] = 'lose half your money and spawn 2 random Uncommon Joker (must have room)',
			['nextHandIncrement'] = 'increase rank of all scored cards in next hand by 1',
			['threeOfClubsFlood'] = 'add sixteen 3 of Clubs to your deck',
			['convergeSuit'] = 'convert all scored cards in next hand to a single random suit',
			['randomSuit'] = 'convert each scored card in next hand to a random suit',
			['freeReroll'] = 'lose $10 and gain 1 permanent free Shop reroll',
			['moreBooster'] = 'permanently add 1 Booster Pack to each shop'
		},
		activeTriggers = {},
		activeEffects = {},
		experimentsPhrases = {'?','?','?','?','?','?','?','?'},
		experimentsActive = 0,

		chip = 0, mult = 0, xmult = 1, goldEnd = 0,

		flag_incrementHand = 0,
		flag_convergeSuit = 0,
		flag_randomSuit = 0,

		supportedCrossmodFlags = {
			['Phanta'] = false
		}



	 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local mainend = {}

		if card.ability and card.ability.extra.experimentsActive > 0 then
			local textrows = {{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.1}, nodes = {
                            {n = G.UIT.T, config = {align = "cm", text = 'Active Experiments :', colour = G.C.BLUE, scale = 0.3, max_h = 1, max_w = 8, padding = 0.05}},
                    }}}

			local col = G.C.FILTER

			local experimentsTriggersPhraseMainend = {
			['containPair'] = {{'If hand contains a ', G.C.UI.TEXT_DARK}, {'Pair', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['containThree'] = {{'If hand contains a ', G.C.UI.TEXT_DARK}, {'Three of a Kind', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['containFlush'] = {{'If hand contains a ', G.C.UI.TEXT_DARK}, {'Flush', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['containStraight'] = {{'If hand contains a ', G.C.UI.TEXT_DARK}, {'Straight', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['3+Clubs'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring ', G.C.FILTER}, {'Clubs ', G.C.SUITS.Clubs}, {'cards, ', G.C.UI.TEXT_DARK}},
			['3+Hearts'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring ', G.C.FILTER}, {'Hearts ', G.C.SUITS.Hearts}, {'cards, ', G.C.UI.TEXT_DARK}},
			['3+Spades'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring ', G.C.FILTER}, {'Spades ', G.C.SUITS.Spades}, {'cards, ', G.C.UI.TEXT_DARK}},
			['3+Diamonds'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring ', G.C.FILTER}, {'Diamonds ', G.C.SUITS.Diamonds}, {'cards, ', G.C.UI.TEXT_DARK}},
			['3+Aces'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring Aces', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['3+Kings'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring Kings', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['3+Queen'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring Queens', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['3+Jack'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ scoring Jacks', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['NoFace'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'NO ', G.C.RED}, {'scoring face cards, ', G.C.FILTER}},
			['OnlyFace'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'ONLY ', G.C.BLUE}, {'scoring face cards, ', G.C.FILTER}},
			['hasGoldCard'] = {{'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Gold ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}},
			['hasSteelCard'] = {{'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Steel ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}},
			['hasStoneCard'] = {{'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Stone ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}},
			['glassBreak'] = {{'When a ', G.C.UI.TEXT_DARK}, {'Glass ', G.C.FILTER}, {'card breaks, ', G.C.UI.TEXT_DARK}},
			['tarotUse'] = {{'When a ', G.C.UI.TEXT_DARK}, {'Tarot ', G.C.SECONDARY_SET.Tarot}, {'card is used, ', G.C.UI.TEXT_DARK}},
			['planetUse'] = {{'When a ', G.C.UI.TEXT_DARK}, {'Planet ', G.C.SECONDARY_SET.Planet}, {'card is used, ', G.C.UI.TEXT_DARK}},
			['discard1Card'] = {{'When discarding ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}},
			['play1Card'] = {{'When playing ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}},
			['cardSold'] = {{'When a card is ', G.C.UI.TEXT_DARK}, {'sold', G.C.MONEY}, {', ', G.C.UI.TEXT_DARK}},
			['voucherBuy'] = {{'When a ', G.C.UI.TEXT_DARK}, {'Voucher ', G.C.FILTER}, {'is purchased, ', G.C.UI.TEXT_DARK}},
			-- Base : 24


			['phanta_playJunk'] = {{'When playing a ', G.C.UI.TEXT_DARK}, {'Junk', G.C.FILTER}, {', ', G.C.UI.TEXT_DARK}},
			['phanta_hasGhostCard'] = {{'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Ghost ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}},
			['phanta_has3+GhostCard'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ ', G.C.FILTER}, {'scoring ', G.C.UI.TEXT_DARK}, {'Ghost ', G.C.FILTER}, {'cards, ', G.C.UI.TEXT_DARK}},
			['phanta_hasMarbleCard'] = {{'If hand contains a scoring ', G.C.UI.TEXT_DARK}, {'Marble ', G.C.FILTER}, {'card, ', G.C.UI.TEXT_DARK}},
			['phanta_has3+MarbleCard'] = {{'If hand contains ', G.C.UI.TEXT_DARK}, {'3+ ', G.C.FILTER}, {'scoring ', G.C.UI.TEXT_DARK}, {'Marble ', G.C.FILTER}, {'cards, ', G.C.UI.TEXT_DARK}},
			}

			local experimentsEffectsPhraseMainend = {
			['multScale1'] = {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'1', G.C.FILTER}},
			['multScale2']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'2', G.C.FILTER}},
			['multScale3']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'3', G.C.FILTER}},
			['multScale5']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Mult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'5', G.C.FILTER}},
			['chipScale5']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'by ', G.C.UI.TEXT_DARK}, {'5', G.C.FILTER}},
			['chipScale10']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'by ', G.C.UI.TEXT_DARK}, {'10', G.C.FILTER}},
			['chipScale15']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'by ', G.C.UI.TEXT_DARK}, {'15', G.C.FILTER}},
			['chipScale25']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'by ', G.C.UI.TEXT_DARK}, {'25', G.C.FILTER}},
			['xmultScale0.05']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'XMult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'0.05', G.C.FILTER}},
			['xmultScale0.1']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'XMult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'0.1', G.C.FILTER}},
			['xmultScale0.2']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'XMult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'0.2', G.C.FILTER}},
			['xmultScale0.25']= {{'increase this card\'s ', G.C.UI.TEXT_DARK}, {'XMult ', G.C.MULT}, {'by ', G.C.UI.TEXT_DARK}, {'0.25', G.C.FILTER}},
			['randomTarot']= {{'spawn a random ', G.C.UI.TEXT_DARK}, {'Tarot ', G.C.SECONDARY_SET.Tarot}, {'card ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['randomPlanet']= {{'spawn a random ', G.C.UI.TEXT_DARK}, {'Planet ', G.C.SECONDARY_SET.Planet}, {'card ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['1Gold']= {{'gain ', G.C.UI.TEXT_DARK}, {'$1', G.C.MONEY}},
			['2Gold']= {{'gain ', G.C.UI.TEXT_DARK}, {'$2', G.C.MONEY}},
			['3Gold']= {{'gain ', G.C.UI.TEXT_DARK}, {'$3', G.C.MONEY}},
			['5Gold']= {{'gain ', G.C.UI.TEXT_DARK}, {'$5', G.C.MONEY}},
			['endRoundGoldScale1']= {{'increase end of Blind bonus by ', G.C.UI.TEXT_DARK}, {'$1', G.C.MONEY}},
			['endRoundGoldScale2']= {{'increase end of Blind bonus by ', G.C.UI.TEXT_DARK}, {'$2', G.C.MONEY}},
			['randomFoodJoker']= {{'spawn a random ', G.C.UI.TEXT_DARK}, {'Food ', G.C.FILTER}, {'Joker ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['randomChipJoker']= {{'spawn a random ', G.C.UI.TEXT_DARK}, {'Chips ', G.C.CHIPS}, {'Joker ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['spawnOops']= {{'spawn an ', G.C.UI.TEXT_DARK}, {'Oops! All 6s ', G.C.GREEN}, {'Joker ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['topUpTag']= {{'spawn a ', G.C.UI.TEXT_DARK}, {'Top-Up ', G.C.FILTER}, {'tag', G.C.UI.TEXT_DARK}},
			['doubleTag']= {{'spawn a ', G.C.UI.TEXT_DARK}, {'Double ', G.C.FILTER}, {'tag', G.C.UI.TEXT_DARK}},
			['couponTag']= {{'spawn a ', G.C.UI.TEXT_DARK}, {'Coupon ', G.C.FILTER}, {'tag', G.C.UI.TEXT_DARK}},
			['d6Tag']= {{'spawn a ', G.C.UI.TEXT_DARK}, {'D6 ', G.C.GREEN}, {'tag', G.C.UI.TEXT_DARK}},
			['investTag']= {{'spawn an ', G.C.UI.TEXT_DARK}, {'Investment ', G.C.MONEY}, {'tag', G.C.UI.TEXT_DARK}},
			['resetMoneySpawnRare'] = {{'lose ', G.C.UI.TEXT_DARK}, {'all of ', G.C.RED}, {'your current money and spawn ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'random ', G.C.UI.TEXT_DARK}, {'Rare ', G.C.RARITY.Rare}, {'Joker ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['halfMoneySpawnUncommon'] = {{'lose ', G.C.UI.TEXT_DARK}, {'half of ', G.C.RED}, {'your current money and spawn up to ', G.C.UI.TEXT_DARK}, {'2 ', G.C.FILTER}, {'random ', G.C.UI.TEXT_DARK}, {'Uncommon ', G.C.RARITY.Uncommon}, {'Jokers ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
			['nextHandIncrement'] = {{'increase ', G.C.UI.TEXT_DARK}, {'rank ', G.C.FILTER}, {'of all scored cards in next hand by ', G.C.UI.TEXT_DARK}, {'1', G.C.FILTER}},
			['threeOfClubsFlood'] = {{'add ', G.C.UI.TEXT_DARK}, {'16', G.C.FILTER}, {'3 of ', G.C.UI.TEXT_DARK}, {'Clubs', G.C.SUITS.Clubs}, {'to your deck', G.C.UI.TEXT_DARK}},
			['convergeSuit'] = {{'convert all ', G.C.UI.TEXT_DARK}, {'scored cards ', G.C.FILTER}, {'in next hand to a single random ', G.C.UI.TEXT_DARK}, {'suit', G.C.FILTER}},
			['randomSuit'] = {{'convert each ', G.C.UI.TEXT_DARK}, {'scored cards ', G.C.FILTER}, {'in next hand to a random ', G.C.UI.TEXT_DARK}, {'suit', G.C.FILTER}},
			['freeReroll'] = {{'lose ', G.C.UI.TEXT_DARK}, {'$10 ', G.C.MONEY}, {'and gain ', G.C.UI.TEXT_DARK}, {'1 ', G.C.FILTER}, {'permanent free ', G.C.UI.TEXT_DARK}, {'shop reroll ', G.C.GREEN}},
			['moreBooster']= {{'permanently add 1 ', G.C.UI.TEXT_DARK}, {'Booster Pack', G.C.FILTER}, {'to each shop ', G.C.UI.TEXT_DARK}},


			['phanta_randomHanafuda']= {{'spawn a random ', G.C.UI.TEXT_DARK}, {'Hanafuda ', HEX("DB534A")}, {'(Phanta) ', HEX("4d1575")}, {'card ', G.C.UI.TEXT_DARK}, {'(must have room)', G.C.UI.TEXT_INACTIVE}},
		}


			for experimentIndex = 1, card.ability.extra.experimentsActive, 1 do
				local textpiece = {}

				for _i, textcolourpair in ipairs(experimentsTriggersPhraseMainend[card.ability.extra.activeTriggers[experimentIndex]]) do
					textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.3, max_h = 0.5, max_w = 8, padding = 0}}
				end

				for _i, textcolourpair in ipairs(experimentsEffectsPhraseMainend[card.ability.extra.activeEffects[experimentIndex]]) do
					textpiece[#textpiece+1] = {n = G.UIT.T, config = {align = "cm", text = textcolourpair[1], colour = textcolourpair[2], scale = 0.3, max_h = 0.5, max_w = 8, padding = 0}}
				end

				textrows[experimentIndex+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.05}, nodes = textpiece}
			end

			mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = textrows}
            }
		else
			mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = 
					{{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = {
                            {n = G.UIT.T, config = {align = "cm", text = 'No active experiments currently', colour = G.C.UI.TEXT_INACTIVE, scale = 0.3, max_h = 1, max_w = 8, padding = 0}},
                    }}}
				}
            }
		end




		

		return { vars = { card.ability.extra.chip, card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.goldEnd,
		card.ability.extra.experimentsPhrases[1],
		card.ability.extra.experimentsPhrases[2],
		card.ability.extra.experimentsPhrases[3],
		card.ability.extra.experimentsPhrases[4],
		card.ability.extra.experimentsPhrases[5],
		card.ability.extra.experimentsPhrases[6],
		card.ability.extra.experimentsPhrases[7],
		card.ability.extra.experimentsPhrases[8]
	
			},
			main_end = mainend
		}
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 4 },
	-- Cost of card in shop.
	cost = 6,


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		-- Enable Phanta crossmod triggers and effects
		if not card.ability.extra.supportedCrossmodFlags['Phanta'] and next(SMODS.find_mod('GSPhanta')) then
			card.ability.extra.supportedCrossmodFlags['Phanta'] = true

			local phantaTriggers = {'phanta_playJunk', 'phanta_hasGhostCard', 'phanta_has3+GhostCard', 'phanta_hasMarbleCard', 'phanta_has3+MarbleCard'}
			local phantaEffects = {'phanta_randomHanafuda'}
			
			
			for _, key in ipairs(phantaTriggers) do
				card.ability.extra.experimentsTriggersKey[#card.ability.extra.experimentsTriggersKey+1] = key
			end
			for _, key in ipairs(phantaEffects) do
				card.ability.extra.experimentsEffectsKey[#card.ability.extra.experimentsEffectsKey+1] = key
			end


			



		end

		-- Boss Blind beaten, generate a new Experiment

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.experimentsActive < 8 then
            if context.beat_boss then

				G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
						card:juice_up()
						play_sound('generic1', 0.7 + math.random() * 0.1, 0.8)
            			play_sound('holo1', 1.0 + math.random() * 0.1, 0.4)
						return true
				end
				}))

				card.ability.extra.experimentsActive = card.ability.extra.experimentsActive + 1

				pseudoshuffle(card.ability.extra.experimentsEffectsKey, pseudoseed("hangedMan_experiment_shuffle"))
				pseudoshuffle(card.ability.extra.experimentsTriggersKey, pseudoseed("hangedMan_experiment_shuffle"))
				

				card.ability.extra.activeTriggers[#card.ability.extra.activeTriggers + 1] = card.ability.extra.experimentsTriggersKey[1]
				card.ability.extra.activeEffects[#card.ability.extra.activeEffects + 1] = card.ability.extra.experimentsEffectsKey[1]

				card.ability.extra.experimentsPhrases[card.ability.extra.experimentsActive] = card.ability.extra.experimentsTriggersPhrase[card.ability.extra.experimentsTriggersKey[1]] .. " " .. card.ability.extra.experimentsEffectsPhrase[card.ability.extra.experimentsEffectsKey[1]]
				
				table.remove(card.ability.extra.experimentsTriggersKey,1)
				table.remove(card.ability.extra.experimentsEffectsKey,1)

            end
        end

		if context.remove_playing_cards and not context.blueprint then
            local glass_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card.shattered then glass_cards = glass_cards + 1 end
            end  
			if glass_cards > 0 and indexOf(card.ability.extra.activeTriggers, 'glassBreak') then
				for i = 1, glass_cards, 1 do
					activateEffect(card.ability.extra.activeEffects[indexOf(card.ability.extra.activeTriggers, 'glassBreak')])
				end
			end
        end

		if context.buying_card and context.card.ability.set == 'Voucher' and not context.blueprint and indexOf(card.ability.extra.activeTriggers, 'voucherBuy') then activateEffect(card.ability.extra.activeEffects[indexOf(card.ability.extra.activeTriggers, 'voucherBuy')]) end

		if context.discard and not context.blueprint and #context.full_hand == 1 and indexOf(card.ability.extra.activeTriggers, 'discard1Card') then activateEffect(card.ability.extra.activeEffects[indexOf(card.ability.extra.activeTriggers, 'discard1Card') or nil]) end
		if context.before and #context.full_hand == 1 and indexOf(card.ability.extra.activeTriggers, 'play1Card') then activateEffect(card.ability.extra.activeEffects[indexOf(card.ability.extra.activeTriggers, 'play1Card')]) end

        if context.using_consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
			if indexOf(card.ability.extra.activeTriggers, 'tarotUse') then activateEffect(card.ability.extra.activeEffects[indexOf(card.ability.extra.activeTriggers, 'tarotUse')]) end

			if context.consumeable.config.center.key == 'c_hanged_man' then
            	-- Glass Joker updates on Hanged Man and no other destroy consumable
            	local glass_cards = 0
            	for _, removed_card in ipairs(G.hand.highlighted) do
            	    if SMODS.has_enhancement(removed_card, 'm_glass') then glass_cards = glass_cards + 1 end
            	end
				if glass_cards > 0 and indexOf(card.ability.extra.activeTriggers, 'glassBreak') then
					for i = 1, glass_cards, 1 do
						activateEffect(card.ability.extra.activeEffects[indexOf(card.ability.extra.activeTriggers, 'glassBreak')])
					end
				end
			end
        end

		if context.using_consumeable and context.consumeable.ability.set == 'Planet' and not context.blueprint then
			if not indexOf(card.ability.extra.activeTriggers, 'planetUse') then activateEffect(card.ability.extra.activeEffects[indexOf(card.ability.extra.activeTriggers, 'planetUse')]) end
        end

		if context.selling_card and indexOf(card.ability.extra.activeTriggers, 'cardSold') then activateEffect(card.ability.extra.activeEffects[indexOf(card.ability.extra.activeTriggers, 'cardSold')]) end
		
		if context.joker_main then

			local suits = {'Clubs','Hearts','Spades','Diamonds'}
			local singlesuit = pseudorandom_element(suits, pseudoseed('experiments'))
			local ranks = {14,13,12,11}
			local enhances = {'m_gold','m_steel','m_stone'}
			--[[ count of stuff
						1-4 : scoring Clubs, Hearts, Spades, and Diamonds
						5-8 : scoring Aces, Kings, Jacks, and Queens
						9-11 : scoring Gold, Steel, and Stone
						12 : scoring Face cards (in case of Pareidolia)
				]]
			local counters = {0,0,0,0,0,0,0,0,false,false,false,0}

			--[[ count of Phanta stuff
						1-2 : scoring Ghost, Marble
				]]
			local phantaEnhances = {'m_phanta_ghostcard','m_phanta_marblecard'}
			local phantaCounter = {0,0}

			for i, cardPlayed in ipairs(context.scoring_hand) do
				if not cardPlayed.debuff then
					for ii, suit in ipairs(suits) do if cardPlayed:is_suit(suit) then counters[ii] = counters[ii]+1 end end
					for iii, rank in ipairs(ranks) do if cardPlayed:get_id() == rank then counters[iii+4] = counters[iii+4]+1 end end
					for iiii, enhance in ipairs(enhances) do if SMODS.has_enhancement(cardPlayed, enhance) then counters[iiii+8] = true end end
					if cardPlayed:is_face() then counters[12] = counters[12] + 1 end

					if card.ability.extra.supportedCrossmodFlags['Phanta'] then
						for ip, enhance in ipairs(phantaEnhances) do if SMODS.has_enhancement(cardPlayed, enhance) then phantaCounter[ip] = phantaCounter[ip] + 1 end end
					end

					-- For Effect : Increment scored card in next hand by 1
					if card.ability.extra.flag_incrementHand > 0 and cardPlayed:get_id() then
						if cardPlayed:get_id() == 14 then
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

					-- For Effect : Convert all scored card to a single random suit
					if card.ability.extra.flag_convergeSuit > 0 then
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

					-- For Effect : Convert each scored card to a random suit
					if card.ability.extra.flag_randomSuit > 0 then
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
            end

			for i, trigger in ipairs(card.ability.extra.activeTriggers) do

				--- Evaluating Triggers on Hand played
				if trigger == 'containPair' and next(context.poker_hands["Pair"]) then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'containThree' and next(context.poker_hands["Three of a Kind"]) then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'containFlush' and next(context.poker_hands["Flush"]) then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'containStraight' and next(context.poker_hands["Straight"]) then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == '3+Clubs' and counters[1] > 2 then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == '3+Hearts' and counters[2] > 2  then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == '3+Spades' and counters[3] > 2  then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == '3+Diamonds' and counters[4] > 2  then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == '3+Aces' and counters[5] > 2  then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == '3+Kings' and counters[6] > 2 then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == '3+Queen' and counters[7] > 2 then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == '3+Jack' and counters[8] > 2 then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'NoFace' and counters[12] == 0 then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'OnlyFace' and counters[12] == #context.full_hand then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'hasGoldCard' and counters[9] then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'hasSteelCard' and counters[10] then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'hasStoneCard' and counters[11] then activateEffect(card.ability.extra.activeEffects[i])

				elseif trigger == 'phanta_playJunk' and context.scoring_name == 'phanta_junk' then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'phanta_hasGhostCard' and phantaCounter[1] > 0 then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'phanta_hasMarbleCard' and phantaCounter[2] > 0  then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'phanta_has3+GhostCard' and phantaCounter[1] > 2 then activateEffect(card.ability.extra.activeEffects[i])
				elseif trigger == 'phanta_has3+MarbleCard' and phantaCounter[2] > 2  then activateEffect(card.ability.extra.activeEffects[i])
				end
			end
			
			return {
				chips = card.ability.extra.chip,
				extra = {
					mult = card.ability.extra.mult,
					extra = {
						xmult = card.ability.extra.xmult,
					}
				}
			}	
		end

		if context.after then

			-- Decrementing all the Next Hand flags counters
			if card.ability.extra.flag_incrementHand > 0 then card.ability.extra.flag_incrementHand = card.ability.extra.flag_incrementHand -1 end
			if card.ability.extra.flag_convergeSuit > 0 then card.ability.extra.flag_convergeSuit = card.ability.extra.flag_convergeSuit -1 end
			if card.ability.extra.flag_randomSuit > 0 then card.ability.extra.flag_randomSuit = card.ability.extra.flag_randomSuit -1 end


		end

		function activateEffect(effectKey)

			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
						card:juice_up()
						play_sound('tarot1', 0.6 + math.random() * 0.2, 0.4)
						play_sound('generic1', 0.7 + math.random() * 0.1, 0.8)
						return true
				end
			}))

			if not effectKey then return true
   			elseif effectKey == 'multScale1' then
				card.ability.extra.mult = card.ability.extra.mult + 1
			elseif effectKey == 'multScale2' then
				card.ability.extra.mult = card.ability.extra.mult + 2
			elseif effectKey =='multScale3' then
				card.ability.extra.mult = card.ability.extra.mult + 3
			elseif effectKey =='multScale5' then
				card.ability.extra.mult = card.ability.extra.mult + 5
			elseif effectKey =='chipScale5' then
				card.ability.extra.chip = card.ability.extra.chip + 5
			elseif effectKey =='chipScale10' then
				card.ability.extra.chip = card.ability.extra.chip + 10
			elseif effectKey =='chipScale15' then
				card.ability.extra.chip = card.ability.extra.chip + 15
			elseif effectKey =='chipScale25' then
				card.ability.extra.chip = card.ability.extra.chip + 25
			elseif effectKey =='xmultScale0.05' then
				card.ability.extra.xmult = card.ability.extra.xmult + 0.05
			elseif effectKey =='xmultScale0.1' then
				card.ability.extra.xmult = card.ability.extra.xmult + 0.1
			elseif effectKey =='xmultScale0.2' then
				card.ability.extra.xmult = card.ability.extra.xmult + 0.2
			elseif effectKey =='xmultScale0.25' then
				card.ability.extra.xmult = card.ability.extra.xmult + 0.25
			elseif effectKey =='randomTarot' then
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
			elseif effectKey =='randomPlanet' then
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
			elseif effectKey =='1Gold' then
				ease_dollars(1)
			elseif effectKey =='2Gold' then
				ease_dollars(2)
			elseif effectKey =='3Gold' then
				ease_dollars(3)
			elseif effectKey =='5Gold' then
				ease_dollars(5)
			elseif effectKey =='endRoundGoldScale1' then
				card.ability.extra.goldEnd = card.ability.extra.goldEnd + 1
			elseif effectKey =='endRoundGoldScale2' then
				card.ability.extra.goldEnd = card.ability.extra.goldEnd + 2
			elseif effectKey =='randomFoodJoker' then
				if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
					local foodJokerPool = {'j_cavendish','j_gros_michel','j_egg','j_ice_cream','j_turtle_bean','j_diet_cola','j_popcorn','j_ramen','j_selzer','j_gros_michel','j_egg','j_ice_cream','j_turtle_bean','j_diet_cola','j_popcorn','j_ramen','j_selzer','j_gros_michel','j_egg','j_ice_cream','j_turtle_bean','j_diet_cola','j_popcorn','j_ramen','j_selzer'}
					pseudoshuffle(foodJokerPool, "hangedMan_experiment_shuffle")
            		local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
           			G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            		G.E_MANAGER:add_event(Event({
                		func = function()
                    		for _ = 1, jokers_to_create do
                            		SMODS.add_card{ key = foodJokerPool[1] }
                        	G.GAME.joker_buffer = 0
                    	end
                    return true
                	end
            		}))
       			end
			elseif effectKey =='randomChipJoker' then
				if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
					local chipJokerPool = {'j_arrowhead','j_banner','j_blue_joker','j_bull','j_castle','j_clever','j_crafty','j_devious','j_hiker','j_ice_cream','j_odd_todd','j_runner','j_scary_face','j_sly','j_square_joker','j_stone','j_stuntman','j_wee','j_wily'}
					pseudoshuffle(chipJokerPool, "hangedMan_experiment_shuffle")
            		local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
           			G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            		G.E_MANAGER:add_event(Event({
                		func = function()
                    		for _ = 1, jokers_to_create do
                            		SMODS.add_card{ key = chipJokerPool[1] }
                        	G.GAME.joker_buffer = 0
                    	end
                    return true
                	end
            		}))
       			end
			elseif effectKey =='spawnOops' then
				if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            		local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
           			G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            		G.E_MANAGER:add_event(Event({
                		func = function()
                    		for _ = 1, jokers_to_create do
                        		SMODS.add_card{ key = "j_oops" }
                        	G.GAME.joker_buffer = 0
                    	end
                    return true
                	end
            		}))
				end
			elseif effectKey =='topUpTag' then
				G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_top_up'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                	end)
           		}))
			elseif effectKey =='doubleTag' then
				G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_double'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                	end)
           		}))
			elseif effectKey =='couponTag' then
				G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_coupon'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                	end)
           		}))
			elseif effectKey =='d6Tag' then
				G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_d_six'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                	end)
           		}))
			elseif effectKey =='investTag' then
				G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_investment'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                	end)
           		}))
			elseif effectKey == 'resetMoneySpawnRare' then
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
                        	G.GAME.joker_buffer = 0
                    	end
                    return true
                	end
            		}))
       			end
				ease_dollars(-G.GAME.dollars, true)
			elseif effectKey == 'halfMoneySpawnUncommon' then
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
                        	G.GAME.joker_buffer = 0
                    	end
                    return true
                	end
            		}))
       			end
				ease_dollars(-math.floor(G.GAME.dollars/2), true)
			elseif effectKey == 'nextHandIncrement' then
				card.ability.extra.flag_incrementHand = card.ability.extra.flag_incrementHand + 1
				local eval = function(card) return card.ability.extra.flag_incrementHand > 1 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
			elseif effectKey == 'threeOfClubsFlood' then
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
			elseif effectKey == 'convergeSuit' then
				card.ability.extra.flag_convergeSuit = card.ability.extra.flag_convergeSuit + 1
				local eval = function(card) return card.ability.extra.flag_convergeSuit > 1 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
			elseif effectKey == 'randomSuit' then
				card.ability.extra.flag_randomSuit = card.ability.extra.flag_randomSuit + 1
				local eval = function(card) return card.ability.extra.flag_randomSuit > 1 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
			elseif effectKey == 'freeReroll' then
				SMODS.change_free_rerolls(1)
				ease_dollars(-10)
			elseif effectKey == 'moreBooster' then
				SMODS.change_booster_limit(1)


			-- Phanta : spawn a random Hanafuda card
			elseif effectKey == 'phanta_randomHanafuda' then

				if not card.ability.extra.supportedCrossmodFlags['Phanta'] then return true end

				local phanta_hanaset = pseudorandom_element({"phanta_chaff", "phanta_chaff", "phanta_chaff", "phanta_chaff", "phanta_chaff", "phanta_ribbon", "phanta_ribbon", "phanta_animal", "phanta_animal", "phanta_bright" }, pseudoseed('j_hangedman_noMoreJokers'))

				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
					func = (function()
						play_sound('timpani')
						local new_card = SMODS.create_card({ set = phanta_hanaset, key_append = "experiments" })
						new_card:add_to_deck()
						G.consumeables:emplace(new_card)
						card:juice_up(0.3, 0.5)
						G.GAME.consumeable_buffer = 0
						return true
					end)
				}))
				end







			end

		end

		function indexOf(array, value)
    		for i, v in ipairs(array) do
        		if v == value then
            		return i
        		end
    		end
    	return nil
		end

	end,
	
	calc_dollar_bonus = function(self, card)
		if card.ability.extra.goldEnd > 0 then return card.ability.extra.goldEnd end
	end
}

