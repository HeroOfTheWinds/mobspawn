-- mobspawn v.0.9 by HeroOfTheWinds
-- WTFPL 2.0
-- Mod to add mob spawners to Minetest
-- There are plans to add support for more mods...

local redo = false --Switch to determine if the mobs mod is TenPlus1's mobs_redo... DETERMINED AUTOMATICALLY
local SPAWN_INTERVAL = 30 --Rate at which mobs are spawned (in seconds)
local CHANCE = 1 --Chance of mob spawning at each interval. 1=always
local MAX_MOBS = 7 --Max number of mobs that can be in the vicinity of a spawner for a mob to spawn.  If lag is a concern, keep to a low value. (A strong singleplayer PC can handle 10-20 though...)
local MAX_LIGHT = 10 --Max light in which mobs are spawned

--If the mod is "mobs", whose version is it?
if (minetest.get_modpath("mobs")) then
	if mobs.mod == "redo" then
		redo = true
	end
end

mobspawn = {} --Container for whatever

mobspawn.mobs = {} --List to hold all registered mobs that are to be affected by this mod

--
-- MOB LISTINGS --
--
-- Comment/uncomment lines or groups of lines to enable or disable particular mobs
-- Use this to prevent registering the same spawner multiple times for name conflicts between mods
if (minetest.get_modpath("mobs")) then
	if redo then
		--List all the hostile mobs in Mobs Redo or Mobs++
		table.insert(mobspawn.mobs,	{name="dirt_monster", desc="Dirt Monster", code="mobs:dirt_monster"})
		table.insert(mobspawn.mobs,	{name="sand_monster", desc="Sand Monster", code="mobs:sand_monster"})
		table.insert(mobspawn.mobs,	{name="tree_monster", desc="Tree Monster", code="mobs:tree_monster"})
		table.insert(mobspawn.mobs,	{name="stone_monster", desc="Stone Monster", code="mobs:stone_monster"})
		table.insert(mobspawn.mobs,	{name="oerkki", desc="Oerkki", code="mobs:oerkki"})
		table.insert(mobspawn.mobs,	{name="dungeon_master", desc="Dungeon Master", code="mobs:dungeon_master"})
		table.insert(mobspawn.mobs,	{name="spider", desc="Spider", code="mobs:spider"})
		table.insert(mobspawn.mobs,	{name="lava_flan", desc="Lava Flan", code="mobs:lava_flan"})
		table.insert(mobspawn.mobs,	{name="mese_monster", desc="Mese Monster", code="mobs:mese_monster"})
		--Mobs++ Specific
		if (minetest.registered_entities["mobs:littlespider"]) then
			table.insert(mobspawn.mobs,	{name="littlespider", desc="Little Spider", code="mobs:littlespider"})
		end
		if (minetest.registered_entities["mobs:wardog"]) then
			table.insert(mobspawn.mobs,	{name="wardog", desc="War Dog", code="mobs:wardog"})
		end
		if (minetest.registered_entities["mobs:warspider"]) then
			table.insert(mobspawn.mobs,	{name="warspider", desc="War Spider", code="mobs:warspider"})
		end
		if (minetest.registered_entities["mobs:wolf"]) then
			table.insert(mobspawn.mobs,	{name="wolf", desc="Wolf", code="mobs:wolf"})
		end
		if (minetest.registered_entities["mobs:yeti"]) then
			table.insert(mobspawn.mobs,	{name="yeti", desc="Yeti", code="mobs:yeti"})
		end
		
		--table.insert(mobspawn.mobs,	{name="sheep", desc="Sheep", code="mobs:sheep"})
		--table.insert(mobspawn.mobs,	{name="chicken", desc="Chicken", code="mobs:chicken"})
		--table.insert(mobspawn.mobs,	{name="sheep", desc="Sheep", code="mobs:rat"})
		--table.insert(mobspawn.mobs,	{name="cow", desc="Cow", code="mobs:cow"})
		--table.insert(mobspawn.mobs,	{name="bee", desc="Bee", code="mobs:bee"})
		--table.insert(mobspawn.mobs,	{name="warthog", desc="Warthog", code="mobs:warthog"})
	else
		--List all the hostile mobs in Simple Mobs
		table.insert(mobspawn.mobs,	{name="dirt_monster", desc="Dirt Monster", code="mobs:dirt_monster"})
		table.insert(mobspawn.mobs,	{name="sand_monster", desc="Sand Monster", code="mobs:sand_monster"})
		table.insert(mobspawn.mobs,	{name="tree_monster", desc="Tree Monster", code="mobs:tree_monster"})
		table.insert(mobspawn.mobs,	{name="stone_monster", desc="Stone Monster", code="mobs:stone_monster"})
		table.insert(mobspawn.mobs,	{name="oerkki", desc="Oerkki", code="mobs:oerkki"})
		table.insert(mobspawn.mobs,	{name="dungeon_master", desc="Dungeon Master", code="mobs:dungeon_master"})
		
		--table.insert(mobspawn.mobs,	{name="sheep", desc="Sheep", code="mobs:sheep"})
		--table.insert(mobspawn.mobs,	{name="chicken", desc="Chicken", code="mobs:chicken"})
		--table.insert(mobspawn.mobs,	{name="rat", desc="Rat", code="mobs:rat"})
	end
