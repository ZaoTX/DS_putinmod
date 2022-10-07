PrefabFiles = {
	"putin",
	"putin_none",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/putin.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/putin.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/putin.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/putin.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/putin_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/putin_silho.xml" ),

    Asset( "IMAGE", "bigportraits/putin.tex" ),
    Asset( "ATLAS", "bigportraits/putin.xml" ),
	
	Asset( "IMAGE", "images/map_icons/putin.tex" ),
	Asset( "ATLAS", "images/map_icons/putin.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_putin.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_putin.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_putin.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_putin.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_putin.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_putin.xml" ),
	
	Asset( "IMAGE", "images/names_putin.tex" ),
    Asset( "ATLAS", "images/names_putin.xml" ),
	
	Asset( "IMAGE", "images/names_gold_putin.tex" ),
    Asset( "ATLAS", "images/names_gold_putin.xml" ),
}

AddMinimapAtlas("images/map_icons/putin.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.putin = "The President Forever"
STRINGS.CHARACTER_NAMES.putin = "putin"
STRINGS.CHARACTER_DESCRIPTIONS.putin = "*President of Russia\n* Muscle\n* Rides a bear"
STRINGS.CHARACTER_QUOTES.putin = "\"I know the world war III, nobody wants to see.\""
STRINGS.CHARACTER_SURVIVABILITY.putin = "Slim"

-- Custom speech strings
STRINGS.CHARACTERS.PUTIN = require "speech_putin"

-- The character's name as appears in-game 
STRINGS.NAMES.PUTIN = "Esc"
STRINGS.SKIN_NAMES.putin_none = "Esc"

-- The skins shown in the cycle view window on the character select screen.
-- A good place to see what you can put in here is in skinutils.lua, in the function GetSkinModes
local skin_modes = {
    { 
        type = "ghost_skin",
        anim_bank = "ghost",
        idle_anim = "idle", 
        scale = 0.75, 
        offset = { 0, -25 } 
    },
}

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("putin", "MALE", skin_modes)

-- Rewrite bearger



local function MakeBeargerLikePutin(brain)
    local mainGroup = nil --the main root
    for node in brain.bt.root.children do
        if node.name == "Priority" then
            break
        end
        mainGroup = node.children[0]
    end
    local ind = 0
    for node in mainGroup.children do
        if node.name == "ChaseAndAttack" then
            table.remove(mainGroup.children,node)--remove the node
            
        else
            ind=ind+1
        end
        
    end

    local newChaseAndAttack = ChaseAndAttack(self.inst, 20, 60, nil, RetargetFn, true)

    --insert the new node
    table.insert(mainGroup.children, ind, newChaseAndAttack)

end



--AddBrainPostInit("beargerbrain",MakeBeargerLikePutin)

--AddPrefabPostInit("bearger",
--function (inst)
--    local brain = _G.require("beargerrewrite")
--    inst:SetBrain(brain)
    
--end)
--local freindlyWithPutin = require("bearger-rewrite")
--AddPostInit("bearger",RetargetFn)

local function OnAttacked(inst, data)
    if(not data.attacker:HasTag("putin")) then
        inst.components.combat:SetTarget(data.attacker)
    else
        print("Putin was hitting me!")
    end
end
AddPrefabPostInit("bearger", function (inst)
    inst:ListenForEvent("attacked", OnAttacked)
end)