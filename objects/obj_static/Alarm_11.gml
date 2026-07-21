/// @desc Deactivate if outside view

//Stops instances from "popping" in and out of existence
//Takes teeny more CPU because more instances would be active\drawn at a time

//check whether any part of instance is in view
if ( bbox_right >= global.viewXstart && bbox_bottom >= global.viewYstart && bbox_left <= global.viewXend && bbox_top <= global.viewYend  ) {
	//In View
} else {
	//out of view - deactivate me!
	instance_deactivate_object(id);	
	
}

alarm[11] = room_speed * 2; // 2 seconds