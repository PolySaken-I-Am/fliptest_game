
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

minetest.register_craft({
	output = "dmobs:dragon_gem_fire",
	type="shapeless",
	recipe = {"dmobs:dragon_gem", "ethereal:fire_dust"},
})

minetest.register_craft({
	output = "dmobs:dragon_gem_poison",
	type="shapeless",
	recipe = {"dmobs:dragon_gem", "flowers:mushroom_red"},
})

minetest.register_craft({
	output = "dmobs:dragon_gem_ice",
	type="shapeless",
	recipe = {"dmobs:dragon_gem", "default:ice"},
})

minetest.register_craft({
	output = "dmobs:dragon_gem_lightning",
	type="shapeless",
	recipe = {"dmobs:dragon_gem", "default:copperblock"},
})

minetest.register_craft({
	output = 'axiscore:spittleblade',
	recipe = {
		{'', 'dmobs:dragon_gem_poison', ''},
		{'', 'dmobs:dragon_gem_poison', ''},
		{'', 'default:steel_ingot', ''},
	},
})

minetest.register_craft({
	output = 'axiscore:skywhipper',
	recipe = {
		{'', 'dmobs:dragon_gem_ice', ''},
		{'', 'dmobs:dragon_gem_ice', ''},
		{'', 'default:steel_ingot', ''},
	},
})

minetest.register_craft({
	output = 'axiscore:dragonsbreath',
	recipe = {
		{'', 'dmobs:dragon_gem_fire', ''},
		{'', 'dmobs:dragon_gem_fire', ''},
		{'', 'default:steel_ingot', ''},
	},
})

minetest.register_craft({
	output = 'axiscore:windhammer',
	recipe = {
		{'', 'dmobs:dragon_gem_lightning', ''},
		{'', 'dmobs:dragon_gem_lightning', ''},
		{'', 'default:steel_ingot', ''},
	},
})

minetest.register_craft({
	output = 'axiscore:book_index',
	recipe = {
		{'', 'axiscore:craft_knife', ''},
		{'', 'default:book', ''},
		{'', '', ''},
	},
	replacements = {{"axiscore:craft_knife","axiscore:craft_knife"}}
})

minetest.register_craft({
	output = "axiscore:blank_projectile_index",
	type="shapeless",
	recipe = {"axiscore:book_index", "default:torch", "default:diamond", "default:glass"},
})

minetest.register_craft({
	output = 'axiscore:book_cover',
	recipe = {
		{'', '', ''},
		{'', 'default:book', ''},
		{'', 'axiscore:craft_knife', ''},
	},
	replacements = {{"axiscore:craft_knife","axiscore:craft_knife"}}
})

minetest.register_craft({
	output = 'axiscore:book_reverse',
	recipe = {
		{'', 'default:paper', ''},
		{'axiscore:book_index', 'default:paper', 'axiscore:book_cover'},
		{'', 'default:paper', ''},
	},
})

minetest.register_craft({
	output = 'axiscore:spellbook',
	recipe = {
		{'', 'ethereal:illumishroom2', ''},
		{'default:obsidian_shard', 'axiscore:book_reverse', 'default:gold_ingot'},
		{'', '', ''},
	},
})

minetest.register_craft({
	output = 'axiscore:arrow 17',
	recipe = {
		{'', 'default:obsidian_shard', ''},
		{'', 'group:woodhandle', ''},
		{'', 'mobs:chicken_feather', ''},
	},
})

minetest.register_craft({
	output = "default:flint",
	type="shapeless",
	recipe = {"default:gravel"},
})