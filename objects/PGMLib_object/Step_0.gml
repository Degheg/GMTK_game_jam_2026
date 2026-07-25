if role == "obj_slider" {
	if mouse_check_button_released(mb_left) {
		follow = false
		method_call(box.call, [box.position])
	}
	else if follow {
		box.position = min(max(mouse_x-sx, 0), box.length);
		x = sx+box.position
		
	}
	else if mouse_on(id) and mouse_check_button_pressed(mb_left) {
		follow = true
	}
}
