
local note1text=""..
"Quite recently, in a house very far away, a person became\ntired of their boring job."..
"They wished quietly to themself\n to travel to a far off land, another world.\n"..
"They wished for an interesting life far away from their boring job.\n"..
"They did not under stand the implications of this however, and\n"..
"their wish was granted by a nosy genie.\n"..
"This is a story of you, and how you came to be in this world.\n\n"..
"Read the descriptions in the quest log for more info."

minetest.register_craftitem("axiscore:note_1", {
	description = minetest.colorize("#5fff00", "A short note on your situation"),
	inventory_image = "axiscore_note.png",
	groups={not_in_creative_inventory=1},
	on_use=function(itemstack,user)
		minetest.show_formspec(user:get_player_name(), "note1", "size[7,8]label[0.2,0.2;"..note1text.."]")
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname=="note1" then
		quests.accept_quest(player:get_player_name(), "fliptest:beginning")
		minetest.chat_send_player(player:get_player_name(), minetest.colorize("#ff00ff","Find some pebbles on the ground."))
		player:get_inventory():remove_item("main", "axiscore:note_1")
		quests.start_quest(player:get_player_name(), "fliptest:q1")
	end
end)

minetest.register_craftitem("axiscore:craft_knife", {
	description = minetest.colorize("#5fff00", "Craftsman's Knife\nIs not consumed in crafting recipes"),
	inventory_image = "axiscore_craftknife.png",
	stack_max=1
})

minetest.register_craftitem("axiscore:craft_hammer", {
	description = minetest.colorize("#5fff00", "Craftsman's Hammer\nIs not consumed in crafting recipes"),
	inventory_image = "axiscore_crafthammer.png",
	stack_max=1
})

minetest.register_craftitem("axiscore:iron_slag", {
	description = "Iron Slag",
	inventory_image = "axiscore_iron_slag.png",
})

minetest.register_craftitem("axiscore:iron_nuggets", {
	description = "Iron Nuggets",
	inventory_image = "axiscore_iron_nuggets.png",
})

minetest.register_craftitem("axiscore:iron_mix", {
	description = "Steel Base",
	inventory_image = "axiscore_iron_mix.png",
})

minetest.register_craftitem("axiscore:book_index", {
	description = minetest.colorize("#5fff00", "The Back Cover of a Book"),
	inventory_image = "axiscore_book_index.png",
})

minetest.register_craftitem("axiscore:book_cover", {
	description = minetest.colorize("#5fff00", "The Front Cover of a Book"),
	inventory_image = "axiscore_book_cover.png",
})

minetest.register_craftitem("axiscore:blank_projectile_index", {
	description = minetest.colorize("#5fff00", "Blank Projectile Index"),
	inventory_image = "axiscore_projectile_index.png",
})

minetest.register_craftitem("axiscore:book_reverse", {
	description = minetest.colorize("#5fff00", "Backwards Book"),
	inventory_image = "axiscore_book_reverse.png"
})


local bone = "Arm_Right"
local pos = {x=0, y=5.5, z=3}
local scale = {x=0.25, y=0.25}
local rx = -90
local rz = 90

minetest.register_tool("axiscore:spittleblade", {
	description = minetest.colorize("#2aaf33", "Death Merchant\n")..minetest.colorize("#ff0000", "55 Melee Damage\nRightclick to launch a poisoned blade"),
	inventory_image = "axiscore_legendary_talon.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=10,
		groupcaps={
			snappy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=250, maxlevel=10},
		},
		damage_groups = {fleshy=55},
	},
	sound = {breaks = "default_tool_breaks"},
	on_secondary_use=function(itemstack, user, pointed_thing)
		if axiscore.get_quintessence(user) > 39 then
			local pos = user:getpos()
			local dir = user:get_look_dir()
			local yaw = user:get_look_yaw()
			if pos and dir and yaw then
				pos.y = pos.y + 1.6
				local obj = minetest.add_entity(pos, "axiscore:poison_spit")
				if obj then
					obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
					obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
					obj:setyaw(yaw + math.pi)
					local ent = obj:get_luaentity()
					if ent then
						ent.player = ent.player or user
					end
				end
			end
			axiscore.set_quintessence(user, axiscore.get_quintessence(user)-40)
		end
	end
})

