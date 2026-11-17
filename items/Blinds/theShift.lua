SMODS.Blind {
    key = "theShift",
    dollars = 5,
    mult = 2,
    atlas = 'HangedMan_BlindChips',
    pos = { x = 0, y = 6 },
    boss = { min = 3 },
    discovered = false,
    boss_colour = HEX("35a057"),
    debuff = {
        HangedMan_shift_chance_denominator = 5
    },
    attributes = {'suit', 'rank', 'modify_card', 'chance'},

    loc_vars = function (self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, self.debuff.HangedMan_shift_chance_denominator, 'hangedman_theShift')
        return {
            vars = {
                numerator, denominator
            }
        }
    end,
    collection_loc_vars = function (self)
        return {
            vars = {
               1, self.debuff.HangedMan_shift_chance_denominator
            }
        }
    end,
    disable = function (self)
       
    end,
    set_blind = function (self)
        
    end,

    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.stay_flipped and context.to_area == G.hand and SMODS.pseudorandom_probability(blind, 'hangedman_theShift', 1, self.debuff.HangedMan_shift_chance_denominator)
        and (((not SMODS.has_no_suit(context.other_card)) and (not SMODS.has_any_suit(context.other_card))) or (not SMODS.has_no_rank(context.other_card))) then

            local playing_card = context.other_card
            local suits = SMODS.Suits
            local ranks = SMODS.Ranks
            local suitchange = nil
            local rankchange = nil

            if (not SMODS.has_no_suit(playing_card)) and (not SMODS.has_any_suit(playing_card)) then
                if HangedMan.indexOf(suits, playing_card.base.suit) then table.remove(suits, HangedMan.indexOf(suits, playing_card.base.suit)) end
                suitchange = (pseudorandom_element(suits, pseudoseed('theSuitShift'))).key
            end

            if not SMODS.has_no_rank(playing_card) then
                if HangedMan.indexOf(ranks, playing_card:get_id()) then table.remove(ranks, HangedMan.indexOf(ranks, playing_card:get_id())) end
                rankchange = (pseudorandom_element(ranks, pseudoseed('theRankShift'))).key
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                        playing_card:flip()
                        assert(SMODS.change_base(playing_card, suitchange, rankchange))
                        playing_card:juice_up(0.3, 0.3)
                        play_sound('tarot1', 0.8, 0.4)
                    return true
                end
            }))
            delay(0.25)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = function()
                        playing_card:flip()
                        playing_card:juice_up(0.3, 0.3)
                        play_sound('tarot2', 0.8, 0.6)
                    return true
                end
            }))
            delay(0.2)

        end

    end,

}