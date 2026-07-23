platform_const = {
	speed: 2
};
image_speed = 0;

if array_contains(struct_get_names(global.moving_platforms), id) {
	x = global.moving_platforms.id[0]
	y = global.moving_platforms.id[1]
	image_index = global.moving_platforms.id[2]
}