wield3d.location["axiscore:spittleblade"] = {bone, {x=0, y=5, z=7}, {x=rx, y=225, z=rz}, {x=0.3, y=0.3}}

local proj = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.3, y=0.3},
	textures = {"axiscore_poison.png"},
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
				if obj:get_luaentity().name ~= "axiscore:poison_spit" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 5
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					playereffects.apply_effect_type("axiscore:poison", duration, obj, 10)
					self.object:remove()
				end
			else
				local damage = 5
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				playereffects.apply_effect_type("axiscore:poison", duration, obj, 10)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("axiscore:poison_spit", proj )

playereffects.register_effect_type("axiscore:poison", "Poison", "axiscore_poison.png", {}, function(player) player:set_hp(player:get_hp()-1) end, nil, false, true, 1.0)


minetest.register_tool("axiscore:skywhipper", {
	description = minetest.colorize("#38c4d1", "SkyWhipper\n")..minetest.colorize("#ff0000", "60 Melee Damage\nRightclick to dashstab\nShift-Rightclick to dash back"),
	inventory_image = "axiscore_legendary_icicle.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 0.001,
		max_drop_level=10,
		groupcaps={
			snappy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=250, maxlevel=10},
		},
		damage_groups = {fleshy=60},
	},
	sound = {breaks = "default_tool_breaks"},
	on_secondary_use=function(itemstack, user, pointed_thing)
		local controls=user:get_player_control()
		local userPos = user:get_pos()
		local userDir = user:get_look_dir()
		if axiscore.get_quintessence(user) > 99 then
			if controls.sneak then
				local node = minetest.get_node({x=userPos.x+userDir.x*-15, y=userPos.y+userDir.y*-15, z=userPos.z+userDir.z*-15})
				if node.name == "air" then
					user:set_pos({x=userPos.x+userDir.x*-15, y=userPos.y+userDir.y*-15, z=userPos.z+userDir.z*-15})
				end
			else
				local node = minetest.get_node({x=userPos.x+userDir.x*15, y=userPos.y+userDir.y*15, z=userPos.z+userDir.z*15})
				if node.name == "air" then
					user:set_pos({x=userPos.x+userDir.x*15, y=userPos.y+userDir.y*15, z=userPos.z+userDir.z*15})
				end
			end
			axiscore.set_quintessence(user, axiscore.get_quintessence(user)-100)
		end
	end
})

wield3d.location["axiscore:skywhipper"] = {bone, {x=0, y=5, z=7}, {x=rx, y=225, z=rz}, {x=0.3, y=0.3}}

minetest.register_tool("axiscore:dragonsbreath", {
	description = minetest.colorize("#ff6e00", "Dragon's Breath\n")..minetest.colorize("#ff0000", "70 Melee Damage\nRightclick to fire a flame projectile\nShift-Rightclick to fire a wave of fire"),
	inventory_image = "axiscore_legendary_dragonsbreath.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=10,
		groupcaps={
			snappy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=250, maxlevel=10},
		},
		damage_groups = {fleshy=290},
	},
	sound = {breaks = "default_tool_breaks"},
	on_secondary_use=function(itemstack, user, pointed_thing)
		local controls=user:get_player_control()
		if controls.sneak then
			if axiscore.get_quintessence(user) > 99 then
				local pos = user:getpos()
				local dir = user:get_look_dir()
				local yaw = user:get_look_yaw()
				if pos and dir and yaw then
					pos.y = pos.y + 1.6
					local obj = minetest.add_entity(pos, "axiscore:lava_spark")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				if pos and dir and yaw then
					local obj = minetest.add_entity(pos, "axiscore:lava_spark")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 40})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				if pos and dir and yaw then
					local obj = minetest.add_entity(pos, "axiscore:lava_spark")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 50})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				if pos and dir and yaw then
					local obj = minetest.add_entity(pos, "axiscore:lava_spark")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 35})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				if pos and dir and yaw then
					local obj = minetest.add_entity(pos, "axiscore:lava_spark")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 55})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				axiscore.set_quintessence(user, axiscore.get_quintessence(user)-100)
			end
		else
			if axiscore.get_quintessence(user) > 49 then
				local pos = user:getpos()
				local dir = user:get_look_dir()
				local yaw = user:get_look_yaw()
				if pos and dir and yaw then
					pos.y = pos.y + 1.6
					local obj = minetest.add_entity(pos, "axiscore:lava_spark")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				axiscore.set_quintessence(user, axiscore.get_quintessence(user)-50)
			end
		end
	end
})

