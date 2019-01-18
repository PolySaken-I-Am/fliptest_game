
hb.register_hudbar("axiscore:quintessence", "#ffffff", "Quintessence", {bar="axiscore_quintessence_bar.png", icon="axiscore_quintessence_icon.png", bgicon="axiscore_quintessence_icon_bg.png"}, 0,1000,false,nil)

function axiscore.get_quintessence(player)
	return tonumber(player:get_attribute("axiscore_quintessence"))
end

function axiscore.set_quintessence(player, n)
	player:set_attribute("axiscore_quintessence", n)
	hb.change_hudbar(player, "axiscore:quintessence", n, nil, nil, nil, nil, nil, nil)
end

minetest.register_on_newplayer(function(player)
	hb.init_hudbar(player, "axiscore:quintessence", 0, 1000, false)
	axiscore.set_quintessence(player, 1)
end)

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if axiscore.get_quintessence(player) then
			if axiscore.get_quintessence(player) < 1000 then
				axiscore.set_quintessence(player, axiscore.get_quintessence(player)+1)
				hb.change_hudbar(player, "axiscore:quintessence", axiscore.get_quintessence(player))
			end
		end
	end
end)