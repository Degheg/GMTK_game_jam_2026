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
function toggle_platform_movement(platform_ids) {
	for (var i=0; i>=len(platform_ids); i++) {
		if object_get_name(platform_ids[i]) == "obj_moving_platform" {
			pf = platform_ids[i]
			pf.active = not pf.active
		}
		else {
			show_error("Warning! - " + string(platform_ids[i]) + " at index " + string(i) + " of platform_ids is not a platform", false)
		}
	}
}