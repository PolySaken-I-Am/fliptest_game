quests.register_quest("fliptest:beginning",{
	title=minetest.colorize("#00ffff","The Beginning"),
	description="Find out about your situation by reading the note.",
	max=1,
	autoaccept=false,
	callback=nil
})

minetest.register_on_newplayer(function(player)
	quests.start_quest(player:get_player_name(), "fliptest:beginning")
	minetest.chat_send_player(player:get_player_name(), minetest.colorize("#ff00ff","Use the note in your inventory."))
end)

quests.register_quest("fliptest:q1",{
	title=minetest.colorize("#00ffff","The Situation"),
	description="Fix your situation by finding some pebbles to make tools.",
	max=3,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q2")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Break some tiny trees for sticks."))
	end,
})

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		if minetest.get_item_group(node.name, "quest_pebble") then
			quests.update_quest(digger:get_player_name(), "fliptest:q1", 1)
		end
	end
end)

minetest.register_on_placenode(function(pos, node, digger)
	if digger then
		if minetest.get_item_group(node.name, "quest_pebble") then
			quests.update_quest(digger:get_player_name(), "fliptest:q1", -1)
		end
	end
end)

quests.register_quest("fliptest:q2",{
	title=minetest.colorize("#00ffff","The Situation part 2"),
	description="Fix your situation by finding some sticks to make tools.",
	max=3,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q3")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Craft a stone club and a stone hammer using unified_inventory for recipes."))
	end,
})

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		if node.name=="bushes:youngtree2_bottom" then
			quests.update_quest(digger:get_player_name(), "fliptest:q2", 1)
		end
	end
end)

minetest.register_on_placenode(function(pos, node, digger)
	if node.name=="bushes:youngtree2_bottom" then
		quests.update_quest(digger:get_player_name(), "fliptest:q2", -1)
	end
end)

quests.register_quest("fliptest:q3",{
	title=minetest.colorize("#00ffff","The Solution"),
	description="Make some tools so you can survive.",
	max=2,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q4")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Hammer on a tree to get a better source of wood"))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if minetest.get_item_group(itemstack:get_name(), "quest_tool")	then
		quests.update_quest(player:get_player_name(), "fliptest:q3", 1)
	end
end)

quests.register_quest("fliptest:q4",{
	title=minetest.colorize("#00ffff","The Start of Something Great"),
	description="Cut 5 wood.",
	max=5,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q5")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Find some gravel and get some flint"))
	end,
})

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		if minetest.get_item_group(node.name, "tree") then
			quests.update_quest(digger:get_player_name(), "fliptest:q4", 1)
		end
	end
end)

minetest.register_on_placenode(function(pos, node, digger)
	if minetest.get_item_group(node.name, "tree") then
		quests.update_quest(digger:get_player_name(), "fliptest:q4", -1)
	end
end)

quests.register_quest("fliptest:q5",{
	title=minetest.colorize("#00ffff","Jagged Edge"),
	description="Gather 3 flint.",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(player:get_player_name(), "fliptest:q6")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Make a Craftsman's knife. "))
	end,
})

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if player:get_inventory():contains_item("main", "default:flint 3") then
			quests.update_quest(player:get_player_name(), "fliptest:q5", 1)
		end
	end
end)

quests.register_quest("fliptest:q6",{
	title=minetest.colorize("#00ffff","REAL Crafting"),
	description="Make a craftsman's knife so you can start crafting better items.",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q7")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Make a craftsman's hammer"))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if itemstack:get_name()=="axiscore:craft_knife"	then
		quests.update_quest(player:get_player_name(), "fliptest:q6", 1)
	end
end)

quests.register_quest("fliptest:q7",{
	title=minetest.colorize("#00ffff","REAL Crafting part 2"),
	description="Make a craftsman's hammer so you can start crafting better items.",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q8")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Make a proper wooden tool handle."))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if itemstack:get_name()=="axiscore:craft_hammer"	then
		quests.update_quest(player:get_player_name(), "fliptest:q7", 1)
	end
end)

quests.register_quest("fliptest:q8",{
	title=minetest.colorize("#00ffff","Tool of the Master"),
	description="Carve a wooden log into a tool handle.",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q9")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Make a good string binding."))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if itemstack:get_name()=="axiscore:toolHandle_wood"	then
		quests.update_quest(player:get_player_name(), "fliptest:q8", 1)
	end
end)

