// Les actifs du script ont changé pour v2.3.0 Voir
// https://help.yoyogames.com/hc/en-us/articles/360005277377 pour plus d’informations
function AAAAA(nothing) {
	audio_play_sound(snd_switch_placeholder, 2, false, 100)
}


function set_spawn(infos) {
	global.spawn_point.x = infos[0]
	global.spawn_point.y = infos[1]
}

/// @desc	Starts or stops the movement of designated moving platforms
/// @arg	{Array}	platform_ids	An array of the ids of the affected platforms
function toggle_platform_movement(rect) {
	var platform_ids = ds_list_create()
	collision_rectangle_list(rect[0], rect[1], rect[2], rect[3], obj_moving_platform, false, true, platform_ids, false)
	for (var i=0; i<ds_list_size(platform_ids); i++) {
		var pf = platform_ids[| i]
		pf.active = not pf.active
	}
}