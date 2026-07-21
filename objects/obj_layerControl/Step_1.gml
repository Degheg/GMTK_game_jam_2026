/// @desc Update View

//Get the view X,Y
viewX = camera_get_view_x( view_camera[0] );
viewY = camera_get_view_y( view_camera[0] );

//Did the view move?
if ( viewX != viewXlast || viewY != viewYlast ) {
	
	//Update rectangle around view for activations
	global.viewXstart = max(viewX - pixbuffer, 0);
	global.viewYstart = max(viewY - pixbuffer, 0);
	global.viewXend = min(viewX + camera_get_view_width(view_camera[0]) + pixbuffer, room_width);
	global.viewYend = min(viewY + camera_get_view_height(view_camera[0]) + pixbuffer, room_height);
	
	//Activate any instances within the view area
	instance_activate_region(global.viewXstart, global.viewYstart, global.viewXend, global.viewYend, true);

}

//store last x y to detect view moving
viewXlast = viewX;
viewYlast = viewY;
