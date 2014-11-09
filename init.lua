-- mobspawn v.0.9 by HeroOfTheWinds
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
	table.insert(mobspawn.mobs,	{name="dirt_monster", desc="Dirt Monster", code="mobs:dirt_monster"})
	table.insert(mobspawn.mobs,	{name="sand_monster", desc="Sand Monster", code="mobs:sand_monster"})
	table.insert(mobspawn.mobs,	{name="tree_monster", desc="Tree Monster", code="mobs:tree_monster"})
	table.insert(mobspawn.mobs,	{name="stone_monster", desc="Stone Monster", code="mobs:stone_monster"})
	table.insert(mobspawn.mobs,	{name="oerkki", desc="Oerkki", code="mobs:oerkki"})
	table.insert(mobspawn.mobs,	{name="dungeon_master", desc="Dungeon Master", code="mobs:dungeon_master"})
	table.insert(mobspawn.mobs,	{name="spider", desc="Spider", code="mobs:spider"})
	table.insert(mobspawn.mobs,	{name="lava_flan", desc="Lava Flan", code="mobs:lava_flan"})
	table.insert(mobspawn.mobs,	{name="mese_monster", desc="Mese Monster", code="mobs:mese_monster"})
else
	--List all the hostile mobs in Simple Mobs
	mobspawn.mod = "mobs"
	table.insert(mobspawn.mobs,	{name="dirt_monster", desc="Dirt Monster", code="mobs:dirt_monster"})
	table.insert(mobspawn.mobs,	{name="sand_monster", desc="Sand Monster", code="mobs:sand_monster"})
	table.insert(mobspawn.mobs,	{name="tree_monster", desc="Tree Monster", code="mobs:tree_monster"})
	table.insert(mobspawn.mobs,	{name="stone_monster", desc="Stone Monster", code="mobs:stone_monster"})
	table.insert(mobspawn.mobs,	{name="oerkki", desc="Oerkki", code="mobs:oerkki"})
	table.insert(mobspawn.mobs,	{name="dungeon_master", desc="Dungeon Master", code="mobs:dungeon_master"})
end

if minetest.get_modpath("zmobs") then
	--List all the hostile mobs in ZMobs
	mobspawn.mod = "zmobs"
	table.insert(mobspawn.mobs,	{name="lava_flan", desc="Lava Flan", code="zmobs:lava_flan"})
	table.insert(mobspawn.mobs,	{name="mese_monster", desc="Mese Monster", code="zmobs:mese_monster"})
end

if minetest.get_modpath("creatures") then
	--List all the hostile mobs in Creatures mod
	mobspawn.mod = "creatures"
	table.insert(mobspawn.mobs,	{name="ghost", desc="Ghost", code="creatures:ghost"})
	table.insert(mobspawn.mobs,	{name="zombie", desc="Zombie", code="creatures:zombie"})
end

if minetest.get_modpath("senderman") then
	--Add the Senderman
	mobspawn.mod = "senderman"
	table.insert(mobspawn.mobs,	{name="senderman", desc="Senderman", code="senderman:senderman"})
end

if minetest.get_modpath("carbone_mobs") then
	--Add the mobs from Carbone
	mobspawn.mod = "carbone"
	table.insert(mobspawn.mobs,	{name="dirt_monster", desc="Dirt Monster", code="carbone_mobs:dirt_monster"})
	table.insert(mobspawn.mobs,	{name="sand_monster", desc="Sand Monster", code="carbone_mobs:sand_monster"})
	table.insert(mobspawn.mobs,	{name="tree_monster", desc="Tree Monster", code="carbone_mobs:tree_monster"})
	table.insert(mobspawn.mobs,	{name="stone_monster", desc="Stone Monster", code="carbone_mobs:stone_monster"})
	table.insert(mobspawn.mobs,	{name="oerkki", desc="Oerkki", code="carbone_mobs:oerkki"})
	table.insert(mobspawn.mobs,	{name="dungeon_master", desc="Dungeon Master", code="carbone_mobs:dungeon_master"})
	table.insert(mobspawn.mobs,	{name="trooper", desc="Trooper", code="carbone_mobs:trooper"})
	table.insert(mobspawn.mobs,	{name="rhino", desc="Rhino", code="carbone_mobs:rhino"})
end

if minetest.get_modpath("mobf") then
	--Add mobf mobs
	mobspawn.mod = "mobf"
	if minetest.get_modpath("animal_big_red") then
		table.insert(mobspawn.mobs,	{name="big_red", desc="Big Red", code="animal_big_red:big_red"})
	end
	if minetest.get_modpath("animal_creeper") then
		table.insert(mobspawn.mobs,	{name="creeper", desc="Creeper", code="animal_creeper:creeper"})
	end
	if minetest.get_modpath("animal_dm") then
		table.insert(mobspawn.mobs,	{name="dm", desc="DM", code="animal_dm:dm"})
	end
	if minetest.get_modpath("animal_vombie") then
		table.insert(mobspawn.mobs,	{name="vombie", desc="Vombie", code="animal_vombie:vombie"})
	end
	if minetest.get_modpath("mob_archer") then
		table.insert(mobspawn.mobs,	{name="archer", desc="Archer", code="mob_archer:archer"})
	end
	if minetest.get_modpath("mob_guard") then
		table.insert(mobspawn.mobs,	{name="guard", desc="Guard", code="mob_guard:guard"})
	end
	if minetest.get_modpath("mob_oerkki") then
		table.insert(mobspawn.mobs,	{name="oerkki", desc="Oerkki", code="mob_oerkki:oerkki"})
	end
	if minetest.get_modpath("mob_slime") then
		table.insert(mobspawn.mobs,	{name="slime", desc="Slime", code="mob_slime:slime_M"})
	end
end

--Create a spawner for each mob
for _,mob in pairs(mobspawn.mobs) do
	minetest.register_node("mobspawn:"..mob.name.."_spawner", {
		description = mob.desc.." Spawner",
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
		nodenames = {"mobspawn:"..mob.name.."_spawner"},
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
					minetest.add_entity(npos, mob.code)
				end
			end
		end,
	})
end