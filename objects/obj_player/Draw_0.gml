if global.dead {
	var get_CamX = camera_get_view_border_x(view_camera[0] + (camera_get_view_width(view_camera[0])/2))
	var get_CamY = camera_get_view_border_y(view_camera[0] + (camera_get_view_height(view_camera[0])/2))
	draw_sprite_ext(spr_gui_stretch, 0, get_CamX, get_CamY, 2000, 2000, 0, c_red, 0.3);
} else {
	switch (action){
	case "walk" :
		image_frame += image_speed/5
		image_frame = image_frame % sprite_get_number(spr_towa_walk)
		draw_sprite_ext(spr_towa_walk, image_index+image_frame, x, y, image_direction, 1, 0, c_white, 1)
	break
	case "run" :
		image_frame += image_speed/5
		image_frame = image_frame % sprite_get_number(spr_towa_run)
		draw_sprite_ext(spr_towa_run, image_index+image_frame, x, y, image_direction, 1, 0, c_white, 1)
	break
	case "idle" :
		draw_sprite_ext(spr_towa_idle, image_index, x, y, image_direction, 1, 0, c_white, 1)
	break
	}
}

