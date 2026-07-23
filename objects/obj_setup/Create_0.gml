//keybinds
global.keybinds =
{
	left: 65,
	right: 68,
	up: 87,
	down: 83,
	jump: 32
}

//player variables to keep track when changing reality
global.player =
{
	x: 256,
	y: 320,
	velocity: {x:0, y:0}
}

//room_id[0] is for the level (not sure we're gonna make more than one level tho
//room_id[1] is for wich reality we are in
//false is the sewers, true is the cyberpunk city
global.room_id = [0, false]

//room table
global.rooms = ds_grid_create(2, 3) //total number of levels

global.rooms[# 0, false] = rm_setup
global.rooms[# 1, false] = rm_testroom_down
global.rooms[# 1, true] = rm_testroom_up
