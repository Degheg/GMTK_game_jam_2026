if !(global.t_sec = 0 && global.t_min = 0 && global.t_mil = 0) {
	global.t_mil -= 1

	if global.t_mil = -1 {
		global.t_mil = 9
		global.t_sec -= 1
	}

	if global.t_sec = -1 {
		global.t_sec = 59
		global.t_min -= 1
	}
	alarm[0] = game_get_speed(gamespeed_fps)/10
} else {
	show_debug_message("Time's up!")
	// game over event
	global.times_up = true
	obj_player.image_index = spr_wolf_dead
	instance_create_depth(mouse_x, mouse_y, -200, obj_time_up_control)
}