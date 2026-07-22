SMODS.current_mod.calculate = function(self, context)

    -- Initialising the Secret Key for The Colour of Money on a new Save File
    G.PROFILES[G.SETTINGS.profile]["colourOfMoneyKey"] = G.PROFILES[G.SETTINGS.profile]["colourOfMoneyKey"] or {}
    if #G.PROFILES[G.SETTINGS.profile]["colourOfMoneyKey"] < 1 then
        local seedlet = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}
        pseudoshuffle(seedlet, math.random(100))
        G.PROFILES[G.SETTINGS.profile]["colourOfMoneyKey"] = seedlet or {}
    end

    -- Global var relating to rarity and weights

    -- modifying weights and rarity
    if context.modify_weights then

        if context.pool_types.Joker then

            -- for jokers
            for idx, v in pairs(context.pool) do
                if not G.P_CENTERS[v.key] then  -- failsafe
                -- Boomerang : slight boost to the weight the more times it is sold
                elseif v.key == 'j_hangedman_boomerang' then context.pool[idx].weight = math.min(10 + (30 * (G.GAME.HangedMan_boomerangSellCount or 0)), 4000)
                -- Imposterous : 1600% weight boost by default, significantly boosted during the "Spot the Difference" challenge
                elseif v.key == 'j_hangedman_imposterous' then context.pool[idx].weight = (G.GAME.imposterous_challenge_rate or 160)
                elseif v.original_mod and v.original_mod.id == "Cryptid" then context.pool[idx].weight = 1
                else end -- more failsafe
            end
        end

    end

    -- Utility flag [G.GAME.prevent_shop_exit] : set to TRUE to disable the 'Next Round' button
    G.FUNCS.shop_button_function = function(e)
        if not G.GAME.prevent_shop_exit then
            e.config.colour = G.C.RED
            e.config.button = "toggle_shop"
        else
            e.config.colour = G.C.BLACK
            e.config.button = nil
        end

    end

    -- Utility flag [G.GAME.skip_shop] : set to TRUE to skip shops
    -- Utility flag [G.GAME.skip_shop_count] : set to an integer above 0 to skip that many shops
    G.GAME.skip_shop_count = G.GAME.skip_shop_count or 0
    if context.starting_shop and ((G.GAME.skip_shop) or (G.GAME.skip_shop_count > 0)) then
        G.FUNCS.toggle_shop()
        G.GAME.skip_shop_count = G.GAME.skip_shop_count - 1
        if G.GAME.skip_shop_count < 0 then G.GAME.skip_shop_count = 0 end
    end


    if context.starting_shop then   
        -- Hooking the function of the Next Round button in shop
        local node = G.shop:get_UIE_by_ID('next_round_button')
        node.config.func = "shop_button_function"
    end


    -- Track max money in current run
    G.GAME.max_money_this_run = G.GAME.max_money_this_run or 0
    local current_money = G.GAME.dollars or 0
    if current_money > G.GAME.max_money_this_run then G.GAME.max_money_this_run = current_money end


    -- set global flag for Cyclomancy's effect on other cards
    if G.jokers and G.jokers.cards then G.GAME.cyclomancy_active = G.GAME.cyclomancy_active or next(SMODS.find_card('j_hangedman_cyclomancy')) end

    -- generate Cyclomancy's stack
    G.GAME.cyclomancy_stack = G.GAME.cyclomancy_stack or {}
    if #G.GAME.cyclomancy_stack < 52 then
        
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
                if rank > 11 then rank = rank - 10 else rank = rank + 3 end
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
    end


    -- Track consumables usages
    G.GAME.consumeables_used = G.GAME.consumeables_used or {}
    if context.using_consumeable then

        --print("[HangedMan_CalcEvent] A " .. tostring(context.consumeable.config.center.key) .. " was used")
        G.GAME.consumeables_used[context.consumeable.config.center.key] = G.GAME.consumeables_used[context.consumeable.config.center.key] or 0
        G.GAME.consumeables_used[context.consumeable.config.center.key] = G.GAME.consumeables_used[context.consumeable.config.center.key] + 1

        G.GAME.consumeables_used_this_run = G.GAME.consumeables_used_this_run or 0
        G.GAME.consumeables_used_this_run = G.GAME.consumeables_used_this_run + 1

        --print("[HangedMan_CalcEvent] There has been a total of " .. tostring(G.GAME.consumeables_used_this_run) .. " consumables used this run" )

        -- Check for unlocks
        check_for_unlock({type = 'unlock_spiralOfStars'})
        check_for_unlock({type = 'unlock_foolishJoker'})
        

    end

    -- Track removing/destroying playing cards
    G.GAME.cards_destroyed_this_run = G.GAME.cards_destroyed_this_run or 0
    if context.remove_playing_cards then

        --print("[HangedMan_CalcEvent] " .. tostring(#context.removed) .." playing card was destroyed or removed")
        G.GAME.cards_destroyed_this_run = G.GAME.cards_destroyed_this_run + #context.removed

        --print("[HangedMan_CalcEvent] There has been a total of " .. tostring(G.GAME.cards_destroyed_this_run) .. " playing cards destroyed this run" )

        -- Check for unlocks
        check_for_unlock({type = 'unlock_removalService'})

    end

    if context.initial_scoring_step then

        -- Track unique hand types played in current run
        G.GAME.unique_hands_this_run = G.GAME.unique_hands_this_run or {}
        
        if indexOf(G.GAME.unique_hands_this_run, context.scoring_name) == nil then
            G.GAME.unique_hands_this_run[#G.GAME.unique_hands_this_run + 1] = context.scoring_name
            --print("[HangedMan_CalcEvent] " .. tostring(context.scoring_name) .. " has been played for the first time this run")
            --print("[HangedMan_CalcEvent] There has been a total of " .. tostring(#G.GAME.unique_hands_this_run) .. " unique hand types played this run" )
        end

        
    
        -- Check for unlocks
        check_for_unlock({type = 'unlock_rideTheTide'})
        check_for_unlock({type = 'unlock_homeIsInYourHeart', handname = context.scoring_name, cards = context.scoring_hand})

        
    end

    -- Track boosters packs skipped
    G.GAME.boosters_packs_skipped = G.GAME.boosters_packs_skipped or {}
    if context.skipping_booster then
        
        --print(tostring(context.booster.config))
        G.GAME.boosters_packs_skipped[context.booster.kind] = G.GAME.boosters_packs_skipped[context.booster.kind] or 0
        G.GAME.boosters_packs_skipped[context.booster.kind] = G.GAME.boosters_packs_skipped[context.booster.kind] + 1

        G.GAME.boosters_packs_skipped_this_run = G.GAME.boosters_packs_skipped_this_run or 0
        G.GAME.boosters_packs_skipped_this_run = G.GAME.boosters_packs_skipped_this_run + 1

        --print("[HangedMan_CalcEvent] A " .. tostring(context.booster.kind) .. " Pack was skipped")
        --print("[HangedMan_CalcEvent] There has been a total of " .. tostring(G.GAME.boosters_packs_skipped_this_run) .. " Booster Pack(s) skipped this run" )

    end

    G.GAME.small_blind_skipped_this_run = G.GAME.small_blind_skipped_this_run or 0
    G.GAME.big_blind_skipped_this_run = G.GAME.big_blind_skipped_this_run or 0

    if context.skip_blind and G.GAME.blind_on_deck == 'Big' then
        G.GAME.small_blind_skipped_this_run = G.GAME.small_blind_skipped_this_run + 1
        --print("[HangedMan_CalcEvent] A Small Blind was skipped")
        --print("[HangedMan_CalcEvent] There has been a total of " .. tostring(G.GAME.small_blind_skipped_this_run) .. " Small Blind(s) skipped this run" )
    end

    if context.skip_blind and G.GAME.blind_on_deck == 'Boss' then
        G.GAME.big_blind_skipped_this_run = G.GAME.big_blind_skipped_this_run + 1
        --print("[HangedMan_CalcEvent] A Big Blind was skipped")
        --print("[HangedMan_CalcEvent] There has been a total of " .. tostring(G.GAME.big_blind_skipped_this_run) .. " Big Blind(s) skipped this run" )
    end


    if context.before and #context.full_hand == 5 then
        local test = {8,4,6,2,14}
        local flag = true

        for i, v in ipairs(test) do
            if not (context.full_hand[i]:get_id() == v) then flag = false break end
        end

        if flag then
            return {
                message = '*click*'
            }
        end


    end

    


end

-- updating Global value a la Idol/Castle/etc.
-- function SMODS.current_mod.reset_game_globals(run_start)
-- end
