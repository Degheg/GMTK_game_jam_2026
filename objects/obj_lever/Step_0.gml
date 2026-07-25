if keyboard_check_pressed(global.keybinds.interact) and place_meeting(x, y, obj_player) {
	if position {try {
		lever_function_false(arg_false)
		position = false
		image_index = 0
	}}
	else {try {
		lever_function_true(arg_true)
		position = true
		image_index = 1
	}}
	audio_play_sound(snd_lever_interact, 1, false, global.audio.gain)
}