wield3d.location["axiscore:dragonsbreath"] = {bone, {x=0, y=5, z=7}, {x=rx, y=225, z=rz}, {x=0.3, y=0.3}}

local proj = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.3, y=0.3},
	textures = {"axiscore_fire.png"},
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
				if obj:get_luaentity().name ~= "axiscore:lava_spark" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 10
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					playereffects.apply_effect_type("axiscore:burn", duration, obj, 10)
					self.object:remove()
				end
			else
				local damage = 10
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				playereffects.apply_effect_type("axiscore:burn", duration, obj, 10)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("axiscore:lava_spark", proj )

playereffects.register_effect_type("axiscore:burn", "On Fire", "axiscore_fire.png", {}, function(player) player:set_hp(player:get_hp()-1) end, nil, false, true, 2.0)


minetest.register_tool("axiscore:windhammer", {
	description = minetest.colorize("#ffe500", "WindHammer\n")..minetest.colorize("#ff0000", "60 Melee Damage\nRightclick to create a crackling lighning bolt\nShift-Rightclick to summon a thunderstorm"),
	inventory_image = "axiscore_legendary_lightning.png",
	wield_scale = {x=3.0, y=3.0, z=1.0},
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=10,
		groupcaps={
			snappy = {times={[1]=0.50, [2]=0.50, [3]=0.20}, uses=250, maxlevel=10},
		},
		damage_groups = {fleshy=290},
	},
	sound = {breaks = "default_tool_breaks"},
	on_secondary_use=function(itemstack, user, pointed_thing)
		local controls=user:get_player_control()
		if controls.sneak then
			if axiscore.get_quintessence(user) > 499 then
				local pos = user:getpos()
				local dir = user:get_look_dir()
				local yaw = user:get_look_yaw()
				if pos and dir and yaw then
					pos.y = pos.y + 1.6
					local obj = minetest.add_entity(pos, "axiscore:storm")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				axiscore.set_quintessence(user, axiscore.get_quintessence(user)-500)
			end
		else
			if axiscore.get_quintessence(user) > 99 then
				local pos = user:getpos()
				local dir = user:get_look_dir()
				local yaw = user:get_look_yaw()
				if pos and dir and yaw then
					pos.y = pos.y + 1
					local obj = minetest.add_entity(pos, "axiscore:lightning")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				if pos and dir and yaw then
					pos.y = pos.y + 1
					local obj = minetest.add_entity(pos, "axiscore:lightning")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				if pos and dir and yaw then
					pos.y = pos.y + 1
					local obj = minetest.add_entity(pos, "axiscore:lightning")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				if pos and dir and yaw then
					pos.y = pos.y + 1
					local obj = minetest.add_entity(pos, "axiscore:lightning")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				if pos and dir and yaw then
					pos.y = pos.y + 1
					local obj = minetest.add_entity(pos, "axiscore:storm")
					if obj then
						obj:setvelocity({x=dir.x * 45, y=dir.y * 45, z=dir.z * 45})
						obj:setacceleration({x=dir.x * 0, y=0, z=dir.z * 0})
						obj:setyaw(yaw + math.pi)
						local ent = obj:get_luaentity()
						if ent then
							ent.player = ent.player or user
						end
					end
				end
				axiscore.set_quintessence(user, axiscore.get_quintessence(user)-100)
			end
		end
	end
})

wield3d.location["axiscore:windhammer"] = {bone, {x=0, y=5, z=7}, {x=rx, y=225, z=rz}, {x=0.3, y=0.3}}

local proj = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"axiscore_lightning.png"},
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
				if obj:get_luaentity().name ~= "axiscore:lightning" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 10
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					playereffects.apply_effect_type("axiscore:burn", duration, obj, 10)
					self.object:remove()
				end
			else
				local damage = 10
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				playereffects.apply_effect_type("axiscore:burn", duration, obj, 10)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("axiscore:lightning", proj )


local proj = {
	physical = false,
	timer = 0,
	visual = "sprite",
	visual_size = {x=0.3, y=0.3},
	textures = {"axiscore_storm.png"},
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
				if obj:get_luaentity().name ~= "axiscore:storm" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 30
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					self.object:remove()
				end
			else
				local damage = 30
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("axiscore:storm", proj )
