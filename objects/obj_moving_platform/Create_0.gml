platform_const = {
	speed: 2
};
image_speed = 0;

if array_contains(struct_get_names(global.moving_platforms), string(id)) {
	x = variable_struct_get(global.moving_platforms, string(id))[0]
	y = variable_struct_get(global.moving_platforms, string(id))[1]
	image_index = variable_struct_get(global.moving_platforms, string(id))[2]
}
velocity = {x:0, y:0}
active = true