local modpath = minetest.get_modpath("ranks2")

minetest.register_on_joinplayer(function(player)
	local rank = player:get_attribute("rank")
	local rankColor = player:get_attribute("rankColor")
	if not rank then
		player:set_attribute("rank", "New")
	end
	if not rankColor then
		player:set_attribute("rankColor", "#999999")
	end
end)

minetest.register_on_chat_message(function(name, message)
	if not message:sub(1,1) ~= "/" then
		local player = minetest.get_player_by_name(name)
		if player:get_attribute("rank") then
			if minetest.get_player_privs(name).shout then
				local rank = player:get_attribute("rank")
				local rankColor = player:get_attribute("rankColor")
				local textColor = player:get_attribute("textColor")
				if rank ~= "Mute" and rank ~= "Exile" then
					if textColor then
							minetest.chat_send_all("["..minetest.colorize(rankColor, rank).."] "..name..": "..minetest.colorize(textColor, message))
					else
						minetest.chat_send_all("["..minetest.colorize(rankColor, rank).."] "..name..": "..minetest.colorize("#FFFFFF", message))
					end
				else
					minetest.chat_send_player(name, minetest.colorize("#FF0000","Your rank is muted."))
				
				end
			end
		else
			minetest.chat_send_player(name, minetest.colorize("#FF0000","You need a rank in order to speak"))
		end
	local msg = "[SRV_CHAT]: "..name..": "..message
	minetest.log("action", msg:gsub(string.char(27), "ESC"))
	end
	return true
end)

minetest.register_privilege("ranks", {description="Allows players to change their own and others ranks.", give_to_singleplayer=false})

minetest.register_chatcommand("rank", {
	params = "<name> <rank> <color> <text color>",
	description = "set a player's rank to <rank> with color <color>",
	privs = {ranks=true},
	func = function(name, param)
		local l = string.split(param, " ")
		local player = minetest.get_player_by_name(l[1])
		if player and player:is_player() then
			if l[2] and l[3] then
			player:set_attribute("rank", l[2])
			player:set_attribute("rankColor", l[3])
			end
			if l[4] then
			player:set_attribute("textColor", l[4])
			end
		end
	end,
})
