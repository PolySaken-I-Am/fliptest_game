
axiscore.spellcomponents={}

hb.register_hudbar("axiscore:quintessence", "#ffffff", "Quintessence", {bar="axiscore_quintessence_bar.png", icon="axiscore_quintessence_icon.png", bgicon="axiscore_quintessence_icon_bg.png"}, 0,1000,false,nil)

minetest.register_on_newplayer(function(player)
	axiscore.set_quintessence(player, 1)
	axiscore.set_spell(player, "touch;break")
end)

function axiscore.get_quintessence(player)
	return tonumber(player:get_attribute("axiscore_quintessence"))
end

function axiscore.set_quintessence(player, n)
	player:set_attribute("axiscore_quintessence", n)
end

minetest.register_chatcommand("set_spell", {
	params = "<spell>",
	description = "set a player's personal power network to <amount>",
	privs = {debug=true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if player and player:is_player() then
			player:set_attribute("axiscore_spell", param)
		end
	end,
})

minetest.register_on_joinplayer(function(player)
	hb.init_hudbar(player, "axiscore:quintessence", axiscore.get_quintessence(player), 1000, false)
end)

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if axiscore.get_quintessence(player) then
			if axiscore.get_quintessence(player) < 1000 then
				axiscore.set_quintessence(player, axiscore.get_quintessence(player)+1)
			end
		end
	end
end)

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		if axiscore.get_quintessence(player) then
			hb.change_hudbar(player, "axiscore:quintessence", axiscore.get_quintessence(player))
		end
	end
end)

function axiscore.set_spell(player, spell)
	player:set_attribute("axiscore_spell", spell)
end

function axiscore.get_spell(player)
	return player:get_attribute("axiscore_spell")
end


function axiscore.cast_active_spell(itemstack, player, pointed, stats)
	local spell = axiscore.get_spell(player)
	local spell = string.split(spell, ";")
	local old_val={result="nil"}
	for _,comp in ipairs(spell) do
		if axiscore.spellcomponents[comp] then
			old_val=axiscore.spellcomponents[comp].func(itemstack, player, pointed, stats, old_val)
		end
	end
end

axiscore.spellcomponents["touch"]={
	description="Target:Touch",
	func=function(itemstack, player, pointed, stats, old_val)
		if old_val then
			if axiscore.get_quintessence(player) > 9 then
				if old_val.result=="nil" then
					if pointed.type == "object" then
						axiscore.set_quintessence(player, axiscore.get_quintessence(player)-10)
						return {result="success", target_type="obj", target=pointed.ref}
					elseif pointed.type=="node" then
						axiscore.set_quintessence(player, axiscore.get_quintessence(player)-10)
						return {result="success", target_type="node", target=minetest.get_pointed_thing_position(pointed, false)}
					end
				end
			end
		end
	end
}

axiscore.spellcomponents["self"]={
	description="Target:self",
	func=function(itemstack, player, pointed, stats, old_val)
		if old_val then
			if axiscore.get_quintessence(player) > 9 then
				if old_val.result=="nil" then
					return {result="success", target_type="obj", target=player}
				end
			end
		end
	end
}


function axiscore.get_node_diggable(node)
	local def = ItemStack(node):get_definition()
	return def.diggable
end

axiscore.spellcomponents["break"]={
	description="Action:Break",
	func=function(itemstack, player, pointed, stats, old_val)
		if old_val then
			if axiscore.get_quintessence(player) > (99*stats.cost)+stats.cost then
				if old_val.result=="success" then
					if old_val.target_type=="node" then
						if axiscore.get_node_diggable(minetest.get_node(old_val.target).name) then
							player:get_inventory():add_item("main", minetest.get_node(old_val.target).name)
							minetest.remove_node(old_val.target)
							axiscore.set_quintessence(player, axiscore.get_quintessence(player)-100*stats.cost)
							return {result="success", target_type="node", target=old_val.target}
						end
					end
				end
			end
		end
	end
}

axiscore.spellcomponents["explode"]={
	description="Action:Explode",
	func=function(itemstack, player, pointed, stats, old_val)
		if old_val then
			if axiscore.get_quintessence(player) > (299*stats.cost)+stats.cost then
				if old_val.result=="success" then
					if old_val.target_type=="node" then
						tnt.boom(old_val.target, {radius=stats.output, damage_radius=stats.output})
						axiscore.set_quintessence(player, axiscore.get_quintessence(player)-200*stats.cost)
						return {result="success", target_type="node", target=old_val.target}
					end
				end
			end
		end
	end
}

