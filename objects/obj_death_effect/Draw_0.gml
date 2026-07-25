var get_CamX = camera_get_view_border_x(view_camera[0] + (camera_get_view_width(view_camera[0])/2))
var get_CamY = camera_get_view_border_y(view_camera[0] + (camera_get_view_height(view_camera[0])/2))


if (global.dead){
	draw_sprite_ext(spr_Gui_Stretch, 0, get_CamX, get_CamY, 2000, 2000, 0, c_red, alpha);
	draw_self();
}
