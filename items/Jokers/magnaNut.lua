SMODS.Joker {
	-- How the code refers to the joker.
	key = 'magnaNut',
    unlocked = true,
    discovered = true,
	blueprint_compat = true,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Magna Nut',
		text = {
			"Scoring {C:attention}6{} permanently gain",
			"{C:chips}+#1#{} Chips if played hand contains",
			"at least {C:attention}3{} scoring {C:attention}6{}"
		}
	},
	--[[
		Config sets all the variables for your card, you want to put all numbers here.
		This is really useful for scaling numbers, but should be done with static numbers -
		If you want to change the static value, you'd only change this number, instead
		of going through all your code to change each instance individually.
		]]
	config = { extra = { bonus = 6 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,
	-- Which atlas key to pull from.
	atlas = 'HangedMan_Magna',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)



		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 6 then
			local six_tally = 0
			for _, c in ipairs(context.scoring_hand) do
				if c:get_id() == 6 then six_tally = six_tally + 1 end
			end

            if context.other_card.debuff and six_tally > 2 then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            elseif six_tally > 2 then

				context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.bonus

				local choiceOfNounOfChoice = {
					'the Badger',
					'the 6 of Bullets',
					'the 6 of Orbs',
					'the 6 of Spades',
					'the 6 of Hearts',
					'the 6 of Clubs',
					'the 6 of Diamonds',
					'the 6 of Stars',
					'the 6 of Nuts',
					'the Eiffel Tower',
					'Jimbo',
					'the Spiral',
					'the friends we made along the way',
					'the Suits chips',
					'Hanging Chad',
					'the Hanged Man tarot',
					'Chicot',
					'Queen from Deltarune',
					'Sam Reich',
					'LocalThunk',
					'the SMODS cat',
					'the Bloody Mary',
					'the random Wikipedia article',
					'Orinda',
					'Princess Celestia',
					'the Discard pile',
					'the Special Council',
					'the Normal Council',
					'Steamodded',
					'the Chairman',
					'the Playing Out of Turn placard',
					'the Dice',
					'the face-up cards in front of me',
					'the face-down cards in front of me',
					'the red pyramid',
					'the suits compass',
					'the penalty key',
					'the Arc de Triomphe',
					'the Lourve',
					'Normalcy',
					'Normality',
					'Cambridge, the university in Cambridge, England',
					'Trinity College, the college in Cambridge, England',
					'Cambridge, the college in Cambridge, Massachusetts',
					'the Berlin wall',
					'the destruction of the Berlin wall',
					'those tandem bicycles in Amsterdam',
					'the coffee machine',
					'caffeine',
					'hail',
					'the noun of your choice',
					'the noun of my choice',
					'the Negative Eternal Egg',
					'Northernlion',
					'microwave safe plastic containers',
					'the disco ball',
					'the TAC card',
					'the TAC token',
					'the Queen of Spades',
					'the Red wire',
					'our Personal Equipments',
					'the Double Detector',
					'the Not Equal label',
					'the Walkie-Talkie',
					'the Triple Detector',
					'the Post-It Note',
					'the Super Detector',
					'the Rewinder',
					'the Emergency Batteries',
					'the General Radar',
					'the Stablizer',
					'the X-or-Y Ray',
					'the Coffee Mug',
					'the Equal label',
					'the Captain',
					'the Self-Destruct timer',
					'the Oxygen tokens',
					'the Knock Knock jokes',
					'Deez Nuts',
					'Mornington Crescents',
					'Mornington Croissants',
					'the Railway spaces',
					'Misprint\'s secret peek',
					'Keith Moon',
					'the really badly timed bald joke',
					'Marion Marigold',
					'the really awful flying taxis moons',
					'the Taskmaster',
					'the Task Manager',
					'the carcinization process',
					'the lobsters',
					'the smobsters',
					'chording',
					'the Boykisser :3',
					'the striped thigh highs I\'m wearing right now',
					'the man who speaks in hands',
					'the man who boxes the boxes',
					'the Suit Compass',
					'the Spartan',
					'the Sparta token',
					'butter chicken',
					'the high fiber wrap',
					'cottage cheese',
					'cabin chesse',
					'cabinet cheese',
					'cabonara',
					'the Sudoko game',
					'the Crusher',
					'Gibby',
					'water, the concept',
					'the nice cashier lady who complimented my nails',
					'the Tip Jar',
					'the OSHA regulations',
					'the whips and chains',
					'Slider from Super Mario 64',
					'Slider from Super Mario Galaxy',
					'Slider from Mario Kart World',
					'Spider, the solitaire',
					'spiders, the creature',
					'Spider-Man',
					'Spider Dance, the song',
					'Spider, the drink',
					'the wet socks',
					'the yellow brick road',
					'the yellow umbrella',
					'the defect guitars being exploded in The One Moment',
					'the snapped pencils',
					'the 40 ounces of... Oil',
					'the mice in the carpet',
					'the Deviled Egg',
					'the Dread Against the DM',
					'the realistic lips coming on the screen',
					'the Gentle Release on Your Face',
					'the Foolish Joker',
					'the Suite',
					'the Key of Aries',
					'the Staff of Orindia',
					'the Hidden Hew',
					'the Still Water',
					'Asteroid 314159',
					'Matt Parker',
					'Richard Herring',
					'the Red Herring',
					'Rhett Herring',
					'the scientific process',
					'Dr. Ella Hubber',
					'Caroline Roper',
					'Tom Lum',
					'Let\'s Learn Everything',
					'the Halearnday',
					'the jet lagged bee',
					'Jet Lag: the Game',
					'the Veto card',
					'the half-mile Strava map',
					'the quarter-mile radar',
					'the Curse of the Impenetratable Fog',
					'Jason Mantzoukas',
					'Hank Green',
					'John Green',
					'John Green dressing up as Hank Green for Halloween',
					'Hank Green dressing up as John Green for Halloween',
					'John Green dressing up as Hank Green dressing up for John Green for Halloween, for Halloween',
					'the Talking Flowers',
					'Prince Florian',
					'Mario',
					'Luigi',
					'Peach',
					'Daisy',
					'Rosalina',
					'Wario',
					'Waluigi',
					'Pauline',
					'Red Toad',
					'Yellow Toad',
					'Blue Toad',
					'Toadette',
					'Captain Toad',
					'Birdo',
					'Parabiddybud',
					'King Bowser',
					'Bowser Jr.',
					'the Koopalings',
					'Kamek',
					'the Dolphin from Super Mario World',
					'the Dolphin riding a Dolphin bike',
					'Yoshi',
					'Red Yoshi',
					'Yellow Yoshi',
					'Blue Yoshi',
					'the Kamikaze Koopa from Super Mario World',
					'Yoshi with a Kamikaze Koopa in its mouth',
					'the Wonder Flower',
					'the Wonder Seed',
					'the Sphynx',
					'Madame Brood',
					'the gas leak in the studio',
					'American Girls dolls',
					'the shoes for American Girls dolls',
					'Tommy Shriggly',
					'Tommy Shriggly\'s little claps',
					'the ability to sleep in places other than your home',
					'neurotypicality',
					'neuroatypicality',
					'my lack of allergies',
					'the Red Blood Cells',
					'the White Blood Cells',
					'the Neutrophils',
					'the Killer T-Cells',
					'the Platelets',
					'the B-Cells',
					'the vaccines',
					'the three yoga balls',
					'the mat at the top of that hill',
					'the three yoga balls on the top of the mat at the top of that hill',
					'the black slide with big white text in the middle saying \'I lied\'',
					'short term memory',
					'random access memory',
					'read only memory',
					'the 8 keys',
					'the 7 souls',
					'the Sevens from D20',
					'the 6 faces of a cube',
					'the 5 platonic solids',
					'the 4 groups of 4 answers',
					'the 3 primary colours',
					'the 2 genders, according to Tumblr',
					'the 1 gender, according to Tumblr',
					'Pride and Prejudice',
					'the Pride movement',
					'Pride parades',
					'the concept of Poker',
					'the concept of Poker hands',
					'Poker',
					'Tom Scott',
					'Matt Gray',
					'Chris Joel',
					'Gary Brennan',
					'The Technical Difficulties',
					'Daniel Peake',
					'Matt Parker',
					'James Grime',
					'Simon Anthony',
					'Mark Goodliffe',
					'Mark Gottlieb',
					'Mark Twain',
					'Tom Gottlieb',
					'Charlie Puth'
				}

				if SMODS.pseudorandom_probability(card, 'handedman_magnaNut', 1, 100) then

					--draw_card(G.deck, G.hand, some number, 'up' or 'down', nil, the card, delay)
					G.E_MANAGER:add_event(Event({
					trigger = 'after',
					func = function()
						draw_card(G.deck, G.hand, nil, "up", true, card)
						return true
					end
					}))

					return {
                    	message = 'All hail plus a noun of your choice',
                    	colour = G.C.RED,
						extra = {
							message = 'Talking',
							chips = -50,
                    		colour = G.C.BLUE,
							extra = {
								message = 'Failure to say \'All hail\' plus a noun of your choice',
                    			colour = G.C.BLUE,
								extra = {
                    				message = 'All hail ' .. choiceOfNounOfChoice[math.random(1, #choiceOfNounOfChoice)],
                    				colour = G.C.RED
                				}
							}
                		}
                	}
                else return {
                    message = 'All hail ' .. choiceOfNounOfChoice[math.random(1, #choiceOfNounOfChoice)],
                    colour = G.C.RED
                }
				end
            end
        end

	end,

}