var xx = global.room_id[0]
var yy = global.room_id[1]

if (room != ds_grid_get(global.rooms, xx, yy))
{
	room_goto(ds_grid_get(global.rooms, xx, yy))
}