axiscore.spellcomponents["cut"]={
	description="Action:Cut",
	func=function(itemstack, player, pointed, stats, old_val)
		if old_val then
			if axiscore.get_quintessence(player) > (9*stats.cost)+stats.cost then
				if old_val.result=="success" then
					if old_val.target_type=="obj" then
						local damage = stats.output*3
						old_val.target:punch(player, 1.0, {
							full_punch_interval = 1.0,
							damage_groups= {fleshy = damage},
						})
						axiscore.set_quintessence(player, axiscore.get_quintessence(player)-10*stats.cost)
						return {result="success", target_type="obj", target=old_val.target}
					end
				end
			end
		end
	end
}

axiscore.spellcomponents["salve"]={
	description="Action:Heal",
	func=function(itemstack, player, pointed, stats, old_val)
		if old_val then
			if axiscore.get_quintessence(player) > (9*stats.cost)+stats.cost then
				if old_val.result=="success" then
					if old_val.target_type=="obj" then
						local damage = stats.output*-3
						old_val.target:punch(player, 1.0, {
							full_punch_interval = 1.0,
							damage_groups= {fleshy = damage},
						})
						axiscore.set_quintessence(player, axiscore.get_quintessence(player)-10*stats.cost)
						return {result="success", target_type="obj", target=old_val.target}
					end
				end
			end
		end
	end
}

local function tableHasKey(table,key)
    return table[key] ~= nil
end

for _,head in ipairs(axiscore.plates) do
	for __,butt in ipairs(axiscore.plates) do
		for ___,handle in ipairs(axiscore.handles) do 
			local head_def = ItemStack(head):get_definition()
			local butt_def = ItemStack(butt):get_definition()
			local handle_def = ItemStack(handle):get_definition()
			if handle_def.groups.woodhandle then
				local attrlist = {}
				for _,attr in ipairs(head_def.attributes) do
					if attr.name then
						if not tableHasKey(attrlist, attr.name) then
							attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
						else
							attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
						end
					end
				end
				for _,attr in ipairs(butt_def.attributes) do
					if attr.name then
						if not tableHasKey(attrlist, attr.name) then
							attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
						else
							attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
						end
					end
				end
				for _,attr in ipairs(handle_def.attributes) do
					if attr.name then
						if not tableHasKey(attrlist, attr.name) then
							attrlist[attr.name]={level=1, func=attr.func, name=attr.name}
						else
							attrlist[attr.name]={level=attrlist[attr.name].level+1, func=attr.func, name=attr.name}
						end
					end
				end
				local attrpt=""
				for a,n in pairs(attrlist) do
					attrpt=attrpt..a.." "..n.level
				end
				minetest.register_tool("axiscore:staff_".._..__..___, {
					description = handle_def.displayname.." Staff"..attrpt.."\nCost: "..handle_def.groups.qn_cost.."\nStrength: "..head_def.groups.qn_output.."\nSpeed: "..handle_def.groups.qn_efficiency,
					inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image2..")^("..butt_def.inventory_image3..")",
					sound = {breaks = "default_tool_breaks"},
					attributes=attrlist,
					groups={qn_output=head_def.groups.qn_output, qn_cost=handle_def.groups.qn_cost, qn_efficiency=handle_def.groups.qn_efficiency, not_in_creative_inventory=1},
					on_use=function(itemstack, player, pointed)
						axiscore.cast_active_spell(itemstack, player, pointed, {output=head_def.groups.qn_output, cost=handle_def.groups.qn_cost, efficiency=handle_def.groups.qn_efficiency})
					end
				})
				minetest.register_craft({
					output = "axiscore:staff_".._..__..___,
					recipe = {
						{'', head, ''},
						{'', handle, ''},
						{'', butt, ''},
					},
				})
				minetest.register_tool("axiscore:staff2_".._..__..___, {
					description = handle_def.displayname.." Projection Staff"..attrpt.."\nCost: "..handle_def.groups.qn_cost.."\nStrength: "..head_def.groups.qn_output.."\nSpeed: "..handle_def.groups.qn_efficiency,
					inventory_image = "("..handle_def.inventory_image..")^(".."axiscore_projhead.png"..")^("..butt_def.inventory_image3..")",
					sound = {breaks = "default_tool_breaks"},
					attributes=attrlist,
					groups={qn_output=head_def.groups.qn_output, qn_cost=handle_def.groups.qn_cost, qn_efficiency=handle_def.groups.qn_efficiency, not_in_creative_inventory=1},
					stats={output=head_def.groups.qn_output, cost=handle_def.groups.qn_cost, efficiency=handle_def.groups.qn_efficiency},
					on_use=function(itemstack, player, pointed)
						axiscore.cast_active_spell(itemstack, player, pointed, {output=head_def.groups.qn_output, cost=handle_def.groups.qn_cost, efficiency=handle_def.groups.qn_efficiency})
					end
				})
				minetest.register_craft({
					output = "axiscore:staff2_".._..__..___,
					recipe = {
						{'', "axiscore:blank_projectile_index", ''},
						{'', "axiscore:staff_".._..__..___, ''},
						{'', '', ''},
					},
				})
			end
		end
	end
end
