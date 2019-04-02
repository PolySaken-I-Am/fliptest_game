
minetest.register_tool("axiscore:stone_hammer", {
	description = "Makeshift Stone Hammer",
	inventory_image = "axiscore_stone_hammer.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[3]=49.60}, uses=10, maxlevel=1},
			choppy = {times={[3]=25.00, [2]=25.00, [1]=25.00}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	groups = {quest_tool=1},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("axiscore:stone_club", {
	description = "Makeshift Stone Club",
	inventory_image = "axiscore_stone_club.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
		},
		damage_groups = {fleshy=3},
	},
	groups = {quest_tool=1},
	sound = {breaks = "default_tool_breaks"},
})

-- Craftsman's Tools

axiscore.handles = {}
axiscore.bindings = {}
axiscore.pickheads = {}
axiscore.axeheads = {}
axiscore.swordblades = {}
axiscore.shovelheads = {}
axiscore.plates = {}

minetest.register_craftitem("axiscore:toolBinding_string", {
	description = "String Tool Binding",
	inventory_image = "axiscore_toolbinding.png^[colorize:#165b0bdf",
	inventory_image2 = "axiscore_bowstring.png^[colorize:#165b0bdf",
	groups = {tool=1},
	snappy = {uses=6, maxlevel=1},
	cracky = {uses=6, maxlevel=1},
	choppy = {uses=6, maxlevel=1},
	crumbly = {uses=6, maxlevel=1},
	attributes = {},
	name2="string",
	displayname="String",
	xtra_dmg=0,
})

table.insert(axiscore.bindings, "axiscore:toolBinding_string")

minetest.register_craftitem("axiscore:pickHead_stone", {
	description = "Stone Pickaxe Head",
	inventory_image = "axiscore_pickhead.png^[colorize:#555555df",
	groups = {stone=1, tool=1},
	cracky = {times={[2]=7.0, [3]=5.00}, uses=6, maxlevel=1},
	attributes = {},
	name2="stone",
	displayname="Basic",
})

table.insert(axiscore.pickheads, "axiscore:pickHead_stone")


function axiscore.register_tool_material(material, name, displayname, displayname2, cooldown, sworddamage, snappy, choppy, cracky, crumbly, matgroups, colorize, attributes, disallow, bow_str, bow_time)
	if not disallow.handle then
		minetest.register_craftitem("axiscore:toolHandle_"..name, {
			description = displayname.." Tool Handle\n"..displayname2,
			inventory_image = "axiscore_toolhandle.png^[colorize:"..colorize,
			inventory_image2 = "axiscore_bowlimbs.png^[colorize:"..colorize,
			inventory_image3 = "axiscore_crossbow.png^[colorize:"..colorize,
			groups = matgroups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
			snappy=snappy,
			choppy=choppy,
			cracky=cracky,
			crumbly=crumbly,
			bowdmg=bow_str or sworddamage,
			drawspeed=bow_time or cooldown,
		})
		minetest.register_craft({
			output = "axiscore:toolHandle_"..name,
			recipe = {
				{'', material, ''},
				{'', material, 'axiscore:craft_hammer'},
				{'', material, ''},
			},
			replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
		})
		table.insert(axiscore.handles, "axiscore:toolHandle_"..name)
	end
	if not disallow.binding then
		minetest.register_craftitem("axiscore:toolBinding_"..name, {
			description = displayname.." Tool Binding\n"..displayname2,
			inventory_image = "axiscore_toolbinding.png^[colorize:"..colorize,
			inventory_image2 = "axiscore_bowstring.png^[colorize:"..colorize,
			inventory_image3 = "axiscore_bowstring_2.png^[colorize:"..colorize,
			groups = matgroups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
			snappy=snappy,
			choppy=choppy,
			cracky=cracky,
			crumbly=crumbly,
			xtra_dmg=sworddamage/2,
		})
		minetest.register_craft({
			output = "axiscore:toolBinding_"..name,
			recipe = {
				{'', 'axiscore:craft_hammer', 'axiscore:craft_knife'},
				{'', material, ''},
				{'', '', ''},
			},
			replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"},{"axiscore:craft_knife","axiscore:craft_knife"}}
		})
		table.insert(axiscore.bindings, "axiscore:toolBinding_"..name)
	end
	if not disallow.plate then
		minetest.register_craftitem("axiscore:metalPlate_"..name, {
			description = displayname.." Plate\n"..displayname2,
			inventory_image = "axiscore_plate.png^[colorize:"..colorize,
			inventory_image2 = "axiscore_cap.png^[colorize:"..colorize,
			inventory_image3 = "axiscore_butt.png^[colorize:"..colorize,
			inventory_image4 = "axiscore_bowgrip.png^[colorize:"..colorize,
			inventory_image5 = "axiscore_greatsword.png^[colorize:"..colorize,
			inventory_image6 = "axiscore_clasp.png^[colorize:"..colorize,
			groups = matgroups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
			snappy=snappy,
			choppy=choppy,
			cracky=cracky,
			crumbly=crumbly,
			armor=armor,
			colorize=colorize,
			cooldown=cooldown,
			sworddamage=sworddamage
		})
		minetest.register_craft({
			output = "axiscore:metalPlate_"..name,
			recipe = {
				{'', 'axiscore:craft_hammer', ''},
				{'', material, ''},
				{'', material, ''},
			},
			replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
		})
		table.insert(axiscore.plates, "axiscore:metalPlate_"..name)
	end
	if not disallow.pick then
		minetest.register_craftitem("axiscore:pickHead_"..name, {
			description = displayname.." Pick Head\n"..displayname2,
			inventory_image = "axiscore_pickhead.png^[colorize:"..colorize,
			groups = matgroups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
			cracky=cracky,
			material=material,
		})
		minetest.register_craft({
			output = "axiscore:pickHead_"..name,
			recipe = {
				{'', 'axiscore:craft_hammer', ''},
				{material, material, material},
				{'', '', ''},
			},
			replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
		})
		table.insert(axiscore.pickheads, "axiscore:pickHead_"..name)
	end
	if not disallow.axe then
		minetest.register_craftitem("axiscore:axeHead_"..name, {
			description = displayname.." Axe Head\n"..displayname2,
			inventory_image = "axiscore_axehead.png^[colorize:"..colorize,
			inventory_image2 = "axiscore_battleaxe.png^[colorize:"..colorize,
			groups = matgroups,
			attributes = attributes,
			name2=name,
			cooldown=cooldown*1.5,
			damage=sworddamage*1.2,
			displayname=displayname,
			choppy=choppy,
			material=material,
		})
		
		minetest.register_craft({
			output = "axiscore:axeHead_"..name,
			recipe = {
				{'', 'axiscore:craft_hammer', ''},
				{'', material, material},
				{'', material, ''},
			},
			replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
		})
		table.insert(axiscore.axeheads, "axiscore:axeHead_"..name)
	end
	if not disallow.shovel then
		minetest.register_craftitem("axiscore:shovelHead_"..name, {
			description = displayname.." Shovel Head\n"..displayname2,
			inventory_image = "axiscore_shovelhead.png^[colorize:"..colorize,
			groups = matgroups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
			crumbly=crumbly,
			material=material,
		})
		minetest.register_craft({
			output = "axiscore:shovelHead_"..name,
			recipe = {
				{'', '', ''},
				{'', material, 'axiscore:craft_hammer'},
				{'', '', ''},
			},
			replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
		})
		table.insert(axiscore.shovelheads, "axiscore:shovelHead_"..name)
	end
	if not disallow.sword then
		minetest.register_craftitem("axiscore:swordBlade_"..name, {
			description = displayname.." Sword Blade\n"..displayname2.."\n+"..sworddamage.." Attack Damage",
			inventory_image = "axiscore_swordhead.png^[colorize:"..colorize,
			groups = matgroups,
			attributes = attributes,
			name2=name,
			cooldown=cooldown,
			sworddamage=sworddamage,
			displayname=displayname,
			snappy=snappy,
			material=material,
		})
		minetest.register_craft({
			output = "axiscore:swordBlade_"..name,
			recipe = {
				{'', 'axiscore:craft_hammer', ''},
				{'', material, ''},
				{'', material, ''},
			},
			replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
		})
		table.insert(axiscore.swordblades, "axiscore:swordBlade_"..name)
	end
end

axiscore.register_tool_material(
	"default:steel_ingot", 
	"steel", 
	"Steel", 
	"Steel", 
	0.8, 
	6, 
	{times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=10, maxlevel=2}, -- snappy
	{times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=6, maxlevel=2}, -- choppy
	{times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=6, maxlevel=2}, -- cracky 
	{times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=10, maxlevel=2}, -- crumbly
	{	
		metal=1,
		steel=1,
		tool=1,
		qn_output=1,
	},
	"#ffffff00", 
	{
		{
			name="\nFerrous",
			type="pick",
			func=function(pos, node, digger)
				if node.name=="default:stone_with_iron" then
					digger:get_inventory():add_item("main", "default:iron_lump")
				end
				return true
			end,
		}
	}, 
	{},
	19,
	5
)

axiscore.register_tool_material(
	"default:wood", 
	"apple_wood", 
	"Apple", 
	"Apple Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		apple=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=1,
	},
	"#775208d0", 
	{
		{
			name=minetest.colorize("#775208", "\nDendric"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"default:acacia_wood", 
	"acacia_wood", 
	"Acacia", 
	"Acacia Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		acacia=1,
		tool=1,
		qn_cost=3,
		qn_efficiency=5,
	},
	"#c6401bd0", 
	{
		{
			name=minetest.colorize("#c6401b", "\nBloodrite"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"default:pine_wood", 
	"pine_wood", 
	"Pine", 
	"Pine Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		pine=1,
		tool=1,
		qn_cost=2,
		qn_efficiency=1,
	},
	"#e8d8abd0", 
	{
		{
			name=minetest.colorize("#e8d8ab", "\nSticky"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"default:junglewood", 
	"junglewood", 
	"Jungle", 
	"Jungle Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		jungle=1,
		tool=1,
		qn_cost=2,
		qn_efficiency=2,
	},
	"#663636d0", 
	{
		{
			name=minetest.colorize("#663636", "\nDense"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"default:aspen_wood", 
	"aspen_wood", 
	"Aspen", 
	"Aspen Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		aspen=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=2,
	},
	"#fffdefd0", 
	{
		{
			name=minetest.colorize("#fffdef", "\nLight"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"ethereal:banana_wood", 
	"banana_wood", 
	"Banana", 
	"Banana Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		banana=1,
		tool=1,
		qn_cost=2,
		qn_efficiency=1,
	},
	"#d1cfadd0", 
	{
		{
			name=minetest.colorize("#fffaa0", "\nGriggly"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"ethereal:birch_wood", 
	"birch_wood", 
	"Birch", 
	"Birch Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		birch=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=2,
	},
	"#fffde0d0", 
	{
		{
			name=minetest.colorize("#fffde0", "\nPapery"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"ethereal:mushroom_trunk", 
	"mushroom_trunk", 
	"Fungal", 
	"Woody Mushroom", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		mushroom=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=2,
	},
	"#e2e2ccd0", 
	{
		{
			name=minetest.colorize("#c1c1b4", "\nGrubby"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"ethereal:palm_wood", 
	"palm_wood", 
	"Palm", 
	"Coconut Palm Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		palm=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=2,
	},
	"#eacfa6d0", 
	{
		{
			name=minetest.colorize("#eacfa6", "\nOily"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	9,
	nil
)

axiscore.register_tool_material(
	"dfcaverns:black_cap_wood", 
	"blackcap_wood", 
	"Black Cap", 
	"Black Cap Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		blackcap=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=5,
	},
	"#2c073ad0", 
	{
		{
			name=minetest.colorize("#2c073a", "\nUmbral"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	13,
	nil
)

axiscore.register_tool_material(
	"dfcaverns:blood_thorn_wood", 
	"bloodthorn_wood", 
	"Blood Thorn", 
	"Blood Thorn Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		bloodthorn=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=5,
	},
	"#5b0606d0", 
	{
		{
			name=minetest.colorize("#5b0606", "\nVisceral"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	13,
	nil
)

axiscore.register_tool_material(
	"dfcaverns:goblin_cap_wood", 
	"goblin_cap_wood", 
	"Goblin Cap", 
	"Goblin Cap", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		goblincap=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=2,
	},
	"#ffa500d0", 
	{
		{
			name=minetest.colorize("#c1c1b4", "\nGrubby"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	13,
	nil
)

axiscore.register_tool_material(
	"dfcaverns:nether_cap_wood", 
	"nether_cap_wood", 
	"Nether Cap", 
	"Nether Cap", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		goblincap=1,
		tool=1,
		qn_cost=2,
		qn_efficiency=5,
	},
	"#174393d0", 
	{
		{
			name=minetest.colorize("#174393", "\nDepth Treader"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	13,
	nil
)

axiscore.register_tool_material(
	"dfcaverns:fungiwood_wood", 
	"fungiwood_wood", 
	"Mycelial", 
	"Fungi Wood",
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		goblincap=1,
		tool=1,
		qn_cost=3,
		qn_efficiency=5,
	},
	"#eae8c5d0", 
	{
		{
			name=minetest.colorize("#3c540c", "\nDank"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	13,
	nil
)

axiscore.register_tool_material(
	"dfcaverns:tunnel_tube_wood", 
	"tunnel_tube_wood", 
	"Compound Fungus", 
	"Tunnel Tube Pile",
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		goblincap=1,
		tool=1,
		qn_cost=3,
		qn_efficiency=5,
	},
	"#ce2bd1d0", 
	{
		{
			name=minetest.colorize("#ce2bd1", "\nLayered"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	13,
	nil
)

axiscore.register_tool_material(
	"dfcaverns:spore_tree_wood", 
	"spore_tree_wood", 
	"Interwood", 
	"Spore Tree Planks",
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		goblincap=1,
		tool=1,
		qn_cost=3,
		qn_efficiency=5,
	},
	"#fffdefd0", 
	{
		{
			name=minetest.colorize("#fffdef", "\nConnected"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	13,
	nil
)

axiscore.register_tool_material(
	"dfcaverns:tower_cap_wood", 
	"tower_cap_wood", 
	"Towerwood", 
	"Tower Cap Planks",
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		goblincap=1,
		tool=1,
		qn_cost=3,
		qn_efficiency=5,
	},
	"#fffdefd0", 
	{
		{
			name=minetest.colorize("#fffdef", "\nInfested"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	13,
	nil
)

axiscore.register_tool_material(
	"ethereal:frost_wood", 
	"frost_wood", 
	"Frostwood", 
	"Frost Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		frost=1,
		tool=1,
		qn_cost=2,
		qn_efficiency=4,
	},
	"#6484d1d0", 
	{
		{
			name=minetest.colorize("#6484d1", "\nIcy"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	11,
	nil
)

axiscore.register_tool_material(
	"ethereal:redwood_wood", 
	"redwood_wood", 
	"Redwood", 
	"Redwood Wood", 
	1, 
	2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		woodhandle=1,
		redwood=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=3,
	},
	"#421b03d0", 
	{
		{
			name=minetest.colorize("#421b03", "\nImmense"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1, plate=1, sword=1, shovel=1, axe=1, pick=1},
	15,
	nil
)

axiscore.register_tool_material(
	"ethereal:yellow_wood", 
	"healing_wood", 
	"Healing", 
	"Healing Wood", 
	1, 
	-2, 
	{times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1}, -- snappy
	{times={[2]=3.00, [3]=1.60}, uses=10, maxlevel=1}, -- choppy
	{times={[3]=1.60}, uses=10, maxlevel=1}, -- cracky
	{times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=10, maxlevel=1}, -- crumbly
	{	
		healing=1,
		tool=1,
		qn_cost=1,
		qn_efficiency=4,
	},
	"#ceff89d0", 
	{
		{
			name=minetest.colorize("#ceff89", "\nBenevolent"),
			type="all",
			func=function(pos, node, digger)
				digger:set_hp(digger:get_hp()+1)
			end,
		}
	}, 
	{binding=1, plate=1},
	-5,
	nil
)

axiscore.register_tool_material(
	"default:bronze_ingot", 
	"bronze", 
	"Bronze", 
	"Bronze", 
	0.8, 
	4, 
	{times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=13, maxlevel=2}, -- snappy
	{times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=10, maxlevel=2}, -- choppy
	{times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=10, maxlevel=2}, -- cracky
	{times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=13, maxlevel=2}, -- crumbly
	{	
		metal=1,
		bronze=1,
		tin=1,
		copper=1,
		tool=1,
		qn_output=2,
	},
	"#c1800fd0", 
	{
		{
			name=minetest.colorize("#c1800f", "\nComposite"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{},
	31,
	7
)

axiscore.register_tool_material(
	"default:copper_ingot", 
	"copper", 
	"Copper", 
	"Copper", 
	0.8, 
	4, 
	{times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=9, maxlevel=2}, -- snappy
	{times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=5, maxlevel=2}, -- choppy
	{times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=5, maxlevel=2}, -- cracky
	{times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=8, maxlevel=2}, -- crumbly
	{	
		metal=1,
		copper=1,
		tool=1,
		qn_output=3,
	},
	"#e29714d0", 
	{
		{
			name=minetest.colorize("#e29714", "\nConductive"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{},
	7,
	2
)

axiscore.register_tool_material(
	"default:tin_ingot", 
	"tin", 
	"Tin", 
	"Tin", 
	0.9, 
	7, 
	{times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=10, maxlevel=2}, -- snappy
	{times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=6, maxlevel=2}, -- choppy
	{times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=10, maxlevel=2}, -- cracky
	{times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=13, maxlevel=2}, -- crumbly
	{	
		metal=1,
		tin=1,
		tool=1,
		qn_output=1,
	},
	"#aaaaaad0", 
	{
		{
			name=minetest.colorize("#c1800f", "\nPapercut"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{},
	9,
	3
)

axiscore.register_tool_material(
	"ethereal:crystal_ingot", 
	"crystal", 
	"Crystalline", 
	"Crystal", 
	0.6, 
	10, 
	{times={[1]=1.70, [2]=0.70, [3]=0.25}, uses=17, maxlevel=3}, -- snappy
	{times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=13, maxlevel=3}, -- choppy
	{times={[1]=1.8, [2]=0.8, [3]=0.40}, uses=13, maxlevel=3}, -- cracky 
	{times={[1]=1.10, [2]=0.50, [3]=0.30}, uses=10, maxlevel=3}, -- crumbly
	{	
		crystal=1,
		tool=1,
	},
	"#59dbf2d0", 
	{
		{
			name=minetest.colorize("#59dbf2", "\nDelicate"),
			type="all",
			func=function(pos, node, digger)
				minetest.after(0.1, function()
					if minetest.registered_nodes[node.name].drop then
						digger:get_inventory():remove_item("main", minetest.registered_nodes[node.name].drop)
						digger:get_inventory():add_item("main", node.name)
					end
				end)
			end,
		}
	}, 
	{binding=1,
	 handle=1,
	 plate=1},
	nil,
	nil
)

axiscore.register_tool_material(
	"default:gold_ingot", 
	"gold", 
	"Gold", 
	"Gold", 
	0.8, 
	4, 
	{times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=10, maxlevel=2}, -- snappy
	{times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=6, maxlevel=2}, -- choppy
	{times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=6, maxlevel=2}, -- cracky
	{times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=9, maxlevel=2}, -- crumbly
	{	
		metal=1,
		gold=1,
		tool=1,
		qn_output=5,
	},
	"#e5ce00d0", 
	{
		{
			name=minetest.colorize("#e5ce00", "\nExpensive"),
			type="pick",
			func=function(pos, node, digger)
				if node.name=="default:stone_with_gold" then
					digger:get_inventory():add_item("main", "default:gold_lump")
				end
			end,
		}
	}, 
	{},
	2,
	1
)

axiscore.register_tool_material(
	"moreores:silver_ingot", 
	"silver", 
	"Silver", 
	"Silver", 
	1.0, 
	6, 
	{times = {[2] = 0.70, [3] = 0.30}, uses = 33, maxlevel= 1}, -- snappy
	{times = {[1] = 2.50, [2] = 0.80, [3] = 0.50}, uses = 33, maxlevel= 1}, -- choppy
	{times = {[1] = 2.60, [2] = 1.00, [3] = 0.60}, uses = 33, maxlevel= 1}, -- cracky 
	{times = {[1] = 1.10, [2] = 0.40, [3] = 0.25}, uses = 33, maxlevel= 1}, -- crumbly
	{	
		metal=1,
		silver=1,
		tool=1,
		qn_output=4,
	},
	"#c9d6ddd0", 
	{
		{
			name=minetest.colorize("#c9d6dd", "\nWolfsbane"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{},
	14,
	3
)

axiscore.register_tool_material(
	"moreores:mithril_ingot", 
	"mithril", 
	"Mithril", 
	"Mithril", 
	0.45, 
	9, 
	{times = {[2] = 0.70, [3] = 0.25}, uses = 66, maxlevel= 2}, -- snappy
	{times = {[1] = 1.75, [2] = 0.45, [3] = 0.45}, uses = 66, maxlevel= 2}, -- choppy
	{times = {[1] = 2.25, [2] = 0.55, [3] = 0.35}, uses = 66, maxlevel= 2}, -- cracky 
	{times = {[1] = 0.70, [2] = 0.35, [3] = 0.20}, uses = 66, maxlevel= 2}, -- crumbly
	{	
		metal=1,
		mithril=1,
		tool=1,
		qn_output=5,
	},
	"#5622e6d0", 
	{
		{
			name=minetest.colorize("#af38ff", "\nMythic"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{},
	31,
	7
)

axiscore.register_tool_material(
	"default:mese_crystal", 
	"mese", 
	"Mese", 
	"Mese", 
	0.7, 
	7, 
	{times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=10, maxlevel=3}, -- snappy
	{times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=6, maxlevel=3}, -- choppy
	{times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=6, maxlevel=3}, -- cracky 
	{times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=6, maxlevel=3}, -- crumbly
	{	
		mese=1,
		tool=1,
	},
	"#ffff00d0", 
	{
		{
			name=minetest.colorize("#ffff00", "\nAlien"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1,
	 handle=1,
	 plate=1},
	 nil,
	 nil
)

axiscore.register_tool_material(
	"dfcaverns:glow_ruby_ore", 
	"glow_ruby_ore", 
	"Interruby", 
	"Interruby Ore", 
	0.6, 
	9, 
	{times={[1]=2.0, [2]=1.00, [3]=0.35}, uses=10, maxlevel=3}, -- snappy
	{times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=6, maxlevel=3}, -- choppy
	{times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=6, maxlevel=3}, -- cracky 
	{times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=6, maxlevel=3}, -- crumbly
	{	
		mese=1,
		tool=1,
	},
	"#ff328bd0", 
	{
	{
			name=minetest.colorize("#ceff89", "\nBenevolent"),
			type="all",
			func=function(pos, node, digger)
				digger:set_hp(digger:get_hp()+1)
			end,
		}
	}, 
	{binding=1,
	 handle=1,
	 plate=1},
	 nil,
	 nil
)

axiscore.register_tool_material(
	"bonemeal:bone", 
	"bone", 
	"Boney", 
	"Bone", 
	0.99, 
	8, 
	{times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=6, maxlevel=2}, -- snappy
	{times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=5, maxlevel=2}, -- choppy
	{times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=5, maxlevel=2}, -- cracky 
	{times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=6, maxlevel=2}, -- crumbly
	{	
		bone=1,
		tool=1,
	},
	"#ffffffd0", 
	{
		{
			name=minetest.colorize("#ffffff", "\nMorbid"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1,
	 shovel=1,
	 plate=1},
	 nil,
	 nil
)

axiscore.register_tool_material(
	"default:obsidian", 
	"obsidian", 
	"Obsidian", 
	"Obsidian", 
	0.8, 
	11, 
	{times={[1]=3.0, [2]=2.00, [3]=0.70}, uses=0, maxlevel=3}, -- snappy
	{times={[1]=3.20, [2]=2.00, [3]=0.90}, uses=0, maxlevel=3}, -- choppy
	{times={[1]=3.4, [2]=2.4, [3]=0.90}, uses=0, maxlevel=3}, -- cracky 
	{times={[1]=2.40, [2]=0.90, [3]=0.60}, uses=0, maxlevel=3}, -- crumbly
	{	
		obsidian=1,
		tool=1,
	},
	"#200c49d0", 
	{
		{
			name=minetest.colorize("#ff9900", "\nVolcanic"),
			type="pick",
			func=function(pos, node, digger)
				minetest.after(0.1, function()
					if node.name=="default:stone_with_diamond" then
						digger:get_inventory():remove_item("main", "default:diamond")
						digger:get_inventory():add_item("main", "mobs:lava_orb")
					end
					return true
				end)
			end,
		}
	}, 
	{binding=1,
	 handle=1,
	 plate=1},
	 nil,
	 nil
)

axiscore.register_tool_material(
	"mobs:lava_orb", 
	"lava", 
	"Magmatic", 
	"Lava", 
	0.5, 
	15, 
	{times={[1]=0.80, [2]=0.20, [3]=0.10}, uses=40, maxlevel=3}, -- snappy
	{times={[1]=1.80, [2]=0.80, [3]=0.40}, uses=40, maxlevel=3}, -- choppy
	{times={[1]=1.80, [2]=0.80, [3]=0.40}, uses=40, maxlevel=3}, -- cracky 
	{times={[1]=1.40, [2]=0.40, [3]=0.20}, uses=40, maxlevel=3}, -- crumbly
	{	
		lava=1,
		tool=1,
		qn_output=1,
	},
	"#ff7f00ef", 
	{
		{
			name=minetest.colorize("#ff0000", "\nHellfire"),
			type="all",
			func=function(pos, node, digger)
				minetest.after(0.1, function()
					if minetest.registered_nodes[node.name].drop then
						local cooked = minetest.get_craft_result({
							method = "cooking",
							width = 1,
							items = {minetest.registered_nodes[node.name].drop}
						})
						if cooked and cooked.item ~= nil and cooked.item ~= {} then
							digger:get_inventory():remove_item("main", minetest.registered_nodes[node.name].drop)
							digger:get_inventory():add_item("main", minetest.get_craft_result({method = "cooking", width = 1, items = {minetest.registered_nodes[node.name].drop}}).item)
							
						end
					else
						local cooked = minetest.get_craft_result({
							method = "cooking",
							width = 1,
							items = {node.name}
						})
						if cooked and cooked.item ~= nil and cooked.item ~= {} then
							digger:get_inventory():remove_item("main", node.name)
							digger:get_inventory():add_item("main", minetest.get_craft_result({method = "cooking", width = 1, items = {node.name}}).item)
							
						end
					end
				end)
			end,
		}
	}, 
	{binding=1,
	 handle=1},
	nil,
	nil
)

local function tableHasKey(table,key)
    return table[key] ~= nil
end

for _,head in ipairs(axiscore.pickheads) do
	for __,binding in ipairs(axiscore.bindings) do
		for ___,handle in ipairs(axiscore.handles) do
			local head_def = ItemStack(head):get_definition()
			local binding_def = ItemStack(binding):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			local attrlist = {}
			for _,attr in ipairs(head_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(binding_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(handle_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			local attrpt=""
			for a,n in pairs(attrlist) do
				attrpt=attrpt..a.." "..n.level
			end
			if head=="axiscore:pickHead_stone" and minetest.get_item_group(handle, "wood") and binding=="axiscore:toolBinding_string" then
				minetest.register_tool("axiscore:pick_".._..__..___, {
					description = head_def.displayname.." Pickaxe"..attrpt,
					inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image..")",
					tool_capabilities = {
						full_punch_interval = 1.2,
						max_drop_level=0,
						groupcaps={
							cracky = {times={[1]=head_def.cracky.times[1], [2]=head_def.cracky.times[2], [3]=head_def.cracky.times[3]}, uses=head_def.cracky.uses+handle_def.cracky.uses+binding_def.cracky.uses, maxlevel=head_def.cracky.maxlevel},
						},
						damage_groups = {fleshy=2},
					},
					sound = {breaks = "default_tool_breaks"},
					attributes=head_def.attributes,
				})
			else
				minetest.register_tool("axiscore:pick_".._..__..___, {
					description = head_def.displayname.." Pickaxe"..attrpt,
					inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image..")",
					tool_capabilities = {
						full_punch_interval = 1.2,
						max_drop_level=0,
						groupcaps={
							cracky = {times={[1]=head_def.cracky.times[1], [2]=head_def.cracky.times[2], [3]=head_def.cracky.times[3]}, uses=head_def.cracky.uses+handle_def.cracky.uses+binding_def.cracky.uses, maxlevel=head_def.cracky.maxlevel},
						},
						damage_groups = {fleshy=2},
					},
					groups = {not_in_creative_inventory=1},
					sound = {breaks = "default_tool_breaks"},
					attributes=head_def.attributes,
				})
			end
			minetest.register_craft({
				output = "axiscore:pick_".._..__..___,
				recipe = {
					{'', head, ''},
					{'', binding, ''},
					{'', handle, ''},
				},
			})
			minetest.register_craft({
				output = "axiscore:pick_".._..__..___,
				type="shapeless",
				recipe = {"axiscore:pick_".._..__..___, head_def.material,},
			})
		end
	end
end

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		local stack = digger:get_wielded_item()
		if string.split(stack:get_name(), "_")[1]=="axiscore:pick" then
			for _,attr in ipairs(stack:get_definition().attributes) do
				if attr.type=="pick" or attr.type=="all" then
					attr.func(pos, node, digger)
				end
			end
		end
	end
end)



for _,head in ipairs(axiscore.axeheads) do
	for __,binding in ipairs(axiscore.bindings) do
		for ___,handle in ipairs(axiscore.handles) do
			local head_def = ItemStack(head):get_definition()
			local binding_def = ItemStack(binding):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			local attrlist = {}
			for _,attr in ipairs(head_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(binding_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(handle_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			local attrpt=""
			for a,n in pairs(attrlist) do
				attrpt=attrpt..a.." "..n.level
			end
			minetest.register_tool("axiscore:axe_".._..__..___, {
				description = head_def.displayname.." Axe"..attrpt,
				inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image..")",
				tool_capabilities = {
					full_punch_interval = head_def.cooldown,
					max_drop_level=0,
					groupcaps={
						choppy = {times={[1]=head_def.choppy.times[1], [2]=head_def.choppy.times[2], [3]=head_def.choppy.times[3]}, uses=head_def.choppy.uses+handle_def.choppy.uses+binding_def.choppy.uses, maxlevel=head_def.choppy.maxlevel},
					},
					damage_groups = {fleshy=head_def.damage},
				},
				groups = {not_in_creative_inventory=1},
				sound = {breaks = "default_tool_breaks"},
				attributes=head_def.attributes,
			})
			minetest.register_craft({
				output = "axiscore:axe_".._..__..___,
				recipe = {
					{'', head, ''},
					{'', binding, ''},
					{'', handle, ''},
				},
			})
			minetest.register_craft({
				output = "axiscore:axe_".._..__..___,
				type="shapeless",
				recipe = {"axiscore:axe_".._..__..___, head_def.material,},
			})
		end
	end
end

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		local stack = digger:get_wielded_item()
		if string.split(stack:get_name(), "_")[1]=="axiscore:axe" then
			for _,attr in ipairs(stack:get_definition().attributes) do
				if attr.type=="axe" or attr.type=="all" then
					attr.func(pos, node, digger)
				end
			end
		end
	end
end)


for _,head in ipairs(axiscore.shovelheads) do
	for __,binding in ipairs(axiscore.bindings) do
		for ___,handle in ipairs(axiscore.handles) do
			local head_def = ItemStack(head):get_definition()
			local binding_def = ItemStack(binding):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			local attrlist = {}
			for _,attr in ipairs(head_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(binding_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(handle_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			local attrpt=""
			for a,n in pairs(attrlist) do
				attrpt=attrpt..a.." "..n.level
			end
			minetest.register_tool("axiscore:shovel_".._..__..___, {
				description = head_def.displayname.." Shovel"..attrpt,
				inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image..")",
				tool_capabilities = {
					full_punch_interval = head_def.cooldown,
					max_drop_level=0,
					groupcaps={
						crumbly = {times={[1]=head_def.crumbly.times[1], [2]=head_def.crumbly.times[2], [3]=head_def.crumbly.times[3]}, uses=head_def.crumbly.uses+handle_def.crumbly.uses+binding_def.crumbly.uses, maxlevel=head_def.crumbly.maxlevel},
					},
					damage_groups = {fleshy=2},
				},
				groups = {not_in_creative_inventory=1},
				sound = {breaks = "default_tool_breaks"},
				attributes=head_def.attributes,
			})
			minetest.register_craft({
				output = "axiscore:shovel_".._..__..___,
				recipe = {
					{'', head, ''},
					{'', binding, ''},
					{'', handle, ''},
				},
			})
			minetest.register_craft({
				output = "axiscore:shovel_".._..__..___,
				type="shapeless",
				recipe = {"axiscore:shovel_".._..__..___, head_def.material,},
			})
		end
	end
end

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		local stack = digger:get_wielded_item()
		if string.split(stack:get_name(), "_")[1]=="axiscore:shovel" then
			for _,attr in ipairs(stack:get_definition().attributes) do
				if attr.type=="shovel" or attr.type=="all" then
					attr.func(pos, node, digger)
				end
			end
		end
	end
end)

for _,head in ipairs(axiscore.swordblades) do
	for __,binding in ipairs(axiscore.bindings) do
		for ___,handle in ipairs(axiscore.handles) do
			local head_def = ItemStack(head):get_definition()
			local binding_def = ItemStack(binding):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			local attrlist = {}
			for _,attr in ipairs(head_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(binding_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(handle_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			local attrpt=""
			for a,n in pairs(attrlist) do
				attrpt=attrpt..a.." "..n.level
			end
			minetest.register_tool("axiscore:sword_".._..__..___, {
				description = head_def.displayname.." Sword"..attrpt.."\n+"..head_def.sworddamage.." Attack Damage",
				inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image..")",
				tool_capabilities = {
					full_punch_interval = head_def.cooldown,
					max_drop_level=0,
					groupcaps={
						snappy = {times={[1]=head_def.snappy.times[1], [2]=head_def.snappy.times[2], [3]=head_def.snappy.times[3]}, uses=head_def.snappy.uses+handle_def.snappy.uses+binding_def.snappy.uses, maxlevel=head_def.snappy.maxlevel},
					},
					damage_groups = {fleshy=head_def.sworddamage, uses=head_def.snappy.uses},
				},
				groups = {not_in_creative_inventory=1},
				sound = {breaks = "default_tool_breaks"},
				attributes=head_def.attributes,
			})
			minetest.register_craft({
				output = "axiscore:sword_".._..__..___,
				recipe = {
					{'', head, ''},
					{'', binding, ''},
					{'', handle, ''},
				},
			})
			minetest.register_craft({
				output = "axiscore:sword_".._..__..___,
				type="shapeless",
				recipe = {"axiscore:sword_".._..__..___, head_def.material,},
			})
		end
	end
end

for _,head in ipairs(axiscore.plates) do
		for ___,handle in ipairs(axiscore.handles) do
			local head_def = ItemStack(head):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			local attrlist = {}
			for _,attr in ipairs(head_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(handle_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			local attrpt=""
			for a,n in pairs(attrlist) do
				attrpt=attrpt..a.." "..n.level
			end
			minetest.register_tool("axiscore:greatsword_".._..___, {
				description = head_def.displayname.." Greatsword"..attrpt.."\n+".. 1.5*head_def.sworddamage.." Attack Damage",
				inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image5..")",
				tool_capabilities = {
					full_punch_interval = head_def.cooldown*2,
					max_drop_level=0,
					groupcaps={
						snappy = {times={[1]=head_def.snappy.times[1], [2]=head_def.snappy.times[2], [3]=head_def.snappy.times[3]}, uses=head_def.snappy.uses+handle_def.snappy.uses, maxlevel=head_def.snappy.maxlevel},
					},
					damage_groups = {fleshy=head_def.sworddamage*1.5},
				},
				groups = {not_in_creative_inventory=1},
				sound = {breaks = "default_tool_breaks"},
				attributes=head_def.attributes,
			})
			minetest.register_craft({
				output = "axiscore:greatsword_".._..___,
				recipe = {
					{'', head, ''},
					{'', head, ''},
					{'', handle, ''},
				},
			})
			minetest.register_craft({
				output = "axiscore:greatsword_".._..___,
				type="shapeless",
				recipe = {"axiscore:greatsword_".._..___, head_def.material,},
			})
		end
end

for _,head in ipairs(axiscore.axeheads) do
	for __,binding in ipairs(axiscore.bindings) do
		for ___,handle in ipairs(axiscore.handles) do
			local head_def = ItemStack(head):get_definition()
			local binding_def = ItemStack(binding):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			local attrlist = {}
			for _,attr in ipairs(head_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(binding_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(handle_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			local attrpt=""
			for a,n in pairs(attrlist) do
				attrpt=attrpt..a.." "..n.level
			end
			minetest.register_tool("axiscore:battleaxe_".._..__..___, {
				description = head_def.displayname.." Battleaxe"..attrpt.."\n+".. 1.5*head_def.damage.." Attack Damage",
				inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image2..")",
				tool_capabilities = {
					full_punch_interval = head_def.cooldown*3,
					max_drop_level=0,
					groupcaps={
						choppy = {times={[1]=head_def.choppy.times[1], [2]=head_def.choppy.times[2], [3]=head_def.choppy.times[3]}, uses=head_def.choppy.uses+handle_def.choppy.uses+binding_def.choppy.uses, maxlevel=head_def.choppy.maxlevel},
					},
					damage_groups = {fleshy=head_def.damage*2.1},
				},
				groups = {not_in_creative_inventory=1},
				sound = {breaks = "default_tool_breaks"},
				attributes=head_def.attributes,
			})
			minetest.register_craft({
				output = "axiscore:battleaxe_".._..__..___,
				recipe = {
					{head, binding, head},
					{'', handle, ''},
					{'', handle, ''},
				},
			})
			minetest.register_craft({
				output = "axiscore:axe_".._..__..___,
				type="shapeless",
				recipe = {"axiscore:axe_".._..__..___, head_def.material,},
			})
		end
	end
end

local function set_draw(player, n)
	player:set_attribute("axiscore_draw", n)
	player:set_attribute("axiscore_bowspeed", speed)
	player:set_attribute("axiscore_bowdmg", damage)
end

local function get_draw(player)
	return tonumber(player:get_attribute("axiscore_draw"))
end

local function startDraw(item, player)
	set_draw(player, 1)
end

axiscore.bow_tmp={}

local function fire(player)
	local pos = player:getpos()
	local dir = player:get_look_dir()
	local yaw = player:get_look_yaw()
	if pos and dir and yaw then
		pos.y = pos.y + 1.6
		axiscore.bow_tmp=player:get_wielded_item():get_definition().dmg
		local obj = minetest.add_entity(pos, "axiscore:arrow")
		if obj then
			obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
			obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
			obj:setyaw(yaw + math.pi)
		end
	end
end

minetest.register_craftitem("axiscore:arrow", {
	description = "Arrow",
	inventory_image = "axiscore_arrow.png",
})

local proj = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.3, y=0.3},
	textures = {"axiscore:arrow"},
	lastpos= {},
	collisionbox = {0.1, 0.1, 0.1, 0.1, 0.1, 0.1},
}
proj.on_activate = function(self, staticdata)
	if axiscore.bow_tmp then
		self.se=axiscore.bow_tmp
	else
		self.object:remove()
	end
end
proj.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.065 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1.5)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "axiscore:arrow" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = self.se
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					self.object:remove()
				end
			else
				local damage = self.se
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
	minetest.add_particle({
		pos = pos,
		velocity = {x=0, y=0, z=0},
		acceleration = {x=0, y=0, z=0},
		expirationtime = 1,
		size = 0.3,
		collisiondetection = false,
		vertical = false,
		texture = "axiscore_trail.png",
	})
end

minetest.register_entity("axiscore:arrow", proj )



minetest.register_on_newplayer(function(player)
	set_draw(player, 0)
end)

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if get_draw(player) then
			if string.split(player:get_wielded_item():get_name(), "_")[1]=="axiscore:bow" then
				if get_draw(player) > 0 then
					if player:get_player_control().LMB then
						if player:get_wielded_item():get_definition().speed and get_draw(player) < player:get_wielded_item():get_definition().speed*10 then
							set_draw(player, get_draw(player)+1)
						else
							player:get_inventory():remove_item("main", "axiscore:arrow")
							fire(player)
							set_draw(player, 0, nil, nil)
						end
					end
				end
			end
		else
			set_draw(player, 0, nil, nil)
		end
	end
end)

for _,head in ipairs(axiscore.plates) do
	for __,binding in ipairs(axiscore.bindings) do
		for ___,handle in ipairs(axiscore.handles) do
			local head_def = ItemStack(head):get_definition()
			local binding_def = ItemStack(binding):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			local attrlist = {}
			for _,attr in ipairs(head_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(binding_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			for _,attr in ipairs(handle_def.attributes) do
				if attr.name then
					if not tableHasKey(attrlist, attr.name) then
						attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
					else
						attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
					end
				end
			end
			local attrpt=""
			for a,n in pairs(attrlist) do
				attrpt=attrpt..a.." "..n.level
			end
			minetest.register_tool("axiscore:bow_".._..__..___, {
				description = handle_def.displayname.." Bow"..attrpt.."\nBow Pull Time: "..handle_def.drawspeed.."\nBow Damage: "..handle_def.bowdmg+binding_def.xtra_dmg,
				inventory_image = "("..handle_def.inventory_image2..")^("..head_def.inventory_image4..")^("..binding_def.inventory_image2..")",
				groups = {not_in_creative_inventory=1},
				sound = {breaks = "default_tool_breaks"},
				attributes=attrlist,
				speed=handle_def.drawspeed,
				dmg=handle_def.bowdmg+binding_def.xtra_dmg,
				on_use=function(itemstack, player, pointed)
					if player:get_inventory():contains_item("main", "axiscore:arrow") then
						startDraw(itemstack, player)
						itemstack:add_wear(500)
					end
					return itemstack
				end
			})
			minetest.register_craft({
				output = "axiscore:bow_".._..__..___,
				recipe = {
					{'', handle, binding},
					{head, '', binding},
					{'', handle, binding},
				},
			})
			minetest.register_craft({
				output = "axiscore:bow_".._..__..___,
				type="shapeless",
				recipe = {"axiscore:bow_".._..__..___, head_def.material,},
			})
		end
	end
end
