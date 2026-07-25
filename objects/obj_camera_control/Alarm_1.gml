if not global.dead 
	t_shift_mil -= 1

if t_shift_mil = -1 {
	t_shift_mil = 9
	t_shift_sec -= 1
}

if !(t_shift_sec = 0 && t_shift_mil = 0) {
	alarm[1] = game_get_speed(gamespeed_fps)/10
} else { //reset reality shift clock
	t_shift_sec = global.shift_time
	t_shift_mil = 0
}