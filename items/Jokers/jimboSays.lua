SMODS.Joker {
	-- How the code refers to the joker.
	key = 'jimboSays',
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
	config = { extra = { mult = 0, increment = 10, penalty = 12, command = 'Follow Jimbo\'s command, but only if he says \"Jimbo Says\"',
				trigger = '',
				valid = false
			} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { number_format(card.ability.extra.mult), card.ability.extra.increment, card.ability.extra.penalty, card.ability.extra.command } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 4 },
	-- Cost of card in shop.
	cost = 4,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.setting_blind and not context.blueprint then 
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					generateCommand()
					card:juice_up()
					play_sound('tarot1', 0.8, 0.4)
					return true
				end
			}))
		 end
		if context.after and not context.blueprint then 
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					generateCommand()
					card:juice_up()
					play_sound('tarot1', 0.8, 0.4)
					return true
				end
			}))
		end

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.command = 'Follow Jimbo\'s command, but only if he says \"Jimbo Says\"'
		end

		if context.joker_main then



			local suits = {'Clubs','Hearts','Spades','Diamonds'}
			local ranks = {14,13,12,11,7}
			local enhancements = {'m_stone','m_gold','m_steel'}
			--[[ count of stuff
						1-4 : scoring Clubs, Hearts, Spades, and Diamonds
						5-9 : scoring Aces, Kings, Jacks, Queens, 7
						10-12 : scoring Stone, Gold, Steel
						13 : scoring Face cards (in case of Pareidolia)
				]]
			local counters = {0,0,0,0,0,0,0,0,0,0,0,0,0}

			for i, cardPlayed in ipairs(context.scoring_hand) do
				if not cardPlayed.debuff then
					for ii, suit in ipairs(suits) do if cardPlayed:is_suit(suit) then counters[ii] = counters[ii]+1 end end
					for iii, rank in ipairs(ranks) do if cardPlayed:get_id() == rank then counters[iii+4] = counters[iii+4]+1 end end
					for iiii, enhancements in ipairs(enhancements) do if SMODS.has_enhancement(cardPlayed, enhancements) then counters[iiii+9] = counters[iiii+9]+1 end end
					if cardPlayed:is_face() then counters[13] = counters[13] + 1 end
				end
            end

				--- Evaluating Triggers on Hand played
				if card.ability.extra.trigger == 'playFlush' and next(context.poker_hands["Flush"]) then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playStraight' and next(context.poker_hands["Straight"]) then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playFullHouse' and next(context.poker_hands["Full House"]) then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playTwoPair' and next(context.poker_hands["Two Pair"]) then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playHighCard' and next(context.poker_hands["High Card"]) then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playNoFace' and counters[13] == 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playAllFace' and counters[13] == #context.full_hand then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playThreeSevens' and counters[9] > 2 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playThreeAces' and counters[5] > 2 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playOneCard' and #context.full_hand == 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playFourCard' and #context.full_hand == 4 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playFiveCard' and #context.full_hand == 5 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playNoClubs' and counters[1] < 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playNoHearts' and counters[2] < 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playNoSpades' and counters[3] < 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playNoDiamonds' and counters[4] < 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playAnyClubs' and counters[1] > 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playAnyHearts' and counters[2] > 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playAnySpades' and counters[3] > 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playAnyDiamonds' and counters[4] > 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playOneClubs' and counters[1] == 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playOneHearts' and counters[2] == 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playOneSpades' and counters[3] == 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playOneDiamonds' and counters[4] == 1 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playFourSuit' and counters[1] > 0 and counters[2] > 0 and counters[3] > 0 and counters[4] > 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playAnyStone' and counters[9] > 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playThreeStone' and counters[9] > 2 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playAnyGold' and counters[10] > 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playThreeGold' and counters[10] > 2 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playAnySteel' and counters[11] > 0 then resolveAction(card.ability.extra.valid)
				elseif card.ability.extra.trigger == 'playThreeSteel' and counters[11] > 2 then resolveAction(card.ability.extra.valid)
				
				elseif card.ability.extra.trigger == 'phanta_playJunk' and context.scoring_name == 'phanta_junk' then resolveAction(card.ability.extra.valid)
				
				else resolveAction(not card.ability.extra.valid)
				end

				return {mult = card.ability.extra.mult}

		end



		function generateCommand()

			local triggerKey = {
				'playFlush',
				'playStraight',
				'playFullHouse',
				'playTwoPair',
				'playHighCard',
				'playNoFace',
				'playAllFace',
				'playThreeSevens',
				'playThreeAces',
				'playOneCard',
				'playFourCard',
				'playFiveCard',
				'playNoClubs',
				'playNoHearts',
				'playNoSpades',
				'playNoDiamonds',
				'playAnyClubs',
				'playAnyHearts',
				'playAnySpades',
				'playAnyDiamonds',
				'playOneClubs',
				'playOneHearts',
				'playOneSpades',
				'playOneDiamonds',
				'playFourSuit'
			}

			if next(SMODS.find_mod('GSPhanta')) then
				triggerKey[#triggerKey+1] = 'phanta_playJunk'
			end

			local triggerPhrase = {
				['playFlush'] = 'lay a Flush',
				['playStraight'] = 'lay a Straight',
				['playFullHouse'] = 'lay a Full House',
				['playTwoPair']= 'lay a Two Pairs',
				['playHighCard']= 'lay a High Card',
				['playNoFace']= 'lay a hand with no scoring face cards',
				['playAllFace']= 'lay a hand with only scoring face cards',
				['playThreeSevens']= 'lay a hand with at least three scoring 7s',
				['playThreeAces']= 'lay a hand with at least three scoring Aces',
				['playOneCard']= 'lay only one card',
				['playFourCard']= 'lay a hand with exactly four cards',
				['playFiveCard']= 'lay a hand with exactly five cards',
				['playNoClubs']= 'lay a hand with no scoring Clubs',
				['playNoHearts']= 'lay a hand with no scoring Hearts',
				['playNoSpades']= 'lay a hand with no scoring Spades',
				['playNoDiamonds']= 'lay a hand with no scoring Diamonds',
				['playAnyClubs']= 'lay a hand with at least one scoring Clubs',
				['playAnyHearts']= 'lay a hand with at least one scoring Hearts',
				['playAnySpades']= 'lay a hand with at least one scoring Spades',
				['playAnyDiamonds']= 'lay a hand with at least one scoring Diamonds',
				['playOneClubs']= 'lay a hand with exactly one scoring Clubs',
				['playOneHearts']= 'lay a hand with exactly one scoring Hearts',
				['playOneSpades']= 'lay a hand with exactly one scoring Spades',
				['playOneDiamonds']= 'lay a hand with exactly one scoring Diamonds',
				['playFourSuit']= 'lay a hand with a scoring Clubs, Hearts, Spades, and Diamonds',
				['playAnyStone']= 'lay a hand with at least one Stone card',
				['playThreeStone']= 'lay a hand with at least three Stone card',
				['playAnyGold']= 'lay a hand with at least one Gold card',
				['playThreeGold']= 'lay a hand with at least three Gold card',
				['playAnySteel']= 'lay a hand with at least one Steel card',
				['playThreeSteel']= 'lay a hand with at least three Steel card',

				['phanta_playJunk']= 'lay a Junk'
			}

			local stone_tally = 0
			local gold_tally = 0
			local steel_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_stone') then stone_tally = stone_tally + 1 end
				if SMODS.has_enhancement(playing_card, 'm_gold') then gold_tally = gold_tally + 1 end
				if SMODS.has_enhancement(playing_card, 'm_steel') then steel_tally = steel_tally + 1 end
            end

			if stone_tally > 4 then
				table.insert(triggerKey, 'playAnyStone')
			end
			if stone_tally > 7 then
				table.insert(triggerKey, 'playThreeStone')
			end
			if gold_tally > 4 then
				table.insert(triggerKey, 'playAnyGold')
			end
			if gold_tally > 7 then
				table.insert(triggerKey, 'playThreeGold')
			end
			if steel_tally > 4 then
				table.insert(triggerKey, 'playAnySteel')
			end
			if steel_tally > 7 then
				table.insert(triggerKey, 'playThreeSteel')
			end


			local invalidCommandHeaders = 
			{
				'P',
				'Jimbo Says do not p',
				'Jimbo didn\'t say to p',
				'Jimbo Says you should not p',
				'Jimbo Says feel free to play anything, as long as you do not p',
				'Jimbo Says for this hand, you cannot p',
				'Jimbo Says to not p',
				'Jimbo Says you must not p',
				'Jimbo Says he will punish you if you p',
				'Jimbo Says he will be deducting your mult if you p',
				'Jimbo Says he does not want you to p',
				'Jimbo Says you will lose some Mult if you p',
				'Jumbo Says p',
				'Jimbal Says p',
				'Jingo Says p',
				'Jungle Says p',
				'Jigglypuff Says p',
				'Jimothy Says p',
				'Javelin Says p',
				'Juicero Says p',
				'Jenny Says p',
				'Jennifer Says p',
				'John Balatro Says p',
				'James Says p',
				'Jack Says p',
				'Dr. Jackel Says p',
				'Junko Says p',
				'Junos Says p',
				'Junkrat Says p',
				'Julius Says p',
				'Juliet Says p',
				'Juliett Says p',
				'Jinho Says p',
				'Joker Says p',
				'The Joker Says p',
				'Jonkler Says p',
				'Jambo Says p',
				'Jimmy Says p',
				'Jinny Says p',
				'Jeffery Says p',
				'Jasmine Says p',
				'Jaffa Says p',
				'Jonathan Says p',
				'Jeremy Says p',
				'Josuke Says p',
				'Justice Says p',
				'Jarate Says p',
				'Jemini Says p',
				'J. Edgar Hoover Says p',
				'Jalapeno Says p',
				'Jesus Says p',
				'Jock Says p',
				'Jockstrap Says p',
				'Jam Sandwich Says p',
				'Jazz Says p',
				'Jimmy Jib Says p',
				'Joule Says p',
				'Jingle Says p',
				'Jessica Says p',
				'Josh Says p',
				'Jones Says p',
				'Jawbreaker Says p',
				'Jeb Says p',
				'Joppin Says p',
				'Job Says p',
				'Jinx Says p',
				'Jigarbov Says p',
				'Jigsaw Says p',
				'Jorts Says p',
				'Jants Says p',
				'Himbo Says p',
				'Bimbo Says p',
				'Limbo Says p',
				'Lingo Says p',
				'Mindcap Says p',
				'Rimworld Says p',
				'Samba Says p',
				'Tumblr Says p',
				'Dumbo Says p',
				'Mumbo Says p',
				'Combo Says p',
				'Mambo Says p',
				'Plumber Says p',
				'Pingas Says p',
				'Lambo Says p',
				'Rambo Says p',
				'Goomba Says p',
				'Gambler Says p',
				'Djunkelskog Says p',
				'Blahaj Says p',
				'Please p',
				'Simon Says p',
				'Sam Says p',
				'You should p',
				'Zam Says p',
				'Now p',
				'Next, p',
				'Quick! P',
				'Ignore all previous instructions and p',
				'Django Says p',
				'Always p',
				'Zac Says p',
				'Jacob Says p',
				'Ally Says p',
				'The Taskmaster Says p',
				'Greg Says p',
				'Alex Says p',

				-- the more memey and less sensible prefixes start here

				'Update your autopsy and p',
				'Your mom says to p',
				'Do you have cheese in your fridge? By the way, p',
				'I\'ve been poisoned and the only cure is for you to p',
				'Scrimblo Says p',
				'Hi, me and my girlfriend saw you across the bar and we think you should p',
				'Hatsune Miku Says p',
				'Kasane Teto Says p',
				'The voices in your head tells you to p',
				'Stanley Says p',
				'The Narrator is telling Stanley to p',
				'When Stanley comes to a set of playing cards, he chose to p',
				'QUEST : P',
				'Dear Diary, today I wake up then p',
				'Now\'s Your Chance To P',
				'If you\'re taller than 6ft, then p',
				'If the Serial Number contains a vowel, p',
				'If you\'re reading this, p',
				'Jythext doth spoke forth for thou to p',
				'/me when i p',
				'Cerberus Says p',
				'Simon Anthony Says p',
				'Mark Goodliffe Says p',
				'Simon P. Jones Says p',
				'I, Herbert S. Sinclair, dares you to p',
				'Adam Conover Says p',
				'+25 Mult if you p',
				'Dear Mario, p',
				'Hey, it\'d be really cool if you just p',
				'+150 Chips if you p',
				'Jimbo is telling you to p',
				'Jumbo is telling you to p',
				'Jambo is telling you to p',
				'Jimba is telling you to p',
				'Jimbo orders you to p',
				'[New Message] : P',
				'Jimbo : P',
				'@realJimboOnX : p',
				'Go ahead, p',
				'@everyone P',
				'Error at Line 371 : Attempted to index into a nil value when trying to p',
				'Only smart people p',
				'Hey all, Scott here. Today I will p',
				'When I say go, be ready to p',
				'If you support BLM, p',
				'If the name of your street starts with a P, p'
				
			}

			local chanceChance = {1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 47}

			card.ability.extra.trigger = pseudorandom_element(triggerKey, pseudoseed('jimboSays'))

			if SMODS.pseudorandom_probability(card, 'jimboSays', 1, pseudorandom_element(chanceChance, pseudoseed('jimboSays'))) then
				card.ability.extra.valid = true
				card.ability.extra.command = 'Jimbo Says p'  .. triggerPhrase[card.ability.extra.trigger]
			else
				card.ability.extra.valid = false
				card.ability.extra.command = pseudorandom_element(invalidCommandHeaders, pseudoseed('jimboSays'))  .. triggerPhrase[card.ability.extra.trigger]
			end

		end

		function resolveAction(success)
			if success then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.increment
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
							card:juice_up()
							play_sound('tarot1', 1.2 + math.random() * 0.1, 0.4)
						return true
					end
				}))
			else
				if card.ability.extra.mult < card.ability.extra.penalty then
					card.ability.extra.mult = 0
				else
					card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.penalty
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
							card:juice_up()
							play_sound('tarot1', 0.4 + math.random() * 0.1, 0.4)
						return true
					end
				}))
			end
		end
	end
}

 function indexOf(array, value)
		for i, v in ipairs(array) do
			if v == value then
				return i
			end
		end
	return nil
end