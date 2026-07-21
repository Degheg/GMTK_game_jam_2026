/// @desc Init Props

//Props are similar to Active objects where they don't get deactivated
//and only turn off thier draw_event outside the view in this template.
//However, they dont move at all, so we cut out the end_step event
//that updates their layer - I chose not to parent to Active in this case
//because a Prop would eventually end up vastly different than an Active Obj.

//Prop Objs: A Farm Crop, Crafting Station, Time-Based Spawn, Production, or Resource

image_speed = 0;

alarm[11] = room_speed * 2; // 2 seconds

	//Assign my layer in grid
	updateLayers();