HangedMan = {}
HangedMan.mod_dir = ''..SMODS.current_mod.path

-- HangedMan = SMODS.current_mod
HangedMan.jokers = {}

SMODS.current_mod.optional_features = {
    object_weights = true,
}

-- load static atlases
local atlasList = 
{

    -- mod icon
    {"modicon", 32, 32, "HangedMan_modicon.png"},

    -- main jokers sheet
	{"HangedMan", 71, 95, "HangedMan.png"},

    -- individual stateful jokers sheets
	{"HangedMan_TCoM", 71, 95, "HangedMan_TCoM.png"},
	{"HangedMan_Magna", 71, 95, "HangedMan_Magna.png"},
    {"HangedMan_TheSuite", 71, 95, "HangedMan_TheSuite.png"},
    {"HangedMan_imposterousJokers", 71, 95, "HangedMan_imposterousJokers.png"},
    {"HangedMan_pickacardanycard", 71, 95, "HangedMan_pickacardanycard.png"},
    {"HangedMan_Stepswitcher", 71, 95, "HangedMan_Stepswitcher.png"},
    {"HangedMan_TheTower", 71, 95, "HangedMan_TheTower.png"},
    {"HangedMan_LingoBlocks", 71, 95, "HangedMan_LingoBlocks.png"},

    -- consumable sheets
    {"HangedMan_Spectrals", 71, 95, "HangedMan_Spectrals.png"},

    -- non-cards sheets
	{"HangedMan_Seals", 71, 95, "HangedMan_Seals.png"},

    -- crossmod sheets
    {"HangedMan_imposterousJokers_GhostCard", 71, 95, "HangedMan_imposterousJokers_GhostCard.png"},
    
}


for _index, _object in ipairs(atlasList) do
    SMODS.Atlas {
        key = _object[1],
        px = _object[2],
        py = _object[3],
        path = _object[4],
        atlas_table = 'ASSET_ATLAS'
    }
end


-- load animated atlases
local animatedAtlasList =
{
    {"HangedMan_Disapproval", 71, 95, "HangedMan_Disapproval_Frames.png", 4, 3}
}

for _index, _object in ipairs(animatedAtlasList) do
    SMODS.Atlas {
        key = _object[1],
        px = _object[2],
        py = _object[3],
        path = _object[4],
        atlas_table = 'ANIMATION_ATLAS',
        frames = _object[5],
        fps = _object[6]
    }
end


function HangedMan.load_file(address)
	local helper, load_error = SMODS.load_file(address)
	if load_error then
    	sendDebugMessage ("[HangedMan] Failure to load file : "..load_error)
    else
    	helper()
	end
end

HangedMan.load_file("miscfunctions.lua")
HangedMan.load_file("jokers.lua")
HangedMan.load_file("calc.lua")
HangedMan.load_file("localization/en-us.lua")


-- Loading Jokers based on jokers.lua
for _, joker in ipairs(joker_list) do
    assert(SMODS.load_file("items/Jokers/" .. joker .. ".lua"))()
    HangedMan.jokers[#HangedMan.jokers + 1] = "HangedMan_" .. joker
end

local folderList = {
    'Seals',
    'Spectrals',
    'Challenges'
}

for _, folder in ipairs(folderList) do
    local files = NFS.getDirectoryItems(HangedMan.mod_dir .. "items/" .. folder)
    for _, file in ipairs(files) do
        assert(SMODS.load_file("items/" .. folder .. "/" .. file))()
    end   
end



-- Pool of Vanilla jokers
SMODS.ObjectType({
    key = "vanilla",
    default = "j_joker",
    cards = {},
})

-- Pool of Hanged Man's jokers
SMODS.ObjectType({
    key = "hangedman_pool",
    default = "",
    cards = {},
})

local SMODS_injectItems_ref = SMODS.injectItems
function SMODS.injectItems()
    SMODS_injectItems_ref()
    for i, v in ipairs(G.P_CENTER_POOLS.Joker) do
        if not v.original_mod or v.original_mod.id == "Balatro" then
             SMODS.ObjectTypes.vanilla:inject_card(v)
        end
        if v.original_mod and v.original_mod.id == "HangedMan" then
             SMODS.ObjectTypes.hangedman_pool:inject_card(v)

        end
    end
end

--[[
local gameInitHook = Game.init_game_object
function Game:init_game_object()
    local ret = gameInitHook(self)
    ret.pseudorandom = G.GAME.pseudorandom and G.GAME.pseudorandom or {}
    return ret
end
]]


----------------------------------------------
------------MOD CODE END----------------------