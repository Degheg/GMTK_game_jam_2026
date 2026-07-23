var mp = variable_struct_get_names(global.moving_platforms)
for (var i=0; i<len(mp); i++) {
	infos = variable_struct_get(global.moving_platforms, mp[i])
	
	print(mp[i])
	
	instance_create_layer(
	infos[0],
	infos[1],
	layer_get_id("Instances_tracker"),
	obj_moving_platform_tracker,
	{image_index: infos[2], platform_id: mp[i]}
	)
}
global.moving_platforms = {}