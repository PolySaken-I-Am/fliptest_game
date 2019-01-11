
local note1text=""..
"Quite recently, in a house very far away, a person became\ntired of their boring job."..
"They wished quietly to themself\n to travel to a far off land, another world.\n"..
"They wished for an interesting life far away from their boring job.\n"..
"They did not under stand the implications of this however, and\n"..
"their wish was granted by a nosy genie.\n"..
"This is a story of you, and how you came to be in this world.\n\n"

minetest.register_craftitem("axiscore:note_1", {
	description = minetest.colorize("#5fff00", "A short note on your situation"),
	inventory_image = "axiscore_note.png",
	groups={not_in_creative_inventory=1},
	on_use=function(itemstack,user)
		minetest.show_formspec(user:get_player_name(), "note1", "size[7,8]label[0.2,0.2;"..note1text.."]")
		quests.accept_quest(user:get_player_name(), "fliptest:beginning")
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname=="note1" then
		quests.start_quest(player:get_player_name(), "fliptest:q1")
		minetest.chat_send_player(player:get_player_name(), minetest.colorize("#ff00ff","Find some pebbles on the ground."))
		player:get_inventory():remove_item("main", "axiscore:note_1")
	end
end)

