// tilemap floor collision
if place_meeting(x, y+2, rope_const.level_tilemap) {
	velocity.upy = 0
	velocity.dwy = 0
}
// freefall
else {
	velocity.upy = min(velocity.upy+rope_const.gravity, rope_const.max_fall_speed)
	velocity.dwy = min(velocity.dwy+rope_const.gravity, rope_const.max_fall_speed)
	
};

if place_meeting(x, y, obj_moving_platform_limit) {
	velocity.upx = 0
	velocity.upy = 0
	//velocity.dwx = velocity.dwx mod 32 - 16
}
if place_meeting(x, y+32, obj_moving_platform_limit) {
	velocity.dwx = 0
	velocity.dwy = 0
}

//apply velocity
direction = arctan2(y+velocity.upy, x+velocity.upx)
final_px = x+velocity.upx/2+velocity.dwx/2
final_py = y+velocity.upy/2+velocity.dwy/2
x = final_px
y = final_py
