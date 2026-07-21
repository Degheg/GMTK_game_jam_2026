/// @desc Init the layers and world

//Set the Cellsize // Speed of the "slowest" mover (CLOSEST POWER OF 2)
global.CELL = 4;

//Create the grid height
global.GRID_H = room_height div global.CELL // the vertical size of the grid.

//Create the Grid of width 1, height = room_height div global.CELL
global.layerGrid = ds_grid_create(1, global.GRID_H);

//Loop the Grid
for ( var i = 0; i < global.GRID_H; i++ ) {
	
	//Create a layer and assign it to each grid cell from "sort_begin" layer depth - i ( it counts down )
	//At the "top" of the grid [0, 0], at the "top" of the room, the depth is highest (farthest away)
	//At the "bottom" of the grid [0, GRID_H], at the "bottom" of the room, the depth is lowest (closest)
	global.layerGrid[# 0, i] = layer_create( layer_get_depth("sort_begin") - i );	
	
}

//Extra space around the view
pixbuffer = 64;

//Get the view X,Y
viewX = camera_get_view_x( view_camera[0] );
viewY = camera_get_view_y( view_camera[0] );

//Create rectangle around view for activations
global.viewXstart = max(viewX - pixbuffer, 0);
global.viewYstart = max(viewY - pixbuffer, 0);
global.viewXend = min(viewX + camera_get_view_width(view_camera[0]) + pixbuffer, room_width);
global.viewYend = min(viewY + camera_get_view_height(view_camera[0]) + pixbuffer, room_height);

//store last x y to detect view moving
viewXlast = viewX;
viewYlast = viewY;