global.room_id = [1, true]
global.spawn_point =
{
	x: ds_grid_get(global.rooms, global.room_id[0], 3),
	y: ds_grid_get(global.rooms, global.room_id[0], 4)
}