local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
}

-- Your character's stats
TUNING.PUTIN_HEALTH = 250
TUNING.PUTIN_HUNGER = 250
TUNING.PUTIN_SANITY = 66 --理智低于55就召唤秋熊

-- Custom starting inventory
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.PUTIN = {
	--"flint",
	--"flint",
	--"twigs",
	--"twigs",
	--携带噩梦燃料
	--"nightmarefuel",
	"nightmarefuel",
}

local start_inv = {
	--"flint",
	--"flint",
	--"twigs",
	--"twigs",
	--携带噩梦燃料
	"nightmarefuel",
	"nightmarefuel",
	"nightmarefuel",
	 
}

local prefabs = FlattenTree(start_inv, true)

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "putin_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "putin_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
	
    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "putin.tex" )
	inst:AddTag("putin")
end
--直接复制willow的代码测试
local function sanityfn(inst)
	local x,y,z = inst.Transform:GetWorldPosition()	
	local delta = 0
	local max_rad = 10
	local ents = TheSim:FindEntities(x,y,z, max_rad, {"fire"})
    for k,v in pairs(ents) do 
    	if v.components.burnable and v.components.burnable.burning then
    		local sz = TUNING.SANITYAURA_TINY
    		local rad = v.components.burnable:GetLargestLightRadius() or 1
    		sz = sz * ( math.min(max_rad, rad) / max_rad )
			local distsq = inst:GetDistanceSqToInst(v)
			delta = delta + sz/math.max(1, distsq)
    	end
    end
    
    return delta
end
-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- Set starting inventory
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default
	
	-- choose which sounds this character will play
	inst.soundsname = "wilson"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(TUNING.PUTIN_HEALTH)
	inst.components.hunger:SetMax(TUNING.PUTIN_HUNGER)
	inst.components.sanity:SetMax(TUNING.PUTIN_SANITY)
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

return MakePlayerCharacter("putin", prefabs, assets, common_postinit, master_postinit, start_inv)
