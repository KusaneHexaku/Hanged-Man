SMODS.Joker {
	-- How the code refers to the joker.
	key = 'noMoreJokers',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	
	config = { extra = { xmult = 1, xmultinc = 0.5,

	bannedList = {},

	bannable_pool = {},
	activeRankHardBans = 0,
	activeSuitHardBans = 0,
	vetoFaceHardBansFlag = 0,

	failure = false

} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local mainend = {}

		if card.ability and #card.ability.extra.bannedList > 0 then
			local textrows = {{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.1}, nodes = {
                            {n = G.UIT.T, config = {align = "cm", text = 'NO MORE', colour = G.C.RED, scale = 0.35, max_h = 1, max_w = 8, padding = 0.05}},
                    }}}

			local col = G.C.FILTER
			local textlookup = {
				-- rank hard bans
				['AnyAce'] = 'a scoring Ace',
				['Any2'] = 'a scoring 2',
				['Any3'] = 'a scoring 3',
				['Any4'] = 'a scoring 4',
				['Any5'] = 'a scoring 5',
				['Any6'] = 'a scoring 6',
				['Any7'] = 'a scoring 7',
				['Any8'] = 'a scoring 8',
				['Any9'] = 'a scoring 9',
				['Any10'] = 'a scoring 10',
				['AnyJack'] = 'a scoring Jack',
				['AnyQueen'] = 'a scoring Queen',
				['AnyKing'] = 'a scoring King',

				-- suit hard bans
				['AnyClubs'] = 'a scoring Club cards',
				['AnyHearts'] = 'a scoring Heart cards',
				['AnySpades'] = 'a scoring Spade cards',
				['AnyDiamonds'] = 'a scoring Diamond cards',

				-- rank soft bans
				['TwoAce'] = '2 or more scoring Aces',
				['Two2'] = '2 or more scoring 2s',
				['Two3'] = '2 or more scoring 3s',
				['Two4'] = '2 or more scoring 4s',
				['Two5'] = '2 or more scoring 5s',
				['Two6'] = '2 or more scoring 6s',
				['Two7'] = '2 or more scoring 7s',
				['Two8'] = '2 or more scoring 8s',
				['Two9'] = '2 or more scoring 9s',
				['Two10'] = '2 or more scoring 10s',
				['TwoJack'] = '2 or more scoring Jacks',
				['TwoQueen'] = '2 or more scoring Queens',
				['TwoKing'] = '2 or more scoring Kings',

				-- suit soft bans
				['ThreeClubs'] = '3 or more scoring Club cards',
				['ThreeHearts'] = '3 or more scoring Heart cards',
				['ThreeSpades'] = '3 or more scoring Spade cards',
				['ThreeDiamonds'] = '3 or more scoring Diamond cards',

				-- hand type bans
				['ThreeOfAKind'] = 'a Three of a Kind',
				['Pair'] = 'a Pair',
				['Two Pair'] = 'a Two Pair',
				['Flush'] = 'a Flush',
				['Straight'] = 'a Straight',

				-- enhancements bans
				['Bonus'] = 'a scoring Bonus card',
				['Mult'] = 'a scoring Mult card',
				['Glass'] = 'a scoring Glass card',
				['Lucky'] = 'a scoring Lucky card',
				['Stone'] = 'a scoring Stone card',
				['Steel'] = 'a scoring Steel card',
				['Gold'] = 'a scoring Gold card',

				-- general/misc bans
				['ThreeEnhance'] = '3 or more scoring Enhanced cards',
				['TwoSeal'] = '2 or more scoring cards with a Seal',
				['TwoEdition'] = '2 or more scoring cards with an Edition',
				['Face'] = 'a scoring face card',
				['TwoFace'] = '2 or more scoring face cards',
				['Unscored'] = 'an unscored or debuffed card',
				['FiveScored'] = '5 or more scoring cards'
			}

			for index, key in ipairs(card.ability.extra.bannedList) do
				textrows[index+1] = {n = G.UIT.R, config = {align = "cm", h = 0.5, w = 10, padding = 0.05}, nodes = {
                            {n = G.UIT.T, config = {align = "cm", text = '- hands containing ', colour = G.C.UI.TEXT_DARK, scale = 0.3}},
							{n = G.UIT.T, config = {align = "cm", text = textlookup[key], colour = col, scale = 0.3}},
                    }}
			end


			mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = textrows}
            }
		else
			mainend = {
                { n=G.UIT.C, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = 
					{{n = G.UIT.R, config = {align = "cm", h = 1, w = 10, padding = 0.05}, nodes = {
                            {n = G.UIT.T, config = {align = "cm", text = 'No restrictions', colour = G.C.UI.TEXT_INACTIVE, scale = 0.3}},
                    }}}
				}
            }
		end

        return { vars = { card.ability.extra.xmultinc, card.ability.extra.xmult }, main_end = mainend }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 6 },
	-- Cost of card in shop.
	cost = 8,
	attributes = {'xmult', 'scaling', 'rank', 'suit', 'hand_type', 'enhancements'},

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.before and not context.blueprint then
			
			card.ability.extra.bannable_pool = {}
			card.ability.extra.failure = false

			local rankcount = {0,0,0,0,0,0,0,0,0,0,0,0,0}
			local facecount = 0
			local suitcount = {0,0,0,0}
			local suitorder = {'Clubs','Hearts','Spades','Diamonds'}
			local enhancecount = {0,0,0,0,0,0,0}
			local enhancekeys = {'m_bonus','m_mult','m_glass','m_lucky','m_stone','m_steel','m_gold'}
			local enhanceText = {'Bonus','Mult','Glass','Lucky','Stone','Steel','Gold'}
			local debuffcount = false

			for index, playing_card in ipairs(context.scoring_hand) do

				if playing_card.debuff then debuffcount = true
				else

					if playing_card:get_id() then
						rankcount[playing_card:get_id()-1] = rankcount[playing_card:get_id()-1] + 1
						if playing_card:is_face() then facecount = facecount + 1 end

						for i, s in ipairs(suitorder) do
							if playing_card:is_suit(s) then suitcount[i] = suitcount[i] + 1 end
						end
					end

					for ii, enhance in ipairs(enhancekeys) do
						if SMODS.has_enhancement(playing_card, enhance) then enhancecount[ii] = enhancecount[ii] + 1 end
					end
				end
				
			end

			-- picking out every available property keys to add to pool

			-- ranks bans
			for banningrank, amount in ipairs(rankcount) do
				local ranktext = '' .. (banningrank + 1)
				if ranktext == '14' then ranktext = 'Ace' end
				if ranktext == '13' then ranktext = 'King' end
				if ranktext == '12' then ranktext = 'Queen' end
				if ranktext == '11' then ranktext = 'Jack' end
				if amount > 1 and not HangedMan.indexOf(card.ability.extra.bannedList, 'Any' .. ranktext) then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Two' .. ranktext end
				if amount > 0 then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Any' .. ranktext end
			end

			-- suits bans
			for banningsuit, amount in ipairs(suitcount) do
				if amount > 2 and not HangedMan.indexOf(card.ability.extra.bannedList, 'Any' .. suitorder[banningsuit]) then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Three' .. suitorder[banningsuit] end
				if amount > 0 then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Any' .. suitorder[banningsuit] end
			end

			-- enhancements bans
			local enhancetally = 0
			for banningenhance, amount in ipairs(enhancecount) do
				if amount > 0 then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = enhanceText[banningenhance] end
				enhancetally = enhancetally + amount
			end
			if enhancetally > 0 then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'ThreeEnhance' end

			-- hand type bans
			if next(context.poker_hands['Three of a Kind']) then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'ThreeOfAKind' end
			if next(context.poker_hands['Pair']) then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Pair' end
			if next(context.poker_hands['Two Pair']) then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Two Pair' end
			if next(context.poker_hands['Flush']) then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Flush' end
			if next(context.poker_hands['Straight']) then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Straight' end

			if facecount > 1 then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Face' end
			if facecount > 2 then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'TwoFace' end
			if #context.scoring_hand > 4 then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'FiveScored' end
			if #context.full_hand > #context.scoring_hand or debuffcount then card.ability.extra.bannable_pool[#card.ability.extra.bannable_pool+1] = 'Unscored' end

			-- checking for any matches between pool and current bannedList, resets if found
			for _, key in ipairs(card.ability.extra.bannable_pool) do
				if HangedMan.indexOf(card.ability.extra.bannedList, key) then
					--print('[No More Jokers] Property ' .. key .. ' of played was found to match an existing banned element')
					card.ability.extra.failure = true
					--table.remove(card.ability.extra.bannable_pool, HangedMan.indexOf(card.ability.extra.bannable_pool, key))
				end
			end

			if card.ability.extra.failure then
				card.ability.extra.xmult = 1
				card.ability.extra.bannedList = {}
				return {
                	message = 'Reset!',
                	colour = G.C.RED
            	}
			end

			-- remove redundant bans
			if HangedMan.indexOf(card.ability.extra.bannedList, 'Face') then
				local k = {'AnyJack', 'AnyQueen', 'AnyKing', 'TwoJack', 'TwoQueen', 'TwoKing', 'TwoFace'}
				for _, key in ipairs(k) do
					if HangedMan.indexOf(card.ability.extra.bannable_pool, key) then table.remove(card.ability.extra.bannable_pool, HangedMan.indexOf(card.ability.extra.bannable_pool, key)) end
				end
			end

			if HangedMan.indexOf(card.ability.extra.bannedList, 'Pair') and HangedMan.indexOf(card.ability.extra.bannable_pool, 'Two Pair') then
				table.remove(card.ability.extra.bannable_pool, HangedMan.indexOf(card.ability.extra.bannable_pool, 'Two Pair'))
			end

			--print(card.ability.extra.bannable_pool)

		end

		if context.joker_main and card.ability.extra.xmult > 1 then
			return { xmult = card.ability.extra.xmult }
		end

		if context.after and not context.blueprint then
			
			if not card.ability.extra.failure then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultinc
				card.ability.extra.bannedList[#card.ability.extra.bannedList+1] = pseudorandom_element(card.ability.extra.bannable_pool, pseudoseed('j_hangedman_noMoreJokers'))
				return {
                	message = 'X' .. card.ability.extra.xmult .. ' Mult',
                	colour = G.C.RED
            	}
			end
			
			card.ability.extra.bannable_pool = {}
			card.ability.extra.failure = false
			--print(card.ability.extra.bannedList)

		end


		

	end
}
