SMODS.Blind {
    key = "theStutter",
    dollars = 5,
    mult = 2,
    atlas = 'HangedMan_BlindChips',
    pos = { x = 0, y = 1 },
    boss = { min = 1 },
    discovered = false,
    boss_colour = HEX("4f4f4f"),
    debuff = {
        HangedMan_theStutter_mult = 1.5
    },
    attributes = {'retrigger'},

    loc_vars = function (self)
        return {
            vars = {
                self.debuff.HangedMan_theStutter_mult
            }
        }
    end,
    collection_loc_vars = function (self)
        return {
            vars = {
                self.debuff.HangedMan_theStutter_mult
            }
        }
    end,
    disable = function (self)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            func = function ()
                G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * self.mult * G.GAME.starting_params.ante_scaling
                return true
            end
        }))
    end,

    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.press_play then
            for i = 1, #G.play.cards do
                G.play.cards[i].theStutter_retrigFlag = nil
            end
            for i = 1, #G.hand.cards do
                G.hand.cards[i].theStutter_retrigFlag = nil
            end
        end

        if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) then
            if context.other_card.theStutter_retrigFlag then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    func = function ()
                        G.GAME.blind.chips = G.GAME.blind.chips * self.debuff.HangedMan_theStutter_mult
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:get_UIE_by_ID("HUD_blind_count"):juice_up()
                        play_sound('timpani')
                        return true
                    end
                }))
                blind.triggered = true
            end
            context.other_card.theStutter_retrigFlag = true
        end

        if context.after then
            for i = 1, #G.play.cards do
                G.play.cards[i].theStutter_retrigFlag = nil
            end
            for i = 1, #G.hand.cards do
                G.hand.cards[i].theStutter_retrigFlag = nil
            end
        end
    end
}