var get_CamX = camera_get_view_border_x(view_camera[0] + (camera_get_view_width(view_camera[0])/2))
var get_CamY = camera_get_view_border_y(view_camera[0] + (camera_get_view_height(view_camera[0])/2))


switch (action){
	case ACTION.WALK :
		image_frame += image_speed/5;
		image_frame = image_frame % sprite_get_number(spr_towa_walk);
		draw_sprite_ext(spr_towa_walk, image_index+image_frame, x, y, global.player.image_direction, 1, 0, c_white, 1);
	break;
	case ACTION.WALK_JUMP:
		draw_sprite_ext(spr_towa_walk_jump, image_index, x, y, global.player.image_direction, 1, 0, c_white, 1);
	break;
	case ACTION.RUN :
		image_frame += image_speed/5;
		image_frame = image_frame % sprite_get_number(spr_towa_run);
		draw_sprite_ext(spr_towa_run, image_index+image_frame, x, y, global.player.image_direction, 1, 0, c_white, 1);
	break;
	case ACTION.RUNNING_JUMP:
		draw_sprite_ext(spr_towa_run_jump, image_index, x, y, global.player.image_direction, 1, 0, c_white, 1);
	break;
	case ACTION.RUNNING_BOOST_JUMP:
		draw_sprite_ext(spr_towa_run_boost_jump, image_index, x, y, global.player.image_direction, 1, 0, c_white, 1);
	break;
	case ACTION.INJURY :
		image_frame += image_speed/5;
		image_frame = image_frame % sprite_get_number(spr_towa_hurt);
		draw_sprite_ext(spr_towa_hurt, image_index+image_frame, x, y, global.player.image_direction, 1, 0, c_white, 1);
	break;
	case ACTION.IDLE :
		draw_sprite_ext(spr_towa_idle, image_index, x, y, global.player.image_direction, 1, 0, c_white, 1)
	break;
	case ACTION.DEAD :
		draw_sprite_ext(spr_gui_stretch, 0, get_CamX, get_CamY, 2000, 2000, 0, c_red, 0.3);
		draw_sprite_ext(spr_towa_dead, image_index, x, y, global.player.image_direction, 1, 0, c_white, 1)
	break;
}


