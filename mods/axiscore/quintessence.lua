
axiscore.spellcomponents={}

hb.register_hudbar("axiscore:quintessence", "#ffffff", "Quintessence", {bar="axiscore_quintessence_bar.png", icon="axiscore_quintessence_icon.png", bgicon="axiscore_quintessence_icon_bg.png"}, 0,1000,false,nil)

function axiscore.get_quintessence(player)
	return tonumber(player:get_attribute("axiscore_quintessence"))
end

function axiscore.set_quintessence(player, n)
	player:set_attribute("axiscore_quintessence", n)
	hb.change_hudbar(player, "axiscore:quintessence", n)
end

minetest.register_on_newplayer(function(player)
	axiscore.set_quintessence(player, 1)
	axiscore.set_active_spell(player, "proj;")
end)

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

function axiscore.set_active_spell(player, spell)
	player:set_attribute("axiscore_active_spell", spell)
end

function axiscore.get_active_spell(player)
	return player:get_attribute("axiscore_active_spell")
end



local crl=function(tool, caster, targeted, old_val)
	if type(old_val)=="table" then
		if old_val.status=="nil" then
			local pos = caster:getpos()
			local dir = caster:get_look_dir()
			local yaw = caster:get_look_yaw()
			if pos and dir and yaw then
				pos.y = pos.y + 1.6
				local obj = minetest.add_entity(pos, "axiscore:magicproj")
				if obj then
					obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
					obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
					obj:setyaw(yaw + math.pi)
					local ent = obj:get_luaentity()
					if ent then
						ent.player = ent.player or caster
					end
				end
			end
		end
	end
end

local dolist = {}

function axiscore.execute_spell(spell, tool, caster, target)
	local components = string.split(spell, ";")
	local prevval = {status="nil"}
	local do_final=function() print("called spell with no action") end
	for _,component in ipairs(components) do
		if axiscore.spellcomponents[component] then
			prevval = axiscore.spellcomponents[component].func(tool, caster, target, prevval)
			if component=="proj" then
				do_final=crl
			end
			if axiscore.spellcomponents[component].type=="action" then
				table.insert(dolist, {f=axiscore.spellcomponents[component].func, {tool=tool, caster=caster, target=target, old_val=prevval}})
			end
		end
	end
	do_final(tool, caster, target)
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

function axiscore.register_spell_component(name, def)
	axiscore.spellcomponents[name]=def
end


axiscore.register_spell_component("self", {
	description="Target:Self",
	func=function(tool, caster, targeted, old_val)
		if type(old_val)=="table" then
			if old_val.status=="nil" then
				return {status="success", target=caster, target_type="entity"}
			end
		end
	end
})

axiscore.register_spell_component("touch", {
	description="Target:Touch",
	func=function(tool, caster, targeted, old_val)
		if type(old_val)=="table" then
			if old_val.status=="nil" then
				if targeted.type=="node" then
					return {status="success", target=minetest.get_pointed_thing_position(targeted, true), target_type="worldpos"}
				elseif targeted.type=="object" then
					return {status="success", target=targeted.ref, target_type="entity"}
				end
			end
		end
	end
})

axiscore.register_spell_component("proj", {
	description="Target:Projectile",
	func=function(tool, caster, targeted, old_val)
		return {status="success"}
	end
})

local proj = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.6, y=0.6},
	textures = {"axiscore_quintessence_spark.png"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}
proj.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.065 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1.5)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "axiscore:magicproj" and obj:get_luaentity().name ~= "__builtin:item" then
					self.target=obj
					self.object:remove()
					for _,f in ipairs(dolist) do
						f.f(f.tool, f.caster, f.target, f.old_val)
					end
				end
			else
				self.target=pos
				self.object:remove()
				for _,f in ipairs(dolist) do
					 f.f(f.tool, f.caster, f.target, f.old_val)
				end
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
	minetest.add_particle({
		pos = pos,
		velocity = {x=0, y=0, z=0},
		acceleration = {x=0, y=0, z=0},
		expirationtime = 1,
		size = 1,
		glow=14,
		collisiondetection = false,
		vertical = false,
		texture = "axiscore_quintessence_spark.png",
	})
end

minetest.register_entity("axiscore:magicproj", proj )