quests.register_quest("fliptest:q9",{
	title=minetest.colorize("#00ffff","Thread of fate"),
	description="Make a plant fiber binding.",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q10")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Make a sturdy stone pickaxe head."))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if itemstack:get_name()=="axiscore:toolBinding_string"	then
		quests.update_quest(player:get_player_name(), "fliptest:q9", 1)
	end
end)

quests.register_quest("fliptest:q10",{
	title=minetest.colorize("#00ffff","Miner Annoyance"),
	description="Craft a stone pickaxe head.",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q11")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Create a basic pickaxe."))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if itemstack:get_name()=="axiscore:pickHead_stone"	then
		quests.update_quest(player:get_player_name(), "fliptest:q10", 1)
	end
end)

quests.register_quest("fliptest:q11",{
	title=minetest.colorize("#00ffff","Chipping Away"),
	description="Craft a basic pick.",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q12")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Mine 8 stone."))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if itemstack:get_name()=="axiscore:pick_111"	then
		quests.update_quest(player:get_player_name(), "fliptest:q11", 1)
	end
end)

quests.register_quest("fliptest:q12",{
	title=minetest.colorize("#00ffff","Quarry"),
	description="Mine some stone so you can make a campfire or two.",
	max=8,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q13")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Make a campfire."))
	end,
})

minetest.register_on_dignode(function(pos, node, digger)
	if minetest.get_item_group(node.name, "stone") then
		quests.update_quest(digger:get_player_name(), "fliptest:q12", 1)
	end
end)

quests.register_quest("fliptest:q13",{
	title=minetest.colorize("#00ffff","The Gift of Fire"),
	description="Craft a campfire",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q14")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Make a sleeping bag."))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if itemstack:get_name()=="campfire:campfire" then
		quests.update_quest(player:get_player_name(), "fliptest:q13", 1)
	end
end)

quests.register_quest("fliptest:q14",{
	title=minetest.colorize("#00ffff","Peaceful Slumber"),
	description="Craft a sleeping bag",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q15")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Dig until you have mined 10 coal"))
	end,
})

minetest.register_on_craft(function(itemstack, player)
	if itemstack:get_name()=="campfire:sleeping_mat_bottom" then
		quests.update_quest(player:get_player_name(), "fliptest:q14", 1)
	end
end)

quests.register_quest("fliptest:q15",{
	title=minetest.colorize("#00ffff","Better Than Wood"),
	description="Mine 10 coal",
	max=10,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q16")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Mine 3 iron"))
	end,
})

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		if node.name=="default:stone_with_coal" then
			quests.update_quest(digger:get_player_name(), "fliptest:q15", 1)
		end
	end
end)

quests.register_quest("fliptest:q16",{
	title=minetest.colorize("#00ffff","Harder Better... etc."),
	description="Mine 3 iron",
	max=3,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q17")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Using the unified inventory window, figure out how to make steel."))
	end,
})

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		if node.name=="default:stone_with_iron" then
			quests.update_quest(digger:get_player_name(), "fliptest:q16", 1)
		end
	end
end)

quests.register_quest("fliptest:q17",{
	title=minetest.colorize("#00ffff","Perfect Process"),
	description="Smelt 3 steel",
	max=3,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:q18")
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Make a steel pick with any handle and any binding"))
	end,
})

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if player:get_inventory():contains_item("main", "default:steel_ingot 3") then
			quests.update_quest(player:get_player_name(), "fliptest:q17", 1)
		end
	end
end)

quests.register_quest("fliptest:q18",{
	title=minetest.colorize("#00ffff","Magnetic Miner"),
	description="Craft a steel-headed pickaxe.",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Congratulations! You are no longer in the tutorial."))
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","It is recommended to disable the quest GUI at this time."))
		minetest.chat_send_player(playername, minetest.colorize("#ff00ff","Most quests from here on will come with rewards."))
		quests.start_quest(playername, "fliptest:mithril")
	end,
})

minetest.register_on_craft(function(itemstack, player)
	stacknamereg = string.gsub(itemstack:get_name(), "2%d%d", "200")
	if stacknamereg=="axiscore:pick_200"	then
		quests.update_quest(player:get_player_name(), "fliptest:q18", 1)
	end
end)

quests.register_quest("fliptest:mithril",{
	title=minetest.colorize("#00ffff","Mithril Myth"),
	description="obtain mithril",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		
	end,
})

minetest.register_on_dignode(function(pos, node, digger)
	if digger then
		if node.name=="moreores:mineral_mithril" then
			quests.update_quest(digger:get_player_name(), "fliptest:mithril", 1)
		end
	end
end)