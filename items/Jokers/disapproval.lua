SMODS.Joker {
	-- How the code refers to the joker.
	key = 'disapproval',
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Disapproval',
		text = {
			--[[
			The #1# is a variable that's stored in config, and is put into loc_vars.
			The {C:} is a color modifier, and uses the color "mult" for the "+#1# " part, and then the empty {} is to reset all formatting, so that Mult remains uncolored.
				There's {X:}, which sets the background, usually used for XMult.
				There's {s:}, which is scale, and multiplies the text size by the value, like 0.8
				There's one more, {V:1}, but is more advanced, and is used in Castle and Ancient Jokers. It allows for a variable to dynamically change the color. You can find an example in the Castle joker if needed.
				Multiple variables can be used in one space, as long as you separate them with a comma. {C:attention, X:chips, s:1.3} would be the yellow attention color, with a blue chips-colored background,, and 1.3 times the scale of other text.
				You can find the vanilla joker descriptions and names as well as several other things in the localization files.
				]]


			--[["When discarding {C:attention}1{} card,",
            "subtract {C:attention}2{} from its rank",
            "If rank becomes 1 or lower,",
            "destroy the card"]]

			"When discarding {C:attention}1{} card,",
            "subtract {C:attention}2{} from its rank"
			
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = {cardsDiscarded = 0, rankFound = 0} },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Disapproval',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	--pos = { x = 0, y = 5 },
	-- Cost of card in shop.
	cost = 7,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	attributes = {'discard', 'modify_card'},
	calculate = function(self, card, context)

		if context.pre_discard and not context.blueprint then
			card.ability.extra.cardsDiscarded = 0
			card.ability.extra.rankFound = 0

			for i,v in ipairs(G.hand.highlighted) do
				card.ability.extra.cardsDiscarded = card.ability.extra.cardsDiscarded + 1
				if v:get_id() then card.ability.extra.rankFound = v:get_id() else card.ability.extra.rankFound = nil end
			end

		end

		if context.discard and card.ability.extra.cardsDiscarded == 1 and card.ability.extra.rankFound then

			for i, v in ipairs(G.hand.highlighted) do
				--SMODS.change_base(v,card.ability.extra.suitFound,nil)

				if card.ability.extra.rankFound == 2 or card.ability.extra.rankFound == 3 then
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
								assert(SMODS.modify_rank(v, 11))
								v:juice_up()
								play_sound('tarot1', 0.8, 0.4)
							return {message = '-2'}
						end
					}))
				else
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
								assert(SMODS.modify_rank(v, -2))
								v:juice_up()
								play_sound('tarot1', 0.8, 0.4)
							return {message = '-2'}
						end
					}))
				end
					
				-- old behaviour where if rank goes below 1, card is destroyed	

				--[[if card.ability.extra.rankFound - 2 > 1 then
					G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
								assert(SMODS.modify_rank(v, -2))
								v:juice_up()
								play_sound('tarot1', 0.8, 0.4)
							return true
						end
					}))
				else
					if SMODS.shatters(v) then
						v:shatter()
					else
						v:start_dissolve()
					end
					return {
						remove = true
					}
				end]]

				
			end
		end

		--[[if context.destroy_card then
                return {
                    remove = true
                }
            end]]
		

		

	end,


	-- animated sprite written VERY jankily :3

	--[[
	update = function(self, card, dt)

		disapproval_SpriteStep = disapproval_SpriteStep or 0
		disapproval_randomTick = disapproval_randomTick or 0

		card.children.center:set_sprite_pos({x = disapproval_SpriteStep, y = 5})

    	if (disapproval_SpriteStep >= 3 and disapproval_randomTick >= 100) then
			disapproval_SpriteStep = 0
			disapproval_randomTick = 0
		elseif (disapproval_SpriteStep < 3 and disapproval_randomTick >= 100) then
			disapproval_SpriteStep = disapproval_SpriteStep + 1
			disapproval_randomTick = 0
		else
			disapproval_randomTick = disapproval_randomTick + math.random(4)
		end
	end

	]]


}
