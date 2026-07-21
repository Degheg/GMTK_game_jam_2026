/// @desc Disable Draw_Event w\View

//Stops instances from "popping" in and out of existence
//Takes teeny more CPU because more instances would be active at a time

//check whether ANY part of instance is in View
if ( bbox_right >= global.viewXstart && bbox_bottom >= global.viewYstart && bbox_left <= global.viewXend && bbox_top <= global.viewYend  ) {
	
	//in view
	if ( !visible ) {
		visible = true;
		//Assign my layer in grid
		updateLayers();
	}	
	alarm[11] = room_speed * 2; // 2 seconds
	
} else {
	//not in view stop drawing me
	visible = false;
	alarm[11] = 8; // 8 = ( ( pixBuffer / global.CELL ) / 2 )
	
}