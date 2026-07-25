// press R to revive

if (global.dead){
    global.dead = false
	global.t_sec = 20
    room_restart()
	obj_player.x = global.spawn_point.x
	obj_player.y = global.spawn_point.y
	audio_stop_sound(snd_neon_sewers)
	audio_play_sound(snd_neon_sewers, 1, true, 1)
}