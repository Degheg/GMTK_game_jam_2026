player_cons = {
	max_fall_speed: 16,
	jump_height: 14,
	gravity: 0.8,
	ladder_speed: 5,
	level_tilemap: layer_tilemap_get_id("test_tiles"),
	max_hp: 3
}

hp = 3
_speed = 5
velocity = global.player.velocity
x = global.player.x
y = global.player.y
can_jump = true
can_grab_ladder = true
can_grab_platform = true
global.dead = false

// reality shift based on global.shift_time
alarm[0] = global.shift_time*game_get_speed(gamespeed_fps);

