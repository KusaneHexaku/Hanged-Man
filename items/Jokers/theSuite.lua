SMODS.Joker {
	-- How the code refers to the joker.
	key = 'theSuite',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
    allow_duplicates = false,
	-- loc_text is the actual name and description that show in-game for the card.

	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { anchorSuit = "[suit]", followSuit = "[suit]", suiteState = "Follow Suite", repetitions = 0,
    stateNames ={
        ['ClubsHearts'] = "The Coyish",
        ['ClubsSpades'] = "The Cosmos",
        ['ClubsDiamonds'] = "The Coward",
        ['HeartsClubs'] = "The Heroic",
        ['HeartsSpades'] = "The Hubris",
        ['HeartsDiamonds'] = "The Horrid",
        ['SpadesClubs'] = "The Scenic",
        ['SpadesHearts'] = "The Sleuth",
        ['SpadesDiamonds'] = "The Sacred",
        ['DiamondsClubs'] = "The Dyadic",
        ['DiamondsHearts'] = "The Dovish",
        ['DiamondsSpades'] = "The Demiss",
    },
    spriteX ={
        ['ClubsHearts'] = 0,
        ['ClubsSpades'] = 1,
        ['ClubsDiamonds'] = 2,
        ['HeartsClubs'] = 3,
        ['HeartsSpades'] = 4,
        ['HeartsDiamonds'] = 5,
        ['SpadesClubs'] = 0,
        ['SpadesHearts'] = 1,
        ['SpadesDiamonds'] = 2,
        ['DiamondsClubs'] = 3,
        ['DiamondsHearts'] = 4,
        ['DiamondsSpades'] = 5,
        ['[suit][suit]'] = 0
    },
    spriteY ={
        ['ClubsHearts'] = 1,
        ['ClubsSpades'] = 1,
        ['ClubsDiamonds'] = 1,
        ['HeartsClubs'] = 1,
        ['HeartsSpades'] = 1,
        ['HeartsDiamonds'] = 1,
        ['SpadesClubs'] = 2,
        ['SpadesHearts'] = 2,
        ['SpadesDiamonds'] = 2,
        ['DiamondsClubs'] = 2,
        ['DiamondsHearts'] = 2,
        ['DiamondsSpades'] = 2,
        ['[suit][suit]'] = 0
    },
    textColours ={
        ['Clubs'] = G.C.SUITS.Clubs,
        ['Hearts'] = G.C.SUITS.Hearts,
        ['Spades'] = G.C.SUITS.Spades,
        ['Diamonds'] = G.C.SUITS.Diamonds,
        ['[suit]'] = G.C.UI.JOKER_GREY
    }

    } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
        local loc_key = 'j_hangedman_theSuite'
        if card.ability then loc_key = loc_key .. '_' .. card.ability.extra.anchorSuit .. card.ability.extra.followSuit end
        if loc_key == 'j_hangedman_theSuite_[suit][suit]' then loc_key = 'j_hangedman_theSuite' end
		return {
            key = loc_key,
            vars = { card.ability.extra.anchorSuit, card.ability.extra.followSuit, card.ability.extra.suiteState, card.ability.extra.stateNames,
            colours = { card.ability.extra.textColours[card.ability.extra.anchorSuit], card.ability.extra.textColours[card.ability.extra.followSuit] }
        },
            

        }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_TheSuite',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 7,
    attributes = {'retrigger', 'suit', 'clubs', 'hearts', 'spades', 'diamonds'},
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

        if context.setting_blind then

            local suiteSuitSelection = {'Clubs','Hearts','Spades','Diamonds'}

	        for i, v in ipairs(suiteSuitSelection) do
		        local j = pseudorandom_element({1,2,3,4}, pseudoseed('theSuite'))
		        suiteSuitSelection[i], suiteSuitSelection[j] = suiteSuitSelection[j], suiteSuitSelection[i]
	        end

	        card.ability.extra.anchorSuit = suiteSuitSelection[1] 
	        card.ability.extra.followSuit = suiteSuitSelection[4] 
            card.ability.extra.suiteState = card.ability.extra.stateNames[card.ability.extra.anchorSuit .. card.ability.extra.followSuit]

            G.E_MANAGER:add_event(Event({
                blockable = false,
                trigger = 'immediate',
                func = function()
                        card:juice_up()
                        card.children.center:set_sprite_pos({x = card.ability.extra.spriteX[card.ability.extra.anchorSuit .. card.ability.extra.followSuit], y = card.ability.extra.spriteY[card.ability.extra.anchorSuit .. card.ability.extra.followSuit]})
                        play_sound('tarot1', 0.8, 0.4)
                    return true
                end
            }))


            

        end

        if context.cardarea == G.play and context.repetition and not context.repetition_only and not context.other_card.debuff then

            local tempIndex={}
            for k,v in pairs(context.scoring_hand) do
                tempIndex[v]=k
            end

			if context.other_card:is_suit(card.ability.extra.anchorSuit) then
                local anchorSuite = context.other_card
                card.ability.extra.repetitions = 0

                for i, v in ipairs(context.scoring_hand) do
                    if v:is_suit(card.ability.extra.followSuit) and tempIndex[anchorSuite] < tempIndex[v] then
                        card.ability.extra.repetitions = card.ability.extra.repetitions + 1
                    end
                end
                return {
                    message = 'Again!',
                    repetitions = card.ability.extra.repetitions,
                    card = anchorSuite
                }
		    end
        end

        if context.after and not context.blueprint then
            local suiteSuitSelection = {'Clubs','Hearts','Spades','Diamonds'}

            for i, v in ipairs(suiteSuitSelection) do
                local j = pseudorandom_element({1,2,3,4}, pseudoseed('theSuite'))
                suiteSuitSelection[i], suiteSuitSelection[j] = suiteSuitSelection[j], suiteSuitSelection[i]
            end

            card.ability.extra.anchorSuit = suiteSuitSelection[1] 
            card.ability.extra.followSuit = suiteSuitSelection[4] 
            card.ability.extra.suiteState = card.ability.extra.stateNames[card.ability.extra.anchorSuit .. card.ability.extra.followSuit]

            G.E_MANAGER:add_event(Event({
                blockable = false,
                trigger = 'after',
                func = function()
                        card:juice_up()
                        card.children.center:set_sprite_pos({x = card.ability.extra.spriteX[card.ability.extra.anchorSuit .. card.ability.extra.followSuit], y = card.ability.extra.spriteY[card.ability.extra.anchorSuit .. card.ability.extra.followSuit]})
                        play_sound('tarot1', 0.8, 0.4)
                    return true
                end
            }))

        end


    end,

    set_sprites = function(self, card, front)
		G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                if card.ability then card.children.center:set_sprite_pos({x = card.ability.extra.spriteX[card.ability.extra.anchorSuit .. card.ability.extra.followSuit], y = card.ability.extra.spriteY[card.ability.extra.anchorSuit .. card.ability.extra.followSuit]}) end
                return true
            end
        }))
	end



}

