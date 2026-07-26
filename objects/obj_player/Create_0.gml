player_cons = {
	max_fall_speed: 16,
	jump_height: 14,
	jump_max_timer: 10,
	jump_timer_height: 7,
	gravity: 0.8,
	ladder_speed: 5,
	level_tilemap: layer_tilemap_get_id("active_tilemap"),
}

enum ACTION {
	WALK,
	WALK_JUMP,
	RUN,
	RUNNING_JUMP,
	RUNNING_BOOST_JUMP,
	INJURY,
	IDLE,
	DEAD
}

stun = false
_speed = 5
velocity = global.player.velocity
x = global.player.x
y = global.player.y
can_grab_ladder = true
can_grab_platform = true
if global.dead {
	show_debug_message("Respawning")
	global.player.hp = 3
	x = global.spawn_point.x
	y = global.spawn_point.y	
}
global.dead = false
image_xscale = 1
image_yscale = 1
image_speed = 1
image_frame = 0
action = ACTION.IDLE
inv_frames = false
hurt_frames = false

// reality shift based on global.shift_time
alarm[0] = global.shift_time*game_get_speed(gamespeed_fps);

