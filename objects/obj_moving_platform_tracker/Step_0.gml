x = x+cos(image_index*2*pi/8)*platform_const.speed
y = y-sin(image_index*2*pi/8)*platform_const.speed

if place_meeting(x, y, obj_moving_platform_limit_tracker) {
	image_index += 4
}
