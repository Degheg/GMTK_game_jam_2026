audio_play_sound(snd_neon_sewers, 1, true, 100)

//keybinds
global.keybinds =
{
	left: 65,
	right: 68,
	up: 87,
	down: 83,
	jump: 32,
	interact: 69
}

//
global.spawn_point =
{
	x: 1350,
	y: 76
}

//player variables to keep track of when changing reality
global.player =
{
	x: global.spawn_point.x,
	y: global.spawn_point.y,
	velocity: {x:0, y:0}
}

//positions of moving platforms to keep track of when changing reality
global.moving_platforms = {}

// camera setup
global.Camera = camera_create_view(0, 0, 1280, 720);


// time for reality shift
global.shift_time = 5

//global clock
global.t_min = 2
global.t_sec = 0
global.t_mil = 0

//room_id[0] is for the level (not sure we're gonna make more than one level tho
//room_id[1] is for wich reality we are in
//false is the sewers, true is the cyberpunk city
global.room_id = [0, false]

//room table
global.rooms = ds_grid_create(2, 3) //total number of levels

global.rooms[# 0, false] = rm_setup
global.rooms[# 1, false] = rm_testroom_down
global.rooms[# 1, true] = rm_testroom_up

//dev tools
global.deactivate_reality_switch = false