end

if minetest.get_modpath("zmobs") then
	--List all the hostile mobs in ZMobs
	table.insert(mobspawn.mobs,	{name="lava_flan", desc="Lava Flan", code="zmobs:lava_flan"})
	table.insert(mobspawn.mobs,	{name="mese_monster", desc="Mese Monster", code="zmobs:mese_monster"})
end

if minetest.get_modpath("creatures") then
	--List all the hostile mobs in Creatures mod
	table.insert(mobspawn.mobs,	{name="ghost", desc="Ghost", code="creatures:ghost"})
	table.insert(mobspawn.mobs,	{name="zombie", desc="Zombie", code="creatures:zombie"})
	
	--table.insert(mobspawn.mobs,	{name="sheep", desc="Sheep", code="creatures:sheep"})
end

if minetest.get_modpath("senderman") then
	--Add the Senderman
	table.insert(mobspawn.mobs,	{name="senderman", desc="Senderman", code="senderman:senderman"})
end

if minetest.get_modpath("carbone_mobs") then
	--Add the mobs from Carbone
	table.insert(mobspawn.mobs,	{name="dirt_monster", desc="Dirt Monster", code="carbone_mobs:dirt_monster"})
	table.insert(mobspawn.mobs,	{name="sand_monster", desc="Sand Monster", code="carbone_mobs:sand_monster"})
	table.insert(mobspawn.mobs,	{name="tree_monster", desc="Tree Monster", code="carbone_mobs:tree_monster"})
	table.insert(mobspawn.mobs,	{name="stone_monster", desc="Stone Monster", code="carbone_mobs:stone_monster"})
	table.insert(mobspawn.mobs,	{name="oerkki", desc="Oerkki", code="carbone_mobs:oerkki"})
	table.insert(mobspawn.mobs,	{name="dungeon_master", desc="Dungeon Master", code="carbone_mobs:dungeon_master"})
	table.insert(mobspawn.mobs,	{name="trooper", desc="Trooper", code="carbone_mobs:trooper"})
	table.insert(mobspawn.mobs,	{name="rhino", desc="Rhino", code="carbone_mobs:rhino"})
	
	--table.insert(mobspawn.mobs,	{name="sheep", desc="Sheep", code="carbone_mobs:sheep"})
	--table.insert(mobspawn.mobs,	{name="rat", desc="Rat", code="mobs:rat"})
end

if minetest.get_modpath("mobf") then
	--Add mobf mobs
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
	--Peaceful
	
	--if minetest.get_modpath("animal_chicken") then
		--table.insert(mobspawn.mobs,	{name="chicken", desc="Chicken", code="animal_chicken:chicken"})
		--table.insert(mobspawn.mobs,	{name="rooster", desc="Rooster", code="animal_chicken:rooster"})
		--table.insert(mobspawn.mobs,	{name="chick_m", desc="Chick (Male)", code="animal_chicken:chick_m"})
		--table.insert(mobspawn.mobs,	{name="chick_f", desc="Chick (Female)", code="animal_chicken:chick_f"})
	--end
	
	--if minetest.get_modpath("animal_clownfish") then
		--table.insert(mobspawn.mobs,	{name="clownfish", desc="Clownfish", code="animal_clownfish:clownfish"})
	--end
	
	--if minetest.get_modpath("animal_cow") then
		--table.insert(mobspawn.mobs,	{name="cow", desc="Cow", code="animal_cow:cow"})
		--table.insert(mobspawn.mobs,	{name="steer", desc="Steer", code="animal_cow:steer"})
		--table.insert(mobspawn.mobs,	{name="baby_calf_m", desc="Baby Calf (Male)", code="animal_cow:baby_calf_m"})
		--table.insert(mobspawn.mobs,	{name="baby_calf_f", desc="Baby Calf (Female)", code="animal_cow:baby_calf_f"})
	--end
	
	--if minetest.get_modpath("animal_deer") then
		--table.insert(mobspawn.mobs,	{name="deer_m", desc="Deer (Male)", code="animal_deer:deer_m"})
		--table.insert(mobspawn.mobs,	{name="deer_f", desc="Deer (Female)", code="animal_deer:deer_f"})
	--end
	
	--if minetest.get_modpath("animal_fish_blue_white") then
		--table.insert(mobspawn.mobs,	{name="fish_blue_white", desc="Blue and White Fish", code="animal_fish_blue_white:fish_blue_white"})
	--end
	
	--if minetest.get_modpath("animal_gull") then
		--table.insert(mobspawn.mobs,	{name="gull", desc="Gull", code="animal_gull:gull"})
	--end
	
	--if minetest.get_modpath("animal_rat") then
		--table.insert(mobspawn.mobs,	{name="rat", desc="Rat", code="animal_rat:rat"})
	--end
	
	--if minetest.get_modpath("animal_sheep") then
		--table.insert(mobspawn.mobs,	{name="sheep", desc="Sheep", code="animal_sheep:sheep"})
		--table.insert(mobspawn.mobs,	{name="lamb", desc="Lamb", code="animal_sheep:lamb"})
	--end
	
	--if minetest.get_modpath("animal_wolf") then
		--table.insert(mobspawn.mobs,	{name="wolf", desc="Wolf", code="animal_wolf:wolf"})
	--end
	
	--if minetest.get_modpath("mob_bear") then
		--table.insert(mobspawn.mobs,	{name="bear", desc="Bear", code="mob_bear:bear"})
	--end
	
	--if minetest.get_modpath("mob_npc") then
		--table.insert(mobspawn.mobs,	{name="npc", desc="NPC", code="mob_npc:npc"})
	--end
	
	--if minetest.get_modpath("mob_ostrich") then
		--table.insert(mobspawn.mobs,	{name="ostrich_m", desc="Ostrich (Male)", code="mob_ostrich:ostrich_m"})
		--table.insert(mobspawn.mobs,	{name="ostrich_f", desc="Ostrich (Female)", code="mob_ostrich:ostrich_f"})
	--end
	
	--if minetest.get_modpath("mob_shark") then
		--table.insert(mobspawn.mobs,	{name="shark", desc="Shark", code="mob_shark:shark"})
	--end
