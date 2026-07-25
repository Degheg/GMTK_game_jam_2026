image_xscale = obj_player.image_xscale;
x = obj_player.x
y = obj_player.y

image_speed = 0;
alpha = 0;
alphaIncrease = false

global.deactivate_reality_switch = true

alarm[0] = 20; //death delay
alarm[1] = 3.7*game_get_speed(gamespeed_fps) // 3.7 is snd_death lenght, adapt it if you change the asset

audio_stop_sound(snd_neon_sewers)
audio_play_sound(snd_death, 1, false, global.audio.gain)

