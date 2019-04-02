
quests.register_quest("fliptest:armory2",{
	title=minetest.colorize("#00ffff","Armorer's Apprentice"),
	description="create the armorer's tome",
	max=1,
	autoaccept=true,
	callback=function(playername, quest)
		quests.start_quest(playername, "fliptest:armory3")
	end,
})

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if player:get_inventory():contains_item("main", "axiscore:armor_tome") then
			quests.update_quest(player:get_player_name(), "fliptest:armory2", 1)
		end
	end
end)
