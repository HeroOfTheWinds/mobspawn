-- mobspawn v.0.8 by HeroOfTheWinds
-- WTFPL 2.0
-- Mod to add mob spawners to Minetest for Simple Mobs and Mobs_Redo (by PilzAdam and TenPlus1 respectively)
-- There are plans to add support for more mods...

local redo = false --Switch to determine if the mobs mod is TenPlus1's mobs_redo... DETERMINED AUTOMATICALLY
local SPAWN_INTERVAL = 30 --Rate at which mobs are spawned (in seconds)
local CHANCE = 1 --Chance of mob spawning at each interval. 1=always
local MAX_MOBS = 7 --Max number of mobs that can be in the vicinity of a spawner for a mob to spawn.  If lag is a concern, keep to a low value. (A strong singleplayer PC can handle 10-20 though...)
local MAX_LIGHT = 9 --Max light in which mobs are spawned

--If the mod is "mobs", whose version is it?
if (minetest.get_modpath("mobs")) then
	if mobs.mod == "redo" then
		redo = true
	end
end

mobspawn = {} --Container for whatever

mobspawn.mobs = {} --List to hold all registered mobs that are to be affected by this mod
mobspawn.mod = "" --What is the base mod?

if redo then
	--List all the hostile mobs in Mobs Redo
	mobspawn.mod = "mobs"
	mobspawn.mobs = {
		"dirt_monster",
		"sand_monster",
		"tree_monster",
		"stone_monster",
		"oerkki",
		"dungeon_master",
		"spider",
		"lava_flan",
		"mese_monster",
	}
else
	--List all the hostile mobs in Simple Mobs
	mobspawn.mod = "mobs"
	mobspawn.mobs = {
		"dirt_monster",
		"sand_monster",
		"tree_monster",
		"stone_monster",
		"oerkki",
		"dungeon_master",
	}
end

--Create a spawner for each mob
for _,mob in pairs(mobspawn.mobs) do
	minetest.register_node("mobspawn:"..mob.."_spawner", {
		description = mob.." Spawner",
		drawtype = "allfaces",
		tiles = {"mobspawn_cage_top.png", "mobspawn_cage_bottom.png", "mobspawn_cage_side.png"},
		is_ground_content = false,
		groups = {cracky=1},
		light_source = 3,
		paramtype = "light",
		use_texture_alpha = true,
		sunlight_propagates = true,
	})
	
	--The heart of the mod, the spawning function
	minetest.register_abm({
		nodenames = {"mobspawn:"..mob.."_spawner"},
		interval = SPAWN_INTERVAL,
		chance = CHANCE,
		action = function(pos, node, active_object_count, active_object_count_wider)
			--Randomize spawn location
			local npos = {x=pos.x + math.random(-3,3), y=pos.y, z=pos.z + math.random(-3,3)}
			--Make sure it's a sufficiently dark room
			if (minetest.get_node_light(npos) < MAX_LIGHT) then
				local count = 0
				--check how many mobs are nearby
				for _,ent in pairs(minetest.get_objects_inside_radius(pos, 6)) do
					count = count + 1
				end
				if count < MAX_MOBS then
					--Prepare for trouble (sorry, it won't be double... yet)
					minetest.add_entity(npos, mobspawn.mod..":"..mob)
				end
			end
		end,
	})
end