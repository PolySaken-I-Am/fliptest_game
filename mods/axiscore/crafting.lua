
minetest.register_craft({
	output = 'axiscore:stone_hammer',
	recipe = {
		{'group:quest_pebble', 'group:stick', 'group:quest_pebble'},
		{'', 'group:stick', 'group:leaves'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'axiscore:stone_club',
	recipe = {
		{'', 'group:quest_pebble', ''},
		{'', 'group:stick', 'group:leaves'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'axiscore:craft_knife',
	recipe = {
		{'', 'default:flint', ''},
		{'', 'group:leaves', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'axiscore:craft_hammer',
	recipe = {
		{'', '', ''},
		{'default:flint', 'group:leaves', 'default:flint'},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'axiscore:toolHandle_wood',
	recipe = {
		{'', 'axiscore:craft_knife', ''},
		{'', 'group:tree', ''},
		{'', '', ''},
	},
	replacements = {{"axiscore:craft_knife","axiscore:craft_knife"}}
})

minetest.register_craft({
	output = 'axiscore:toolBinding_string',
	recipe = {
		{'', 'axiscore:craft_knife', ''},
		{'', 'group:leaves', ''},
		{'', '', ''},
	},
	replacements = {{"axiscore:craft_knife","axiscore:craft_knife"}}
})

minetest.register_craft({
	output = 'axiscore:pickHead_stone',
	recipe = {
		{'', 'axiscore:craft_hammer', ''},
		{'group:quest_pebble', 'group:quest_pebble', 'group:quest_pebble'},
		{'', '', ''},
	},
	replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
})

minetest.register_craft({
	output = 'axiscore:pickHead_stone',
	recipe = {
		{'', 'axiscore:craft_hammer', ''},
		{'group:stone', 'group:stone', 'group:stone'},
		{'', '', ''},
	},
	replacements = {{"axiscore:craft_hammer","axiscore:craft_hammer"}}
})

minetest.register_craft({
	output = 'axiscore:iron_mix',
	recipe = {
		{'default:coal_lump'},
		{'axiscore:iron_nuggets'},
		{'group:sand'},
	}
})