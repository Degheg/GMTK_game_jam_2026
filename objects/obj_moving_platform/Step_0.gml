velocity.x = cos(image_index*2*pi/8)*platform_const.speed
velocity.y = -sin(image_index*2*pi/8)*platform_const.speed

// apply velocity
x = x+velocity.x
y = y+velocity.y

if place_meeting(x, y, obj_moving_platform_limit) {
	image_index += 4
}

