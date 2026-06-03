SMODS.Joker {
	-- How the code refers to the joker.
	key = 'cyclomancy',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	config = { extra = { xmult = 1, increment = 0.1, full_stack = {{'[rank]','[suit]'}}, index = 1 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		local aoran = 'a'
		local suitcol = G.C.FILTER
		local rank = '[rank]'
		local suit = '[suit]'
		if G.GAME.cyclomancy_stack then 
			rank = (G.GAME.cyclomancy_stack[card.ability.extra.index])[1]
			suit = (G.GAME.cyclomancy_stack[card.ability.extra.index])[2]
		end
		if rank == 14 then rank = 'Ace' elseif rank == 13 then rank = 'King' elseif rank == 12 then rank = 'Queen' elseif rank == 11 then rank = 'Jack' end
		if not (suit == '[suit]') then suitcol = G.C.SUITS[suit] end
		if card.ability and rank == 8 or rank == 14 then aoran = 'an' end
        return { vars = { rank, suit, card.ability.extra.increment, card.ability.extra.xmult, aoran, colours = { suitcol } } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 5 },
	-- Cost of card in shop.
	cost = 8,

	


	add_to_deck = function(self, card, from_debuff)

		G.GAME.cyclomancy_active = G.GAME.cyclomancy_active or true

		-- Stack generation code, from when each Cyclomancies used to have their own individual stack instead of one global stack
		--[[
		if not from_debuff and #G.GAME.cyclomancy_stack < 52 then
			local stackKey = {
			'stebbin',
			'gauci',
			'harding',
			'threat',
			'osterlind'
			}
			local stack = pseudorandom_element(stackKey, pseudoseed('stackmaker'))
			if stack == 'harding' then
				-- constructor for Bart Harding
				local suitorder = {'Clubs', 'Hearts', 'Spades', 'Diamonds'}
				local rank = 14
				local suit = 1
				local pos = 1
				for i = 1, 52, 1 do
					pos = ((i % 10)*10) + math.floor(i/10)
					if pos < 52 then pos = pos - 45 end
					G.GAME.cyclomancy_stack[pos] = {rank,suitorder[suit]}
					if rank == 13 then suit = suit + 1 end
					if rank == 14 then rank = 2 else rank = rank + 1 end
				end

			elseif stack == 'stebbin' or stack == 'gauci' then
				-- constructor for Si Stebbins & Charles Gauci
				local rank = pseudorandom(pseudoseed('stackmaker'), 2, 14)
				local suitorder = {'Clubs', 'Hearts', 'Spades', 'Diamonds'}
				if stack == 'gauci' then
					suitorder[1] = 'Spades'
					suitorder[3] = 'Clubs'
				end
				local suit = pseudorandom(pseudoseed('stackmaker'), 1, 4)
				
				for i = 1, 52, 1 do
					G.GAME.cyclomancy_stack[i] = {rank,suitorder[suit]}
					if rank > 12 then rank = rank - 10 else rank = rank + 3 end
					if suit == 4 then suit = 1 else suit = suit + 1 end
				end

			elseif stack == 'threat' then
				-- constructor for Eight Threatening Kings
				local rankorder = {8, 13, 3, 10, 2, 7, 9, 5, 12, 4, 14, 6, 11}
				local suitorder = {'Clubs', 'Hearts', 'Spades', 'Diamonds'}
				local rank = pseudorandom(pseudoseed('stackmaker'), 1, 13)
				local suit = pseudorandom(pseudoseed('stackmaker'), 1, 4)

				for i = 1, 52, 1 do
					G.GAME.cyclomancy_stack[i] = {rankorder[rank],suitorder[suit]}
					if rank == 13 then rank = 1 else rank = rank + 1 end
					if suit == 4 then suit = 1 else suit = suit + 1 end
				end
			
			elseif stack == 'osterlind' then
				-- constructor for Osterlind Breakthrough Card System

				local suitorder = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
				local rankorder = {14, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}
				local rank = pseudorandom(pseudoseed('stackmaker'), 1, 13)
				local suit = pseudorandom(pseudoseed('stackmaker'), 1, 4)

				for i = 1, 52, 1 do
					G.GAME.cyclomancy_stack[i] = {rankorder[rank],suitorder[suit]}
					rank = (rank * 2) + suit
					while rank > 13 do rank = rank - 13 end

					if rank < 4 then
					elseif rank > 9 then suit = suit + 1
					elseif rank > 6 then suit = suit - 1
					elseif rank > 3 and suit > 2 then suit = suit - 2
					elseif rank > 3 and suit < 3 then suit = suit + 2 end
					if suit > 4 then suit = 1 end
					if suit < 1 then suit = 4 end

				end

			end

			--print(G.GAME.cyclomancy_stack)

		end
		]]
	end,
	

	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.individual and context.cardarea == G.play and
        	context.other_card:get_id() == G.GAME.cyclomancy_stack[card.ability.extra.index][1] and
            context.other_card:is_suit(G.GAME.cyclomancy_stack[card.ability.extra.index][2]) then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.increment
				if card.ability.extra.index == 52 then card.ability.extra.index = 1 else card.ability.extra.index = card.ability.extra.index +1 end
				return {
					message = 'Next!',
					colour = G.C.BLUE,
					card = card
				}
        end

		if context.joker_main and card.ability.extra.xmult > 1 then
			return {
                xmult = card.ability.extra.xmult
            }
		end
	end
}