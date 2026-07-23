player_cons = {
	max_fall_speed: 16,
	jump_height: 14,
	gravity: 0.8,
	ladder_speed: 5,
	level_tilemap: layer_tilemap_get_id("test_tiles")
}

_speed = 5
velocity = global.player.velocity
x = global.player.x
y = global.player.y
can_jump = true
can_grab_ladder = true

//stop the previous audio cause it's not exactly 5 seconds long
//if audio_is_playing(snd_switch_placeholder) {
//	audio_stop_sound(snd_switch_placeholder)
//}
//audio_play_sound(snd_switch_placeholder, 1, 100)

alarm[0] = 5*game_get_speed(gamespeed_fps);

