
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

function axiscore.set_active_spell(player, spell)
	player:set_attribute("axiscore_active_spell", spell)
end

function axiscore.get_active_spell(player)
	return player:get_attribute("axiscore_active_spell")
end

function axiscore.execute_spell(spell, tool, caster, target)
	if spell and tool and caster then
		local components = string.split(spell, ";")
		local prevval = ""
		for _,component in ipairs(components) do
			if axiscore.spellcomponents[component] then
				prevval = axiscore.spellcomponents[component].func(tool, caster, target, prevval)
			end
		end
	end
end

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
					description = handle_def.displayname.." Staff"..attrpt,
					inventory_image = "("..handle_def.inventory_image..")^("..head_def.inventory_image2..")^("..butt_def.inventory_image3..")",
					groups = {not_in_creative_inventory=1},
					sound = {breaks = "default_tool_breaks"},
					attributes=attrlist,
					on_use=function(itemstack, player, pointed)
						axiscore.execute_spell(axiscore.get_active_spell(player), itemstack, player, pointed)
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
			end
		end
	end
end