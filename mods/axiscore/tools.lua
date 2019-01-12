
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
		damage_groups = {fleshy=4},
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

minetest.register_craftitem("axiscore:toolHandle_wood", {
	description = "Wooden Tool Handle",
	inventory_image = "axiscore_toolhandle.png^[colorize:#775208df",
	groups = {tool=1},
	digging_groups={cracky = {times={[2]=2.0, [3]=1.00}, uses=6, maxlevel=1},},
	attributes = {},
	name2="wood",
	displayname="Wood",
})

table.insert(axiscore.handles, "axiscore:toolHandle_wood")

minetest.register_craftitem("axiscore:toolBinding_string", {
	description = "String Tool Binding",
	inventory_image = "axiscore_toolbinding.png^[colorize:#165b0bdf",
	groups = {tool=1},
	digging_groups={cracky = {times={[2]=2.0, [3]=1.00}, uses=6, maxlevel=1},},
	attributes = {},
	name2="string",
	displayname="String",
})

table.insert(axiscore.bindings, "axiscore:toolBinding_string")

minetest.register_craftitem("axiscore:pickHead_stone", {
	description = "Stone Pickaxe Head",
	inventory_image = "axiscore_pickhead.png^[colorize:#555555df",
	groups = {stone=1, tool=1},
	digging_groups={cracky = {times={[2]=7.0, [3]=5.00}, uses=6, maxlevel=1},},
	attributes = {},
	name2="stone",
	displayname="Basic",
})

table.insert(axiscore.pickheads, "axiscore:pickHead_stone")


function axiscore.register_tool_material(material, name, displayname, displayname2, durability, cooldown, sworddamage, digging_groups, matgroups, colorize, attributes, disallow)
	if not disallow.handle then
		minetest.register_craftitem("axiscore:toolHandle_"..name, {
			description = displayname.." Tool Handle\n"..displayname2,
			inventory_image = "axiscore_toolhandle.png^[colorize:"..colorize,
			groups = matgroups,
			name2=name,
			displayname=displayname,
			digging_groups=digging_groups,
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
			name2=name,
			displayname=displayname,
			digging_groups=digging_groups,
		})
		minetest.register_craft({
			output = "axiscore:toolBinding_"..name,
			recipe = {
				{material, '', 'axiscore:craft_hammer'},
				{'', material, ''},
				{'', '', material},
			},
			replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
		})
		table.insert(axiscore.bindings, "axiscore:toolBinding_"..name)
	end
	if not disallow.pick then
		minetest.register_craftitem("axiscore:pickHead_"..name, {
			description = displayname.." Pick Head\n"..displayname2,
			inventory_image = "axiscore_pickhead.png^[colorize:"..colorize,
			groups = matgroups,
			digging_groups=digging_groups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
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
			digging_groups=digging_groups,
			attributes = attributes,
			name2=name,
			cooldown=cooldown*1.5,
			damage=sworddamage*1.2,
			displayname=displayname,
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
			digging_groups=digging_groups,
			attributes = attributes,
			name2=name,
			displayname=displayname,
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
			description = displayname.." Sword Blade\n"..displayname2,
			inventory_image = "axiscore_swordhead.png^[colorize:"..colorize,
			groups = matgroups,
			digging_groups=digging_groups,
			attributes = attributes,
			name2=name,
			cooldown=cooldown,
			sworddamage=sworddamage,
			displayname=displayname,
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
	20, 
	0.8, 
	6, 
	{
		snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=10, maxlevel=2},
		choppy={times={[1]=2.50, [2]=1.40, [3]=1.00}, uses=6, maxlevel=2},
		crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=10, maxlevel=2},
		cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=6, maxlevel=2},
	}, 
	{	
		metal=1,
		steel=1,
		tool=1,
	},
	"#ffffff00", 
	{
		{
			name="Ferrous", 
			func=function(pos, node, digger)
				if node.name=="default:stone_with_iron" then
					digger:get_inventory():add_item("main", "default:iron_lump")
				end
			end
		}
	}, 
	{}
)

for _,head in ipairs(axiscore.pickheads) do
	for __,binding in ipairs(axiscore.bindings) do
		for ___,handle in ipairs(axiscore.handles) do
			local head_def = ItemStack(head):get_definition()
			local binding_def = ItemStack(binding):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			local attrlist = ""
			local fnc = {}
			for _,attr in ipairs(head_def.attributes) do
				if attr.name then
					attrlist=attrlist..attr.name.."\n"
					if attr.func then
						table.insert(fnc, attr.func)
					end
				end
			end
			if head=="axiscore:pickHead_stone" and handle=="axiscore:toolHandle_wood" and binding=="axiscore:toolBinding_string" then
				minetest.register_tool("axiscore:pick_".._..__..___, {
					description = head_def.displayname.." Pickaxe\n"..attrlist,
					inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image..")",
					tool_capabilities = {
						full_punch_interval = 1.2,
						max_drop_level=0,
						groupcaps={
							cracky = {times={[1]=head_def.digging_groups.cracky.times[1], [2]=head_def.digging_groups.cracky.times[2], [3]=head_def.digging_groups.cracky.times[3]}, uses=head_def.digging_groups.cracky.uses+handle_def.digging_groups.cracky.uses+binding_def.digging_groups.cracky.uses, maxlevel=head_def.digging_groups.maxlevel},
						},
						damage_groups = {fleshy=2},
					},
					sound = {breaks = "default_tool_breaks"},
					special=fnc
				})
			else
				minetest.register_tool("axiscore:pick_".._..__..___, {
					description = head_def.displayname.." Pickaxe\n"..attrlist,
					inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image..")",
					tool_capabilities = {
						full_punch_interval = 1.2,
						max_drop_level=0,
						groupcaps={
							cracky = {times={[1]=head_def.digging_groups.cracky.times[1], [2]=head_def.digging_groups.cracky.times[2], [3]=head_def.digging_groups.cracky.times[3]}, uses=head_def.digging_groups.cracky.uses+handle_def.digging_groups.cracky.uses+binding_def.digging_groups.cracky.uses, maxlevel=head_def.digging_groups.maxlevel},
						},
						damage_groups = {fleshy=2},
					},
					groups = {not_in_creative_inventory=1},
					sound = {breaks = "default_tool_breaks"},
					special=fnc
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
		end
	end
end