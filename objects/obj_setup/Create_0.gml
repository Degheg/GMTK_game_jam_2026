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
global.moving_platforms =
{

}

// time for reality shift
global.shift_time = 5


//room_id[0] is for the level (not sure we're gonna make more than one level tho
//room_id[1] is for wich reality we are in
//false is the sewers, true is the cyberpunk city
global.room_id = [0, false]

//room table
global.rooms = ds_grid_create(2, 3) //total number of levels

global.rooms[# 0, false] = rm_setup
global.rooms[# 1, false] = rm_testroom_down
global.rooms[# 1, true] = rm_testroom_up

audio_play_sound(prototype1, 1, true, 100)

//global clock
global.t_min = 2
global.t_sec = 0
global.t_mil = 0

//dev tools
global.deactivate_reality_switch = false