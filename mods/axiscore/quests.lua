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
	end,
})

minetest.register_on_dignode(function(pos, node, digger)
	if minetest.get_item_group(node.name, "quest_pebble") then
		quests.update_quest(digger:get_player_name(), "fliptest:q1", 1)
	end
end)

minetest.register_on_placenode(function(pos, node, digger)
	if minetest.get_item_group(node.name, "quest_pebble") then
		quests.update_quest(digger:get_player_name(), "fliptest:q1", -1)
	end
end)