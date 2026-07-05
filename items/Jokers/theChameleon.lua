SMODS.Joker {
	-- How the code refers to the joker.
	key = 'theChameleon',
    unlocked = false,
    -- discovered = false,
	blueprint_compat = false,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'The Chameleon',
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
			"Discarding {C:attention}1{} {C:mult}Wild Card{} with",
			"{C:attention}1{} other non-Wild card",
			"converts other held",
			"cards to that suit"
		},
		unlock ={
			"Discard {C:attention}5{}",
			"{C:mult}Wild Cards{}",
			"at once"
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { suitFound = '', wildFound = 0, applyColourChange = false } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS["m_wild"]
		return { vars = { card.ability.extra.suitFound, card.ability.extra.wildFound, card.ability.extra.applyColourChange } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	attributes = {'discard', 'enhancements', 'modify_card', 'suit', 'hearts', 'spades', 'diamonds', 'clubs'},
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.pre_discard and not context.blueprint then
			card.ability.extra.wildFound = 0
			card.ability.extra.suitFound = ''
			card.ability.extra.applyColourChange = false

			for i,v in ipairs(G.hand.highlighted) do

				if SMODS.has_any_suit(v) and not v.debuff then
					card.ability.extra.wildFound = card.ability.extra.wildFound + 1
				else
					card.ability.extra.suitFound = v.base.suit
				end
				
			end

			if #context.full_hand == 2 and card.ability.extra.wildFound == 1 then
				card.ability.extra.applyColourChange = true
			end

		end

		if context.discard and not context.blueprint and card.ability.extra.applyColourChange then

			for i, v in ipairs(G.hand.cards) do
				local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
				--SMODS.change_base(v,card.ability.extra.suitFound,nil)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
							v:flip()
							v:change_suit(card.ability.extra.suitFound)
							v:juice_up(0.3, 0.3)
							play_sound('tarot1', percent, 0.4)
						return true
					end
				}))
				delay(0.2)
			end
			delay(0.35)
			for i, v in ipairs(G.hand.cards) do
				local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
				--SMODS.change_base(v,card.ability.extra.suitFound,nil)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
							v:flip()
							v:juice_up(0.3, 0.3)
							play_sound('tarot2', percent, 0.6)
						return true
					end
				}))
				delay(0.2)
			end
			card.ability.extra.applyColourChange = false
			return {
				message = 'Converted!',
				card = card
			}
		end
	end,


	locked_loc_vars = function(self, info_queue, card)
		return {
			vars = {

			}
		}
	end,


	-- unlock function
	-- The Chameleon : Discard 5 Wild Cards at the same time.
	check_for_unlock = function(self, args)
        if args.type == 'discard_custom' then
            local tally = 0
            for i = 1, #args.cards do
                if SMODS.has_any_suit(args.cards[i]) then
                    tally = tally + 1
                end
                if tally >= 5 then
					unlock_card(self)
                end
            end
        end
    end

}