function set_game_gain(gain) {
	global.audio.gain = gain/100
	music_time = audio_sound_get_track_position(global.audio.main_theme)
	audio_stop_sound(snd_neon_sewers)
	global.audio.main_theme = audio_play_sound(snd_neon_sewers, 1, true, gain/100, music_time)
}