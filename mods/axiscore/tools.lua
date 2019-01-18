
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


minetest.register_craftitem("axiscore:toolHandle_wood", {
	description = "Wooden Tool Handle",
	inventory_image = "axiscore_toolhandle.png^[colorize:#775208df",
	groups = {tool=1},
	snappy = {uses=6, maxlevel=1},
	cracky = {uses=6, maxlevel=1},
	choppy = {uses=6, maxlevel=1},
	crumbly = {uses=6, maxlevel=1},
	attributes = {},
	name2="wood",
	displayname="Wood",
})

table.insert(axiscore.handles, "axiscore:toolHandle_wood")

minetest.register_craftitem("axiscore:toolBinding_string", {
	description = "String Tool Binding",
	inventory_image = "axiscore_toolbinding.png^[colorize:#165b0bdf",
	groups = {tool=1},
	snappy = {uses=6, maxlevel=1},
	cracky = {uses=6, maxlevel=1},
	choppy = {uses=6, maxlevel=1},
	crumbly = {uses=6, maxlevel=1},
	attributes = {},
	name2="string",
	displayname="String",
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


function axiscore.register_tool_material(material, name, displayname, displayname2, cooldown, sworddamage, snappy, choppy, cracky, crumbly, matgroups, colorize, attributes, disallow, armor)
	if not disallow.handle then
		minetest.register_craftitem("axiscore:toolHandle_"..name, {
			description = displayname.." Tool Handle\n"..displayname2,
			inventory_image = "axiscore_toolhandle.png^[colorize:"..colorize,
			groups = matgroups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
			snappy=snappy,
			choppy=choppy,
			cracky=cracky,
			crumbly=crumbly,
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
			groups = matgroups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
			snappy=snappy,
			choppy=choppy,
			cracky=cracky,
			crumbly=crumbly,
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
		})
		minetest.register_craft({
			output = "axiscore:metalPlate_"..name,
			recipe = {
				{'', 'axiscore:craft_hammer', ''},
				{'', material, ''},
				{'', '', ''},
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
	{	
		groups = {armor_heal=0, armor_use=1600, physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	}
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
	{	
		groups = {armor_heal=6, armor_use=800, physics_speed=-0.03, physics_gravity=0.03, not_in_creative_inventory=1},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	}
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
	{	
		groups = {armor_heal=6, armor_use=1800, physics_speed=-0.03, physics_gravity=0.03, not_in_creative_inventory=1},
		armor_groups = {fleshy=12},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	}
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
	{	
		groups = { armor_heal=6, armor_use=1600, physics_speed=-0.03, physics_gravity=0.03, not_in_creative_inventory=1},
		armor_groups = {fleshy=13},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	}
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
			name=minetest.colorize("#59dbf2", "\nRefractive"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1,
	 handle=1,
	 plate=1},
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
	},
	"#e5ce00d0", 
	{
		{
			name=minetest.colorize("#e5ce00", "\nExpensive"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{},
	{	
		groups = {armor_heal=6, armor_use=1800, physics_speed=-0.03, physics_gravity=0.03, not_in_creative_inventory=1},
		armor_groups = {fleshy=12},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	}
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
	{	
		groups = {armor_heal=0, armor_use=900, physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	}
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
	{
		groups = {armor_heal=12, armor_use=100, not_in_creative_inventory=1}, 
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, level=3},
	}
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
	 nil
)

axiscore.register_tool_material(
	"default:obsidian_shard", 
	"obsidian", 
	"Obsidian", 
	"Obsidian", 
	0.8, 
	11, 
	{times={[1]=3.0, [2]=2.00, [3]=0.70}, uses=9, maxlevel=3}, -- snappy
	{times={[1]=3.20, [2]=2.00, [3]=0.90}, uses=5, maxlevel=3}, -- choppy
	{times={[1]=3.4, [2]=2.4, [3]=0.90}, uses=5, maxlevel=3}, -- cracky 
	{times={[1]=2.40, [2]=0.90, [3]=0.60}, uses=5, maxlevel=3}, -- crumbly
	{	
		obsidian=1,
		tool=1,
	},
	"#200c49d0", 
	{
		{
			name=minetest.colorize("#ff9900", "\nVolcanic"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1,
	 handle=1,
	 plate=1},
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
	},
	"#ff7f00ef", 
	{
		{
			name=minetest.colorize("#ff0000", "\nHellfire"),
			type="nil",
			func=function(pos, node, digger)
			end,
		}
	}, 
	{binding=1,
	 handle=1},
	{
		groups = {armor_heal=20, armor_use=50, not_in_creative_inventory=1}, 
		armor_groups = {fleshy=30},
		damage_groups = {cracky=2, snappy=1, level=3},
	}
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
			if head=="axiscore:pickHead_stone" and handle=="axiscore:toolHandle_wood" and binding=="axiscore:toolBinding_string" then
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
					attributes=attrlist,
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
					attributes=attrlist,
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
	local stack = digger:get_wielded_item()
	if string.split(stack:get_name(), "_")[1]=="axiscore:pick" then
		for _,attr in ipairs(stack:get_definition().attributes) do
			if attr.type=="pick" or attr.type=="all" then
				for i=1,attr.level do
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
					damage_groups = {fleshy=2},
				},
				groups = {not_in_creative_inventory=1},
				sound = {breaks = "default_tool_breaks"},
				attributes=attrlist,
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
	local stack = digger:get_wielded_item()
	if string.split(stack:get_name(), "_")[1]=="axiscore:axe" then
		for _,attr in ipairs(stack:get_definition().attributes) do
			if attr.type=="axe" or attr.type=="all" then
				for i=1,attr.level do
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
				attributes=attrlist,
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
	local stack = digger:get_wielded_item()
	if string.split(stack:get_name(), "_")[1]=="axiscore:shovel" then
		for _,attr in ipairs(stack:get_definition().attributes) do
			if attr.type=="shovel" or attr.type=="all" then
				for i=1,attr.level do
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
					damage_groups = {fleshy=head_def.sworddamage},
				},
				groups = {not_in_creative_inventory=1},
				sound = {breaks = "default_tool_breaks"},
				attributes=attrlist,
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

