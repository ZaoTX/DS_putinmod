local assets =
{
	Asset( "ANIM", "anim/putin.zip" ),
	Asset( "ANIM", "anim/ghost_putin_build.zip" ),
}

local skins =
{
	normal_skin = "putin",
	ghost_skin = "ghost_putin_build",
}

return CreatePrefabSkin("putin_none",
{
	base_prefab = "putin",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"ESCTEMPLATE", "CHARACTER", "BASE"},
	build_name_override = "putin",
	rarity = "Character",
})