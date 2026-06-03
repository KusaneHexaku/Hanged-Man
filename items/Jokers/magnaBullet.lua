SMODS.Joker {
	-- How the code refers to the joker.
	key = 'magnaBullet',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Magna Bullet',
		text = {
			"Played cards gives {C:attention}triple{} their {C:chips}base chips{}",
			"when scored, then permanently lose {C:attention}#1#{} {C:chips}base chips{}.",
			"Destroy played cards when they reach {C:attention}0{} {C:chips}base chips{}.",
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { decrement = 1 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.decrement } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Magna',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)

		if context.individual and context.cardarea == G.play and not context.other_card.debuff then
			context.other_card.toBullet = true
			return {
				chips = context.other_card.base.nominal*3
			}
		end

		if context.after and not context.blueprint then
			for _i, c in ipairs(context.full_hand) do
				if c.toBullet and c.base.nominal - card.ability.extra.decrement < 1 then 
					G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						c:juice_up(0.3, 0.5)
						play_sound('tarot1', 0.8, 0.4)
						if SMODS.shatters(c) then c:shatter() else c:start_dissolve() end
						return { remove = true }
					end
					}))
				elseif c.toBullet then 
					G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						c:juice_up(0.3, 0.5)
						play_sound('tarot1', 0.8, 0.4)
						c.base.nominal = c.base.nominal - card.ability.extra.decrement
						c.toBullet = nil
						return { message = 'Downgrade!', color = G.C.BLUE }
					end
					}))
				end
				delay(0.2)
			end
		end

	end
}