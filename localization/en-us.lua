return {
    descriptions = {
        Joker = {

            j_hangedman_spiralOfStars = {
                name = "Spiral of Stars",
                text = {
                    {
                        "Each {C:planet}Planet{} card used adds a word to this description.",
                    },
                    {
                        "#1#",
			            "#2#",
			            "#3#",
			            "#4#",
			            "#5#",
                    }
                },
                unlock = {
			        "Use {E:1,C:attention}8{} {C:mult}unique{}",
			        "{E:1,C:planet}Planet{} cards",
			        "in a single run",
			        "OR",
			        "Use any {E:1,C:attention}16{}",
			        "{E:1,C:planet}Planet{} cards",
			        "in a single run",
		        }
            },

            j_hangedman_theSuite = {
		        name = 'The Suite',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_monke = {
		        name = 'Monke',
		        text = {
                    {
			           "{C:mult}+#3#{} Mult for each {C:attention}Monke{}",
                       "currently held, including itself",
                       "{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult){}",
		            },
                    {
                       "Each {C:attention}Gros Michel{} or {C:attention}Cavendish{}",
                        "held also gives {C:white,X:mult}X#2#{}",
                    }
                }
	        },

            j_hangedman_jonkler = {
		        name = 'Jonkler',
		        text = {
                    {
			           "{C:chips}+#1#{} Chips,",
                       "then {C:mult}+#2#{} Mult,",
                       "then {X:mult,C:white}X#3#{} Mult",
                    },
                    {
                        "{C:green}#4# in #5#{} chance",
                        "for a random pair of numbers",
                        "in this card's description to",
                        "switch places after each hand",
                    },
                    {
                        "{C:inactive, s:0.4}Reserve : #6#{}"
		            }
                }
	        },

            j_hangedman_jimboSays = {
		        name = 'Jimbo Says',
		        text = {
                    {
			            "{C:planet}#4#{}",
                    },
                    {
			            "{C:mult}+#2#{} Mult on command {C:green}correctly{} followed or ignored,",
			            "{C:mult}-#3#{} Mult on command {C:mult}incorrectly{} followed or ignored",
			            "{C:inactive}(Currently{} {C:mult}+#1#{} Mult{C:inactive}){}"
		            }
                }
	        },

            -- old version of Experiments
            --[[
            j_hangedman_experiments = {
		        name = 'Experiments',
		        text = {
                    {
			            "The next 8 times you beat a {C:attention}Boss Blind{},",
			            "add a random {C:green}Trigger{} and {C:green}Effect{} to this card",},
                    {
			            "{C:chips}+#1#{} / {C:mult}+#2#{} / {X:mult,C:white}X#3#{}",
			            "+{C:money}$#4#{} after Blind beaten",
                    },
                    {
			            "{C:inactive, s:0.4}Active Experiments:{}",
			            "#5#",
			            "#6#",
			            "#7#",
			            "#8#",
			            "#9#",
			            "#10#",
			            "#11#",
			            "#12#"
		            }
                }
	        },
            ]]

            j_hangedman_experiments = {
		        name = 'Experiments',
		        text = {
                    {
			            "The next 8 times you beat a {C:attention}Boss Blind{},",
			            "add a random {C:green}Trigger{} and {C:green}Effect{} to this card",},
                    {
			            "{C:chips}+#1#{} / {C:mult}+#2#{} / {X:mult,C:white}X#3#{}",
			            "+{C:money}$#4#{} after Blind beaten",
                    },
                }
	        },

            j_hangedman_bingoCard = {
		        name = 'Bingo Card',
		        text = {
                    {
			            "{C:white,X:mult}X#1#{} Mult,",
                        "Gain {C:white,X:mult}X1{} Mult for",
                        "each completed line",
                        "{C:inactive}#6#{}",
                        "{C:inactive}#7#{}",
                    },
                    {
                        ""
                    }
		        }
	        },

            j_hangedman_removalService = {
		        name = 'Removal Service',
		        text = {
			        "When discarding {C:attention}1{} card,",
                    "destroy it and lose {C:money}$#1#{}",
			        "Increase cost by {C:money}$1{} each use"
		        },
                unlock = {
			        "Destroy {E:1,C:attention}10{}",
                    "playing cards",
                    "in a single run",
		        }
	        },

            j_hangedman_rideTheTide = {
		        name = 'Ride the Tide',
		        text = {
			        {
                        "{C:chips}+#1#{} Chips",
                        "{C:inactive}#2#{}"
                    },
                    {
                        "If played hand is of a {C:chips}higher{} tier",
			            "than previous hand, {C:attention}double{} the Chips amount",
                        "If played hand is of a {C:mult}lower{} tier",
			            "than previous hand, divide the Chips amount by {C:attention}10{}"
                    }
		        },
                unlock = {
			        "Play {E:1,C:attention}8{} unique",
                    "hand types",
                    "in a single run",
		        }
	        },

            j_hangedman_sodaBee = {
		        name = 'Soda Bee',
		        text = {
			        "{C:mult}+#1#{} Mult if combined {C:attention}rank{}",
                    "of scored cards is a multiple of {C:attention}#2#{}",
                    "Gain {C:mult}+#3#{} Mult if combined {C:attention}rank{}",
                    "of scored cards is a multiple of {C:attention}#3#{}",
                    "{C:inactive, s:0.4}A, J, Q, and K are 1, 11, 12, and 13{}"
		        }
	        },

            j_hangedman_theColourOfMoney = {
		        name = 'The Colour of Money',
		        text = {
			        "Gains {C:money}$1{} of {C:attention}sell value{}",
                    "after each hand played",
                    "{C:mult}Destroy itself{} after somewhere",
                    "between {C:attention}5 to 30{} hands played",
                    "{C:inactive}Machine colour : #1#"
		        }
	        },

            j_hangedman_laughingJoker = {
		        name = 'Laughing Joker',
		        text = {
			        "Played {C:attention}5{} gives {C:mult}+#1#{} Mult for",
                    "each scoring {C:attention}5{} when scored",
		        },
                unlock = {
			        "Discard five",
                    "{E:1,C:attention}5s{} at the",
                    "same time"
		        }
	        },

            j_hangedman_foolishJoker = {
		        name = 'Foolish Joker',
		        text = {
                    
			        "Effect based on the last",
                    "{C:tarot}Tarot{} or {C:planet}Planet{} card",
                    "used during this run",
                    "{s:0.8,C:tarot}The Fool{s:0.8} excluded",
                    "{C:inactive}(Currently replicating{} {V:1}#1#{}{C:inactive}){}",
             
		        },
                unlock = {
			        "Use {E:1,C:attention}10{}",
                    "{E:1,C:tarot}The Fool{} tarots",
                    "in a single run"
		        }
                
	        },

            j_hangedman_imposterous = {
		        name = 'Imposterous',
		        text = {
                    {
			        "{C:attention}Sell{} this card before ",
                    "the next time you play a hand",
                    "for a random {C:green}positive{} effect"
                    },
                    {
			        "{C:red}Failure{} to eliminate before",
                    "the next time you play a hand",
                    "causes a random {C:red}negative{} effect"
                    }
		        }
	        },

            j_hangedman_cyclomancy = {
		        name = 'Cyclomancy',
		        text = {
                    {
                    "Gain {C:white,X:mult}X#3#{} Mult when",
                    "#5# {C:attention}#1#{} of {V:1}#2#{} is scored",
                    "{s:0.8}Card changes after current",
                    "{s:0.8}selected card is scored",
                    "{C:inactive}(Currently{} {C:white,X:mult}X#4#{}{C:inactive} Mult){}"
                    }
                }
            },

            j_hangedman_pickACardAnyCard = {
                name = 'Pick a Card, Any Card',
                text = {
                    {
                    "Reveals a random card before hand is scored",
                    "Cards with the same {C:attention}colour{} gives +{C:chips}#1#{} Chips when scored",
                    "Cards with the same {C:attention}suit{} gives +{C:mult}#2#{} Mult when scored",
                    "Cards with the same {C:attention}rank{} gives {C:white,X:mult}X#3#{} Mult when scored",
                    },
                    {
                    "If played hand contains the revealed card,",
                    "multiply the three values above by {C:attention}X#4#{}"
                    }
                }
            },

            j_hangedman_homeIsInYourHeart = {
                name = {
                        'Home Is In Your Heart',
                        '{s:0.6}Lirie & WUNDER RiKU{}',
                        '{s:0.6}Based on MV art by adirosa & ghostaficionado{}',
                        },
                text = {
                    "If played hand contains a {C:attention}Full House{},",
                    "{C:hearts}Heart{} cards gives {C:mult}+#1#{} Mult for each",
                    "{C:hearts}Heart{} cards held in hand when scored",
                    "{C:inactive}(Currently{} {C:mult}+#2#{} {C:inactive}Mult){}",
                },
                unlock = {
                    "Play a {C:attention,E:1}Flush House{}",
                    "with {C:hearts,E:1}Heart{} suit",
                }
            },

            j_hangedman_keeperOfTithe = {
                name = 'Keeper of Tithe',
                text = {
                    {
                    "Set money to {C:gold}$0{} when Blind selected,",
                    "and gain {C:mult}Mult{} equal to amount lost",
                    "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult){}",
                    },
                    {
                    "When sold, convert all {C:mult}Mult{} back to {C:gold}money{}"
                    }
                },
                unlock = {
                    "Win a run without ever",
                    "having more than {C:attention,E:1}$20{}",
                }
            },

            j_hangedman_noMoreJokers = {
                name = 'No More Jokers',
                text = {
                    {
                    "Gain {C:white,X:mult}X#1#{} Mult and a {C:attention}restriction{} each hand,",
                    "Reset if played hand contains a banned element",
                    "{C:inactive}(Currently{} {C:white,X:mult}X#2#{} {C:inactive}Mult){}"
                    }
                }
            },


            -- dummy lock entries for The Suite states

            j_hangedman_theSuite_ClubsHearts = {
		        name = 'The Coyish',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_ClubsSpades = {
		        name = 'The Cosmos',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_ClubsDiamonds = {
		        name = 'The Coward',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_HeartsClubs = {
		        name = 'The Heroic',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_HeartsSpades = {
		        name = 'The Hubris',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_HeartsDiamonds = {
		        name = 'The Horrid',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_SpadesClubs = {
		        name = 'The Scenic',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_SpadesHearts = {
		        name = 'The Sleuth',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_SpadesDiamonds = {
		        name = 'The Sacred',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_DiamondsClubs = {
		        name = 'The Dyadic',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_DiamondsHearts = {
		        name = 'The Dovish',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },

            j_hangedman_theSuite_DiamondsSpades = {
		        name = 'The Demiss',
		        text = {
                    {
                        "Scoring {V:1}#1#{} cards {C:attention}retrigger{} once",
                        "for each scoring {V:2}#2#{} cards",
                        "to the right of it",
                    },{
                        "State changes when Blind selected",
                        "and after each hand played"
                    }
                }
	        },






            -- dummy loc entries for Imposterous effects

            j_hangedman_imposterous_halfFaceDown = {
		        name = 'Imposterous',
		        text = {
                    {
			        "{C:green}#1# in #2#{} cards are",
                    "drawn {C:attention}face down"
                    }
		        }
	        },

            j_hangedman_imposterous_loseTwoHandSize = {
		        name = 'Imposterous',
		        text = {
                    {
			        "{C:attention}-2{} hand size",
                    }
		        }
	        },

            j_hangedman_imposterous_loseDiscard = {
		        name = 'Imposterous',
		        text = {
                    {
			        "{C:red}-2{} Discards",
                    }
		        }
	        },

            j_hangedman_imposterous_loseHand = {
		        name = 'Imposterous',
		        text = {
                    {
			        "{C:blue}-2{} Hands",
                    }
		        }
	        },

            j_hangedman_imposterous_voidDagger = {
		        name = 'Imposterous',
		        text = {
                    {
			        "{C:attention}Destroy Joker to its right",
                    "when Blind is selected"
                    }
		        }
	        },

            j_hangedman_imposterous_xmultDecrease = {
		        name = 'Imposterous',
		        text = {
                    {
			        "{X:mult,C:white}X#3#{} Mult"
                    }
		        }
	        },

            j_hangedman_imposterous_loseMoneyOnDiscard = {
		        name = 'Imposterous',
		        text = {
                    {
			        "Lose {C:money}$1{} per card {C:red}discarded{}"
                    }
		        }
	        },

            j_hangedman_imposterous_loseMoneyPerCard = {
		        name = 'Imposterous',
		        text = {
                    {
			        "Lose {C:money}$1{} per card {C:blue}scored{}"
                    }
		        }
	        },

            j_hangedman_imposterous_pairOfEggs = {
		        name = 'Imposterous',
		        text = {
                    {
			        "Spawn 2 {C:attention}Eternal Eggs{}"
                    }
		        }
	        },

            j_hangedman_imposterous_evilYorick = {
		        name = 'Imposterous',
		        text = {
                    {
			        "{C:red}-1{} Discard every",
                    "{C:attention}20{} cards discarded",
                    "{C:inactive}(#1# remaining){}"
                    }
		        }
	        },

            j_hangedman_imposterous_debuffFace = {
		        name = 'Imposterous',
		        text = {
                    {
			        "Debuff all {C:attention}face{} cards"
                    }
		        }
	        },

            j_hangedman_imposterous_debuffClubs = {
		        name = 'Imposterous',
		        text = {
                    {
			        "Debuff all {C:clubs}Clubs{} cards"
                    }
		        }
	        },

            j_hangedman_imposterous_debuffHearts = {
		        name = 'Imposterous',
		        text = {
                    {
			        "Debuff all {C:hearts}Hearts{} cards"
                    }
		        }
	        },

            j_hangedman_imposterous_debuffSpades = {
		        name = 'Imposterous',
		        text = {
                    {
			        "Debuff all {C:spades}Spades{} cards"
                    }
		        }
	        },

            j_hangedman_imposterous_debuffDiamonds = {
		        name = 'Imposterous',
		        text = {
                    {
			        "Debuff all {C:diamonds}Diamonds{} cards"
                    }
		        }
	        },



            


        },
        Tarot = {


            -- dummy entries for Foolish Joker's Tarot replication effects

            c_hangedman_foolishJoker_TheMagician = {
                name = "The Magician",
                text = {
                    "Cards with no",
                    "{C:attention}Enhancements{}",
                    "are enhanced into",
                    "{C:attention}Lucky{} cards",
                    "when scored"
                },
            },
            c_hangedman_foolishJoker_TheHighPriestess = {
                name = "The High Priestess",
                text = {
                    "Creates up to {C:attention}1{}",
                    "random {C:planet}Planet{} card",
                    "{C:inactive}(Must have room)"
                },
            },
            c_hangedman_foolishJoker_TheEmpress = {
                name = "The Empress",
                text = {
                    "Cards with no",
                    "{C:attention}Enhancements{}",
                    "are enhanced into",
                    "{C:attention}Mult{} cards",
                    "when scored"
                },
            },
            c_hangedman_foolishJoker_TheEmperor = {
                name = "The Emperor",
                text = {
                    "Creates up to {C:attention}1{}",
                    "random {C:tarot}Tarot{} card",
                    "{C:inactive}(Must have room)"
                },
            },
            c_hangedman_foolishJoker_TheHierophant = {
                name = "The Heirophant",
                text = {
                    "Cards with no",
                    "{C:attention}Enhancements{}",
                    "are enhanced into",
                    "{C:attention}Bonus{} cards",
                    "when scored"
                },
            },
            c_hangedman_foolishJoker_TheLovers = {
                name = "The Lovers",
                text = {
                    "Cards with no",
                    "{C:attention}Enhancements{}",
                    "are enhanced into",
                    "{C:attention}Wild{} cards",
                    "when scored"
                },
            },
            c_hangedman_foolishJoker_TheChariot = {
                name = "The Chariot",
                text = {
                    "Enhance {C:attention}1{} random card",
                    "with no {C:attention}Enhancements{}",
                    "held into a {C:attention}Steel{} card",
                },
            },
            c_hangedman_foolishJoker_Justice = {
                name = "Justice",
                text = {
                    "Enhance {C:attention}1{} random card",
                    "with no {C:attention}Enhancements{}",
                    "held into a {C:attention}Glass{} card",
                },
            },
            c_hangedman_foolishJoker_TheHermit = {
                name = "The Hermit",
                text = {
                    "Gain {C:attention}20%{} of",
                    "current money",
                    "{C:inactive}(Max of {C:money}$20{}{C:inactive}){}"
                },
            },
            c_hangedman_foolishJoker_Strength = {
                name = "Strength",
                text = {
                    "Increase rank of",
                    "scored cards by {C:attention}1{}"
                },
            },
            c_hangedman_foolishJoker_TheHangedMan = {
                name = "The Hanged Man",
                text = {
                    "Destroy all cards",
                    "in first discard",
                    "of Blind"
                },
            },
            c_hangedman_foolishJoker_Death = {
                name = "Death",
                text = {
                    "If {C:red}Discard{} contains",
                    "exactly {C:attention}2 cards,",
                    "convert the {C:attention}left{} card",
                    "into the {C:attention}right{} card"
                },
            },
            c_hangedman_foolishJoker_Temperance = {
                name = "Temperance",
                text = {
                    "Give the sell",
                    "value of a",
                    "random held {C:attention}Joker{}",
                },
            },
            c_hangedman_foolishJoker_TheDevil = {
                name = "The Devil",
                text = {
                    "Cards with no",
                    "{C:attention}Enhancements{}",
                    "are enhanced into",
                    "{C:attention}Gold{} cards",
                    "when scored"
                },
            },
            c_hangedman_foolishJoker_TheTower = {
                name = "The Tower",
                text = {
                    "Enhance {C:attention}1{} random card",
                    "with no {C:attention}Enhancements{}",
                    "held into a {C:attention}Stone{} card",
                },
            },
            c_hangedman_foolishJoker_TheStar = {
                name = "The Star",
                text = {
                    "Convert suit of",
                    "scored cards to {C:diamonds}Diamonds{}"
                },
            },
            c_hangedman_foolishJoker_TheMoon = {
                name = "The Moon",
                text = {
                    "Convert suit of",
                    "scored cards to {C:clubs}Clubs{}"
                },
            },
            c_hangedman_foolishJoker_TheSun = {
                name = "The Sun",
                text = {
                    "Convert suit of",
                    "scored cards to {C:hearts}Hearts{}"
                },
            },
            c_hangedman_foolishJoker_TheWorld = {
                name = "The World",
                text = {
                    "Convert suit of",
                    "scored cards to {C:spades}Spades{}"
                },
            },
            c_hangedman_foolishJoker_Judgement = {
                name = "Judgement",
                text = {
                    "Create a random",
                    "{C:attention}Joker{} card",
                    "at end of Blind",
                    "{C:inactive}(Must have room){}"
                },
            },
            c_hangedman_foolishJoker_UpgradePlanet = {
                name = "Planet Replication",
                text = {
                    "Upgrade the hand",
                    "of this {C:planet}Planet{} card",
                    "at end of Blind",
                },
            },
        },

        Planet = {

           

        },

        Spectral = {
            c_hangedman_fragility = {
                name = "Fragility",
                text = {
                    "Add a {C:green}Glass Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },

            c_hangedman_perambulate = {
                name = "Perambulate",
                text = {
                    "Add a {C:blue}Hiking Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },

            c_hangedman_cosmonaut = {
                name = "Cosmonaut",
                text = {
                    "Add a {C:green}Space Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },

            c_hangedman_lapidify = {
                name = "Lapidify",
                text = {
                    "Add a {C:inactive}Stone Seal{}",
                    "to {C:attention}1{} selected",
                    "card in your hand",
                },
            },


        },

        Other = {
            hangedman_hiking_seal = {
                name = "Hiking Seal",
                text = {
                    "Permanently gain",
                    "{C:chips}+#1#{} Chips each time ",
                    "this card scores",
                },
            },
            hangedman_space_seal = {
                name = "Space Seal",
                text = {
                    "{C:green}#1# in #2#{} chance",
                    "to upgrade level of",
                    "played {C:attention}poker hand{}"
                },
            },
            hangedman_stone_seal = {
                name = "Stone Seal",
                text = {
                    "Always counted in scoring",
                    "{C:inactive}(unless debuffed){}",
                },
            },
            hangedman_glass_seal = {
                name = "Glass Seal",
                text = {
                    "Retrigger this",
                    "card {C:attention}#1#{} times",
                    "{C:green}#2# in #3#{} chance to",
                    "destroy seal",
                },
            },

        },

        
    },

    

    misc = {
        challenge_names = {
            c_hangedman_theColourOfMoneyChal = "The Colour of Money",
            c_hangedman_spotTheDifferenceChal = "Spot the Difference",
            c_hangedman_anOfferYouCantRefuseChal = "An Offer You Can\'t Refuse",
            c_hangedman_vowOfPovertyChal = "Vow of Poverty",
            c_hangedman_ultimateDraftChal = "Ultimate Draft"
        },
        v_text = {

            ch_c_imposterous_increase = {
                "{C:purple}Imposterous{} is sigficantly more likely to show up"
            },
            ch_c_prevent_shop_exit_until_purchase = {
                "You may {C:red}NOT{} leave the shop until you make a purchase"
            },
            ch_c_vow_of_poverty = {
                "Lose the run if you have more than {C:money}$10{} at any point"
            },

            ch_c_ultimate_draft_large_shop = {
                "The first shop you enters has 5 {C:attention}card slots{}, 3 {C:attention}Booster Packs{}, and 3 {C:attention}Vouchers{}"
            },
            ch_c_ultimate_draft_close_shop_upon_leave = {
                "Shop closes for the rest of run once you leave"
            },

            
            -- More general rules
            ch_c_carryover_discards = {
                "{C:red}Discards{} carry over between rounds"
            },
            ch_c_carryover_hands = {
                "{C:blue}Hands{} carry over between rounds"
            },


            
        },
        labels = {
            hangedman_hiking_seal = "Hiking Seal",
            hangedman_space_seal = "Space Seal",
            hangedman_stone_seal = "Stone Seal",
            hangedman_glass_seal = "Glass Seal",
        },
        
        
    }
}