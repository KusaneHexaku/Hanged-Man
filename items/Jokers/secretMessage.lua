SMODS.Joker {
	-- How the code refers to the joker.
	key = 'secretMessage',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Secret Message',
		text = {
			'{C:blue,s:0.8}#1# #2# #3# #4# #5#',
			'{C:blue,s:0.8}#6# #7# #8# #9# #10#',
			'{C:blue,s:0.8}#11# #12# #13# #14# #15#',
			'{C:blue,s:0.8}#16# #17# #18# #19# #20#',
			'{C:blue,s:0.8}#21# #22# #23# #24# #25#',
			'{C:blue,s:0.8}#26# #27# #28# #29# #30#',
			'{C:blue,s:0.8}#31# #32# #33# #34# #35#',
			'{C:blue,s:0.8}#36# #37# #38# #39# #40#',
			'{C:blue,s:0.8}#41# #42# #43# #44# #45#',
		}
	},
	config = { extra = { 
		fullstring = {},
		revealedstring = {'?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?','?',},
		unrevealedindex = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45},
		selectedID = -1,
		generated = false
	 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)

        return { 
			vars = card.ability.extra.revealedstring,
			main_end = mainend }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 5 },
	-- Cost of card in shop.
	cost = 5,


	add_to_deck = function(self, card, from_debuff)
		if not from_debuff and not card.ability.extra.generated then

			local selectedstring = ''

			-- Effects groups

			-- 1 : Basic Bonus cards buff
			-- 2 : Basic Mult card buff
			-- 3 : Retriggers per Small Blinds skipped in run
			-- 4 : End of round money based on Deck content
			-- 5 : End of round money per Small Blinds skipped
			-- 6 : End of round money per Jokers held
			-- 7 : Certain cards give +Chips for each Tarots held
			-- 8 : +Chips per Skipped Booster Packs of certain types
			

			local possiblestrings = {
				[1] = 'CARDSWHOSEMOTIFBOOSTCHIPSGRANTFORTYEXTRACHIPS',	-- [1] Bonus cards gives +40/50/60 Chips
				[2] = 'CARDSWHOSEMOTIFBOOSTCHIPSGRANTFIFTYEXTRACHIPS',
				[3] = 'CARDSWHOSEMOTIFBOOSTCHIPSGRANTSIXTYEXTRACHIPS',

				[4] = 'SMALLBLINDSKIPSGIVESPRIMERANKSCARDSEXTRAPROCS',	-- [3] Retrigger prime ranked cards (2, 3, 5, 7) once for every Small Blinds skipped this run
				[5] = 'SMALLBLINDSKIPSGIVESEVERYCOURTCARDSEXTRAPROCS',	-- [3] Retrigger face cards once for every Small Blinds skipped this run

				[6] = 'SMALLBLINDSKIPSGIVESEVERYCLUBSCARDSEXTRAPROCS',	-- [3] Retrigger Clubs/Hearts/Spade cards once for every Small Blinds skipped this run
				[7] = 'SMALLBLINDSKIPSGIVESEVERYHEARTCARDSEXTRAPROCS',
				[8] = 'SMALLBLINDSKIPSGIVESEVERYSPADECARDSEXTRAPROCS',

				[9] = 'BLINDBONUSPRIZEMONEYEQUALDECKSSTONECARDSTOTAL',	-- [4] Earn $1 for each Stone/Steel/Bonus card in your full deck at end of blind
				[10] = 'BLINDBONUSPRIZEMONEYEQUALDECKSSTEELCARDSTOTAL',
				[11] = 'BLINDBONUSPRIZEMONEYEQUALDECKSBONUSCARDSTOTAL',

				[12] = 'EVERYTHREECLUBSCARDSGRANTEXTRABLINDBONUSMONEY',	-- [4] Earn $1 for every 3 Clubs/Spades/Hearts card in your full deck at end of blind
				[13] = 'EVERYTHREESPADECARDSGRANTEXTRABLINDBONUSMONEY',
				[14] = 'EVERYTHREEHEARTCARDSGRANTEXTRABLINDBONUSMONEY',

				[15] = 'COURTCARDSGIVESFORTYTIMESTAROTCARDSOWNEDCHIPS',	-- [7] Face cards gives +40/50/60 Chips for each Tarots held
				[16] = 'COURTCARDSGIVESFIFTYTIMESTAROTCARDSOWNEDCHIPS',
				[17] = 'COURTCARDSGIVESSIXTYTIMESTAROTCARDSOWNEDCHIPS',

				[18] = 'CLUBSCARDSGIVESFORTYTIMESTAROTCARDSOWNEDCHIPS',	-- [7] Clubs/Hearts/Spade cards gives +40 Chips for each Tarots held
				[19] = 'HEARTCARDSGIVESFORTYTIMESTAROTCARDSOWNEDCHIPS',
				[20] = 'SPADECARDSGIVESFORTYTIMESTAROTCARDSOWNEDCHIPS',

				[21] = 'CLUBSCARDSGIVESFIFTYTIMESTAROTCARDSOWNEDCHIPS',	-- [7] Clubs/Hearts/Spade cards gives +50 Chips for each Tarots held
				[22] = 'HEARTCARDSGIVESFIFTYTIMESTAROTCARDSOWNEDCHIPS',
				[23] = 'SPADECARDSGIVESFIFTYTIMESTAROTCARDSOWNEDCHIPS',

				[24] = 'CLUBSCARDSGIVESSIXTYTIMESTAROTCARDSOWNEDCHIPS', -- [7] Clubs/Hearts/Spade cards gives +60 Chips for each Tarots held
				[25] = 'HEARTCARDSGIVESSIXTYTIMESTAROTCARDSOWNEDCHIPS',
				[26] = 'SPADECARDSGIVESSIXTYTIMESTAROTCARDSOWNEDCHIPS',

				[27] = 'BLINDBONUSPRIZEMONEYEQUALTOTALSMALLBLINDSKIPS',	-- [5] Earn $1/$2 for every Small Blinds skipped this run at end of Blind
				[28] = 'BLINDBONUSPRIZEMONEYEQUALTWICESMALLBLINDSKIPS',

				[29] = 'CARDSWHOSEMOTIFGIVESMULTSGRANTSEVENEXTRAMULTS',	-- [2] Mult cards give +7/+8 Mult
				[30] = 'CARDSWHOSEMOTIFGIVESMULTSGRANTEIGHTEXTRAMULTS',

				[31] = 'CARDSWHOSEMOTIFGIVESMULTSGRANTFORTYEXTRACHIPS',	-- [2] Mult cards give +40/50/60 Chips
				[32] = 'CARDSWHOSEMOTIFGIVESMULTSGRANTFIFTYEXTRACHIPS',
				[33] = 'CARDSWHOSEMOTIFGIVESMULTSGRANTSIXTYEXTRACHIPS',

				[34] = 'CARDSWHOSEMOTIFBOOSTCHIPSGRANTSEVENEXTRAMULTS',	-- [1] Bonus cards give +7/+8 Mult
				[35] = 'CARDSWHOSEMOTIFBOOSTCHIPSGRANTEIGHTEXTRAMULTS',

				[36] = 'PRIMERANKSGIVESFORTYTIMESTAROTCARDSOWNEDCHIPS',	-- [7] Prime ranked cards (2, 3, 5, 7) gives +40/50/60 Chips for each Tarots held
				[37] = 'PRIMERANKSGIVESFIFTYTIMESTAROTCARDSOWNEDCHIPS',
				[38] = 'PRIMERANKSGIVESSIXTYTIMESTAROTCARDSOWNEDCHIPS',

				[39] = 'BLINDBONUSPRIZEMONEYEQUALTOTALJOKERCARDSOWNED',	-- [6] Earn $1/$2 for each Jokers held at end of blind
				[40] = 'BLINDBONUSPRIZEMONEYEQUALTWICEJOKERCARDSOWNED',

				[41] = 'GIVESCHIPSEQUALFORTYTIMESTAROTPACKSSKIPSTOTAL',	-- [8] +40/50/60 Chips for each Arcana Packs skipped this run
				[42] = 'GIVESCHIPSEQUALFIFTYTIMESTAROTPACKSSKIPSTOTAL',
				[43] = 'GIVESCHIPSEQUALSIXTYTIMESTAROTPACKSSKIPSTOTAL',

				[44] = 'GIVESCHIPSEQUALFORTYTIMESJOKERPACKSSKIPSTOTAL',	-- [8] +40/50/60 Chips for each Buffoon Packs skipped this run
				[45] = 'GIVESCHIPSEQUALFIFTYTIMESJOKERPACKSSKIPSTOTAL',
				[46] = 'GIVESCHIPSEQUALSIXTYTIMESJOKERPACKSSKIPSTOTAL',

			}

			card.ability.extra.selectedID = pseudorandom("hangedMan_secretMessage", 1, 46)

			selectedstring = possiblestrings[card.ability.extra.selectedID]
			
			for i = 1, 45, 1 do card.ability.extra.fullstring[i] = selectedstring:sub(i, i) end

			HangedMan.better_pseudoshuffle(card.ability.extra.unrevealedindex, pseudoseed("hangedMan_secretMessage"))

			card.ability.extra.generated = true

		end
	end,


	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

	
		if context.individual and context.cardarea == G.play then

			if context.other_card.debuff then
				return {
					message = localize('k_debuffed'),
					colour = G.C.RED
				}
			end
		
			if context.other_card:get_id() == 8 and #card.ability.extra.unrevealedindex > 0  then
				card.ability.extra.revealedstring[card.ability.extra.unrevealedindex[#card.ability.extra.unrevealedindex]] = card.ability.extra.fullstring[card.ability.extra.unrevealedindex[#card.ability.extra.unrevealedindex]]
				table.remove(card.ability.extra.unrevealedindex)
			end

			
			if card.ability.extra.selectedID > 0 and card.ability.extra.selectedID < 4 
			and SMODS.has_enhancement(context.other_card, 'm_bonus') then
				local chips = 40 + (10*(card.ability.extra.selectedID - 1))
				return {chips = chips}
			end

			if card.ability.extra.selectedID == 4 and G.GAME.small_blind_skipped_this_run and G.GAME.small_blind_skipped_this_run > 0 and
			context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 or context.other_card:get_id() == 7 then
				return {
					message = 'Again!',
					repetitions = (G.GAME.small_blind_skipped_this_run or 0),
					card = context.other_card
				}
			end

			if card.ability.extra.selectedID == 5 and G.GAME.small_blind_skipped_this_run and G.GAME.small_blind_skipped_this_run > 0 and
			context.other_card:is_face() then
				return {
					message = 'Again!',
					repetitions = (G.GAME.small_blind_skipped_this_run or 0),
					card = context.other_card
				}
			end

			if card.ability.extra.selectedID > 5 and card.ability.extra.selectedID < 9
			and G.GAME.small_blind_skipped_this_run and G.GAME.small_blind_skipped_this_run > 0 then
				local suitlist = {'Clubs','Hearts','Spades'}
				local suit = suitlist[card.ability.extra.selectedID - 5]

				if context.other_card:is_suit(suit) then
					return {
						message = 'Again!',
						repetitions = (G.GAME.small_blind_skipped_this_run or 0),
						card = context.other_card
					}
				end
				
			end

			if card.ability.extra.selectedID > 14 and card.ability.extra.selectedID < 18 and context.other_card:is_face() then
				local chips = 40 + (10*(card.ability.extra.selectedID - 15))
				local tarot_count = 0
				for i = 1, #G.consumeables.cards do
					if G.consumeables.cards[i].ability.set == 'Tarot' then tarot_count = tarot_count + 1 end
				end
				if tarot_count > 0 then return {chips = chips * tarot_count} end
			end

			if card.ability.extra.selectedID > 17 and card.ability.extra.selectedID < 27 then
				local suitlist = {'Clubs','Hearts','Spades'}
				local suit = suitlist[((card.ability.extra.selectedID - 18) % 3) + 1]
				local chips = 40 + (10 * math.floor((card.ability.extra.selectedID - 18)/3))

				local tarot_count = 0
				for i = 1, #G.consumeables.cards do
					if G.consumeables.cards[i].ability.set == 'Tarot' then tarot_count = tarot_count + 1 end
				end
				if tarot_count > 0 and context.other_card:is_suit(suit) then return {chips = chips * tarot_count} end
			end

			if card.ability.extra.selectedID > 28 and card.ability.extra.selectedID < 31 
			and SMODS.has_enhancement(context.other_card, 'm_mult') then
				local mult = 7 + (card.ability.extra.selectedID - 29)
				return {mult = mult}
			end

			if card.ability.extra.selectedID > 30 and card.ability.extra.selectedID < 34
			and SMODS.has_enhancement(context.other_card, 'm_mult') then
				local chips = 40 + (10*(card.ability.extra.selectedID - 31))
				return {chips = chips}
			end

			if card.ability.extra.selectedID > 33 and card.ability.extra.selectedID < 36 
			and SMODS.has_enhancement(context.other_card, 'm_bonus') then
				local mult = 7 + (card.ability.extra.selectedID - 34)
				return {mult = mult}
			end

			if card.ability.extra.selectedID > 35 and card.ability.extra.selectedID < 39
			and context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 5 or context.other_card:get_id() == 7 then
				local chips = 40 + (10*(card.ability.extra.selectedID - 36))
				local tarot_count = 0
				for i = 1, #G.consumeables.cards do
					if G.consumeables.cards[i].ability.set == 'Tarot' then tarot_count = tarot_count + 1 end
				end
				if tarot_count > 0 then return {chips = chips * tarot_count} end
			end

		end

		if context.joker_main and not context.debuff then
			
			if card.ability.extra.selectedID > 40 and card.ability.extra.selectedID < 44 then
				local chips = 40 + (10*(card.ability.extra.selectedID - 41))
				local arcana = G.GAME.boosters_packs_skipped['Arcana'] or 0
				if arcana > 0 then return { chips = chips * arcana } end
			end

			if card.ability.extra.selectedID > 43 and card.ability.extra.selectedID < 47 then
				local chips = 40 + (10*(card.ability.extra.selectedID - 44))
				local buffoon = G.GAME.boosters_packs_skipped['Buffoon'] or 0
				if buffoon > 0 then return { chips = chips * buffoon } end
			end

		end

	end,


	calc_dollar_bonus = function(self, card)

		if card.ability.extra.selectedID > 8 and card.ability.extra.selectedID < 12 then
			local enhancelist = {'m_stone','m_steel','m_bonus'}
			local enhance = enhancelist[card.ability.extra.selectedID - 8]

			local enhancetally = 0
			if G.playing_cards then
				for _, playing_card in ipairs(G.playing_cards) do
					if SMODS.has_enhancement(playing_card, enhance) then enhancetally = enhancetally + 1 end
				end
			end

			if enhancetally > 0 then return enhancetally end
		end

		if card.ability.extra.selectedID > 11 and card.ability.extra.selectedID < 15 then
			local suitlist = {'Clubs','Spades','Hearts'}
			local suit = suitlist[card.ability.extra.selectedID - 11]

			local suittally = 0
			if G.playing_cards then
				for _, playing_card in ipairs(G.playing_cards) do
					if playing_card:is_suit(suit) then suittally = suittally + 1 end
				end
			end

			if suittally > 2 then return math.floor(suittally/3) end
		end

		if card.ability.extra.selectedID == 27 or card.ability.extra.selectedID == 28 and G.GAME.small_blind_skipped_this_run and G.GAME.small_blind_skipped_this_run > 0 then
			return G.GAME.small_blind_skipped_this_run * (card.ability.extra.selectedID - 26)
		end

		if card.ability.extra.selectedID == 39 or card.ability.extra.selectedID == 40 and G.jokers.cards then
			local joker_count = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.set == 'Joker' then joker_count = joker_count + 1 end
			end
			if joker_count > 0 then return joker_count * (card.ability.extra.selectedID - 38) end
		end

	end
}






