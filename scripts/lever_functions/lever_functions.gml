// Les actifs du script ont changé pour v2.3.0 Voir
// https://help.yoyogames.com/hc/en-us/articles/360005277377 pour plus d’informations
function AAAAA(nothing) {
	audio_play_sound(snd_switch_placeholder, 2, false, 100)
}

function set_spawn(infos) {
	global.spawn_point.x = infos[0]
	global.spawn_point.y = infos[1]
}