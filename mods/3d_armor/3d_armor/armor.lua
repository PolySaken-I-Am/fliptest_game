-- support for i18n
local S = armor_i18n.gettext

armor:register_armor("3d_armor:helmet_admin", {
	description = S("Admin Helmet"),
	inventory_image = "3d_armor_inv_helmet_admin.png",
	armor_groups = {fleshy=100},
	groups = {armor_head=1, armor_heal=100, armor_use=0, armor_water=1,
			not_in_creative_inventory=1},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

armor:register_armor("3d_armor:chestplate_admin", {
	description = S("Admin Chestplate"),
	inventory_image = "3d_armor_inv_chestplate_admin.png",
	armor_groups = {fleshy=100},
	groups = {armor_torso=1, armor_heal=100, armor_use=0,
			not_in_creative_inventory=1},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

armor:register_armor("3d_armor:leggings_admin", {
	description = S("Admin Leggings"),
	inventory_image = "3d_armor_inv_leggings_admin.png",
	armor_groups = {fleshy=100},
	groups = {armor_legs=1, armor_heal=100, armor_use=0,
			not_in_creative_inventory=1},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

armor:register_armor("3d_armor:boots_admin", {
	description = S("Admin Boots"),
	inventory_image = "3d_armor_inv_boots_admin.png",
	armor_groups = {fleshy=100},
	groups = {armor_feet=1, armor_heal=100, armor_use=0,
			not_in_creative_inventory=1},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})

minetest.register_alias("adminboots", "3d_armor:boots_admin")
minetest.register_alias("adminhelmet", "3d_armor:helmet_admin")
minetest.register_alias("adminchestplate", "3d_armor:chestplate_admin")
minetest.register_alias("adminleggings", "3d_armor:leggings_admin")

if armor.materials.wood then
	armor:register_armor("3d_armor:helmet_wood", {
		description = S("Wood Helmet"),
		inventory_image = "3d_armor_inv_helmet_wood.png",
		groups = {armor_head=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
	})
	armor:register_armor("3d_armor:chestplate_wood", {
		description = S("Wood Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_wood.png",
		groups = {armor_torso=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
	})
	armor:register_armor("3d_armor:leggings_wood", {
		description = S("Wood Leggings"),
		inventory_image = "3d_armor_inv_leggings_wood.png",
		groups = {armor_legs=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
	})
	armor:register_armor("3d_armor:boots_wood", {
		description = S("Wood Boots"),
		inventory_image = "3d_armor_inv_boots_wood.png",
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
		groups = {armor_feet=1, armor_heal=0, armor_use=2000, flammable=1},
	})
end

minetest.register_craft({
	output = "3d_armor:helmet_wood",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = "3d_armor:chestplate_wood",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	},
})
minetest.register_craft({
	output = "3d_armor:leggings_wood",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"group:wood", "", "group:wood"},
	},
})
minetest.register_craft({
	output = "3d_armor:boots_wood",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"group:wood", "", "group:wood"},
	},
})

if armor.materials.cactus then
	armor:register_armor("3d_armor:helmet_cactus", {
		description = S("Cactus Helmet"),
		inventory_image = "3d_armor_inv_helmet_cactus.png",
		groups = {armor_head=1, armor_heal=0, armor_use=1000},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=3, choppy=2, crumbly=2, level=1},
	})
	armor:register_armor("3d_armor:chestplate_cactus", {
		description = S("Cactus Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_cactus.png",
		groups = {armor_torso=1, armor_heal=0, armor_use=1000},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=3, choppy=2, crumbly=2, level=1},
	})
	armor:register_armor("3d_armor:leggings_cactus", {
		description = S("Cactus Leggings"),
		inventory_image = "3d_armor_inv_leggings_cactus.png",
		groups = {armor_legs=1, armor_heal=0, armor_use=1000},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=3, choppy=2, crumbly=2, level=1},
	})
	armor:register_armor("3d_armor:boots_cactus", {
		description = S("Cactus Boots"),
		inventory_image = "3d_armor_inv_boots_cactus.png",
		groups = {armor_feet=1, armor_heal=0, armor_use=1000},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=3, choppy=2, crumbly=2, level=1},
	})
end

minetest.register_craft({
	output = "3d_armor:helmet_cactus",
	recipe = {
		{"default:cactus", "default:cactus", "default:cactus"},
		{"default:cactus", "3d_armor:helmet_wood", "default:cactus"},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = "3d_armor:chestplate_cactus",
	recipe = {
		{"default:cactus", "3d_armor:chestplate_wood", "default:cactus"},
		{"default:cactus", "default:cactus", "default:cactus"},
		{"default:cactus", "default:cactus", "default:cactus"},
	},
})
minetest.register_craft({
	output = "3d_armor:leggings_cactus",
	recipe = {
		{"default:cactus", "default:cactus", "default:cactus"},
		{"default:cactus", "3d_armor:leggings_wood", "default:cactus"},
		{"default:cactus", "", "default:cactus"},
	},
})
minetest.register_craft({
	output = "3d_armor:boots_cactus",
	recipe = {
		{"default:cactus", "3d_armor:boots_wood", "default:cactus"},
		{"default:cactus", "", "default:cactus"},
	},
})

if armor.materials.steel then
	armor:register_armor("3d_armor:helmet_steel", {
		description = S("Steel Helmet"),
		inventory_image = "3d_armor_inv_helmet_steel.png",
		groups = {armor_head=1, armor_heal=0, armor_use=800,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})
	armor:register_armor("3d_armor:chestplate_steel", {
		description = S("Steel Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_steel.png",
		groups = {armor_torso=1, armor_heal=0, armor_use=800,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})
	armor:register_armor("3d_armor:leggings_steel", {
		description = S("Steel Leggings"),
		inventory_image = "3d_armor_inv_leggings_steel.png",
		groups = {armor_legs=1, armor_heal=0, armor_use=800,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})
	armor:register_armor("3d_armor:boots_steel", {
		description = S("Steel Boots"),
		inventory_image = "3d_armor_inv_boots_steel.png",
		groups = {armor_feet=1, armor_heal=0, armor_use=800,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})
end

minetest.register_craft({
	output = "3d_armor:helmet_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "3d_armor:helmet_bronze", "default:steel_ingot"},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = "3d_armor:chestplate_steel",
	recipe = {
		{"default:steel_ingot", "3d_armor:chestplate_bronze", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:leggings_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "3d_armor:leggings_bronze", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:boots_steel",
	recipe = {
		{"default:steel_ingot", "3d_armor:boots_bronze", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
	},
})

if armor.materials.bronze then
	armor:register_armor("3d_armor:helmet_bronze", {
		description = S("Bronze Helmet"),
		inventory_image = "3d_armor_inv_helmet_bronze.png",
		groups = {armor_head=1, armor_heal=6, armor_use=400,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
	armor:register_armor("3d_armor:chestplate_bronze", {
		description = S("Bronze Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_bronze.png",
		groups = {armor_torso=1, armor_heal=6, armor_use=400,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
	armor:register_armor("3d_armor:leggings_bronze", {
		description = S("Bronze Leggings"),
		inventory_image = "3d_armor_inv_leggings_bronze.png",
		groups = {armor_legs=1, armor_heal=6, armor_use=400,
			physics_speed=-0.03, physics_gravity=0.03},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
	armor:register_armor("3d_armor:boots_bronze", {
		description = S("Bronze Boots"),
		inventory_image = "3d_armor_inv_boots_bronze.png",
		groups = {armor_feet=1, armor_heal=6, armor_use=400,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
end

minetest.register_craft({
	output = "3d_armor:helmet_bronze",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "3d_armor:helmet_cactus", "default:bronze_ingot"},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = "3d_armor:chestplate_bronze",
	recipe = {
		{"default:bronze_ingot", "3d_armor:chestplate_cactus", "default:bronze_ingot"},
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:leggings_bronze",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "3d_armor:leggings_cactus", "default:bronze_ingot"},
		{"default:bronze_ingot", "", "default:bronze_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:boots_bronze",
	recipe = {
		{"default:bronze_ingot", "3d_armor:boots_cactus", "default:bronze_ingot"},
		{"default:bronze_ingot", "", "default:bronze_ingot"},
	},
})

if armor.materials.diamond then
	armor:register_armor("3d_armor:helmet_diamond", {
		description = S("Diamond Helmet"),
		inventory_image = "3d_armor_inv_helmet_diamond.png",
		groups = {armor_head=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})
	armor:register_armor("3d_armor:chestplate_diamond", {
		description = S("Diamond Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_diamond.png",
		groups = {armor_torso=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})
	armor:register_armor("3d_armor:leggings_diamond", {
		description = S("Diamond Leggings"),
		inventory_image = "3d_armor_inv_leggings_diamond.png",
		groups = {armor_legs=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})
	armor:register_armor("3d_armor:boots_diamond", {
		description = S("Diamond Boots"),
		inventory_image = "3d_armor_inv_boots_diamond.png",
		groups = {armor_feet=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})
end


minetest.register_craft({
	output = "3d_armor:helmet_diamond",
	recipe = {
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "3d_armor:helmet_gold", "default:diamond"},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = "3d_armor:chestplate_diamond",
	recipe = {
		{"default:diamond", "3d_armor:chestplate_gold", "default:diamond"},
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "default:diamond", "default:diamond"},
	},
})
minetest.register_craft({
	output = "3d_armor:leggings_diamond",
	recipe = {
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "3d_armor:leggings_gold", "default:diamond"},
		{"default:diamond", "", "default:diamond"},
	},
})
minetest.register_craft({
	output = "3d_armor:boots_diamond",
	recipe = {
		{"default:diamond", "3d_armor:boots_gold", "default:diamond"},
		{"default:diamond", "", "default:diamond"},
	},
})


if armor.materials.gold then
	armor:register_armor("3d_armor:helmet_gold", {
		description = S("Gold Helmet"),
		inventory_image = "3d_armor_inv_helmet_gold.png",
		groups = {armor_head=1, armor_heal=6, armor_use=300,
			physics_speed=-0.02, physics_gravity=0.02},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
	})
	armor:register_armor("3d_armor:chestplate_gold", {
		description = S("Gold Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_gold.png",
		groups = {armor_torso=1, armor_heal=6, armor_use=300,
			physics_speed=-0.05, physics_gravity=0.05},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
	})
	armor:register_armor("3d_armor:leggings_gold", {
		description = S("Gold Leggings"),
		inventory_image = "3d_armor_inv_leggings_gold.png",
		groups = {armor_legs=1, armor_heal=6, armor_use=300,
			physics_speed=-0.04, physics_gravity=0.04},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
	})
	armor:register_armor("3d_armor:boots_gold", {
		description = S("Gold Boots"),
		inventory_image = "3d_armor_inv_boots_gold.png",
		groups = {armor_feet=1, armor_heal=6, armor_use=300,
			physics_speed=-0.02, physics_gravity=0.02},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
	})
end

minetest.register_craft({
	output = "3d_armor:helmet_gold",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "3d_armor:helmet_steel", "default:gold_ingot"},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = "3d_armor:chestplate_gold",
	recipe = {
		{"default:gold_ingot", "3d_armor:chestplate_steel", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:leggings_gold",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "3d_armor:leggings_steel", "default:gold_ingot"},
		{"default:gold_ingot", "", "default:gold_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:boots_gold",
	recipe = {
		{"default:gold_ingot", "3d_armor:boots_steel", "default:gold_ingot"},
		{"default:gold_ingot", "", "default:gold_ingot"},
	},
})

if armor.materials.mithril then
	armor:register_armor("3d_armor:helmet_mithril", {
		description = S("Mithril Helmet"),
		inventory_image = "3d_armor_inv_helmet_mithril.png",
		groups = {armor_head=1, armor_heal=12, armor_use=100},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	armor:register_armor("3d_armor:chestplate_mithril", {
		description = S("Mithril Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_mithril.png",
		groups = {armor_torso=1, armor_heal=12, armor_use=100},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	armor:register_armor("3d_armor:leggings_mithril", {
		description = S("Mithril Leggings"),
		inventory_image = "3d_armor_inv_leggings_mithril.png",
		groups = {armor_legs=1, armor_heal=12, armor_use=100},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	armor:register_armor("3d_armor:boots_mithril", {
		description = S("Mithril Boots"),
		inventory_image = "3d_armor_inv_boots_mithril.png",
		groups = {armor_feet=1, armor_heal=12, armor_use=100},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
end

minetest.register_craft({
	output = "3d_armor:helmet_mithril",
	recipe = {
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "3d_armor:helmet_crystal", "moreores:mithril_ingot"},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = "3d_armor:chestplate_mithril",
	recipe = {
		{"moreores:mithril_ingot", "3d_armor:chestplate_crystal", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:leggings_mithril",
	recipe = {
		{"moreores:mithril_ingot", "moreores:mithril_ingot", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "3d_armor:leggings_crystal", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:boots_mithril",
	recipe = {
		{"moreores:mithril_ingot", "3d_armor:boots_crystal", "moreores:mithril_ingot"},
		{"moreores:mithril_ingot", "", "moreores:mithril_ingot"},
	},
})

if armor.materials.crystal then
	armor:register_armor("3d_armor:helmet_crystal", {
		description = S("Crystal Helmet"),
		inventory_image = "3d_armor_inv_helmet_crystal.png",
		groups = {armor_head=1, armor_heal=12, armor_use=100, armor_fire=1},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	armor:register_armor("3d_armor:chestplate_crystal", {
		description = S("Crystal Chestplate"),
		inventory_image = "3d_armor_inv_chestplate_crystal.png",
		groups = {armor_torso=1, armor_heal=12, armor_use=100, armor_fire=1},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	armor:register_armor("3d_armor:leggings_crystal", {
		description = S("Crystal Leggings"),
		inventory_image = "3d_armor_inv_leggings_crystal.png",
		groups = {armor_legs=1, armor_heal=12, armor_use=100, armor_fire=1},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
	armor:register_armor("3d_armor:boots_crystal", {
		description = S("Crystal Boots"),
		inventory_image = "3d_armor_inv_boots_crystal.png",
		groups = {armor_feet=1, armor_heal=12, armor_use=100, physics_speed=1,
				physics_jump=0.5, armor_fire=1},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
end

minetest.register_craft({
	output = "3d_armor:helmet_crystal",
	recipe = {
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "3d_armor:helmet_diamond", "ethereal:crystal_ingot"},
		{"", "", ""},
	},
})
minetest.register_craft({
	output = "3d_armor:chestplate_crystal",
	recipe = {
		{"ethereal:crystal_ingot", "3d_armor:chestplate_diamond", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:leggings_crystal",
	recipe = {
		{"ethereal:crystal_ingot", "ethereal:crystal_ingot", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "3d_armor:leggings_diamond", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "", "ethereal:crystal_ingot"},
	},
})
minetest.register_craft({
	output = "3d_armor:boots_crystal",
	recipe = {
		{"ethereal:crystal_ingot", "3d_armor:boots_diamond", "ethereal:crystal_ingot"},
		{"ethereal:crystal_ingot", "", "ethereal:crystal_ingot"},
	},
})