end

if minetest.get_modpath("spidermob") then
	table.insert(mobspawn.mobs,	{name="spider", desc="Spider", code="spidermob:spider"})
end

if (minetest.get_modpath("ccmobs")) then
	table.insert(mobspawn.mobs,	{name="cc_chicken", desc="Cubic Chicken", code="ccmobs:chicken"})
	table.insert(mobspawn.mobs,	{name="cc_cow", desc="Cubic Cow", code="ccmobs:cow"})
	table.insert(mobspawn.mobs,	{name="cc_nyan_cat", desc="Cubic Nyan Cat", code="ccmobs:nyan_cat"})
	table.insert(mobspawn.mobs,	{name="cc_pig", desc="Cubic Pig", code="ccmobs:pig"})
	table.insert(mobspawn.mobs,	{name="cc_rabbit", desc="Cubic Rabbit", code="ccmobs:rabbit"})
	table.insert(mobspawn.mobs,	{name="cc_sheep", desc="Cubic Sheep", code="ccmobs:sheep"})
end

if (minetest.get_modpath("kpgmobs")) then
	table.insert(mobspawn.mobs,	{name="sheep", desc="Sheep", code="kpgmobs:sheep"})
	table.insert(mobspawn.mobs,	{name="rat", desc="Rat", code="kpgmobs:rat"})
	table.insert(mobspawn.mobs,	{name="bee", desc="Bee", code="kpgmobs:bee"})
	table.insert(mobspawn.mobs,	{name="deer", desc="Deer", code="kpgmobs:deer"})
	table.insert(mobspawn.mobs,	{name="horse", desc="Horse", code="kpgmobs:horse"})
	table.insert(mobspawn.mobs,	{name="horse3", desc="Horse 3", code="kpgmobs:horse3"})
	table.insert(mobspawn.mobs,	{name="horse2", desc="Horse 2", code="kpgmobs:horse2"})
	table.insert(mobspawn.mobs,	{name="horseh1", desc="Horse", code="kpgmobs:horseh1"})
	table.insert(mobspawn.mobs,	{name="horsepegh1", desc="Peg Horse", code="kpgmobs:horsepegh1"})
	table.insert(mobspawn.mobs,	{name="horsearah1", desc="Arabian Horse", code="kpgmobs:horseara1"})
	table.insert(mobspawn.mobs,	{name="wolf", desc="Wolf", code="kpgmobs:wolf"})
	table.insert(mobspawn.mobs,	{name="pumba", desc="Pumba", code="kpgmobs:pumba"})
	table.insert(mobspawn.mobs,	{name="jeraf", desc="Giraffe", code="kpgmobs:jeraf"})
	table.insert(mobspawn.mobs,	{name="medved", desc="Medved", code="kpgmobs:medved"})
	table.insert(mobspawn.mobs,	{name="cow", desc="Cow", code="kpgmobs:cow"})
end

--Create a spawner for each mob
for _,mob in pairs(mobspawn.mobs) do
	minetest.register_node("mobspawn:"..mob.name.."_spawner", {
		description = mob.desc.." Spawner",
		drawtype = "allfaces_optional",
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