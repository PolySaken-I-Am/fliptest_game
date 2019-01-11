local m=minetest.get_modpath("axiscore")

dofile(m.."/quests.lua")
dofile(m.."/items.lua")

minetest.register_on_mapgen_init(function(mapgen_params)
	mapgen_params2={mgname="valleys", seed="6188653804013679363", water_level=mapgen_params.water_level, flags=mapgen_params.flags}
	minetest.set_mapgen_params(mapgen_params2)
end)

