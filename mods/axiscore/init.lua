
minetest.register_on_mapgen_init(function(mapgen_params)
	mapgen_params2={mgname="valleys", seed="73465682348566", water_level=mapgen_params.water_level, flags=mapgen_params.flags}
	minetest.set_mapgen_params(mapgen_params2)
end)

quests.register_quest("fliptest:beginning",{
	title=minetest.colorize("#00ffff","The Beginning"),
	description="Find out about your situation by reading the note.",
	max=1,
	autoaccept=true,
	callback=function(playername,questname)
		
	end
})

minetest.register_on_newplayer(function(player)
	quests.start_quest(player:get_player_name(), "fliptest:beginning")
	minetest.chat_send_player(player:get_player_name(), minetest.colorize("#ff00ff","Use the note in your inventory."))
end)

local note1text=""..
"Quite recently, in a house very far away, a person became\ntired of their boring job."..
"They wished quietly to themself\n to travel to a far off land, another world.\n"..
"They wished for an interesting life far away from their boring job.\n"..
"They did not under stand the implications of this however, and\n"..
"their wish was granted by a nosy genie.\n"..
"This is a story of you, and how you came to be in this world.\n\n"..
"You seem to have popped up in a village.\n"

minetest.register_craftitem("axiscore:note_1", {
	description = minetest.colorize("#5fff00", "A short note on your situation"),
	inventory_image = "axiscore_note.png",
	groups={not_in_creative_inventory=1},
	on_use=function(itemstack,user)
		minetest.show_formspec(user:get_player_name(), "note", "size[7,8]label[0.2,0.2;"..note1text.."]")
		quests.accept_quest(user:get_player_name(), "fliptest:beginning")
	end
})