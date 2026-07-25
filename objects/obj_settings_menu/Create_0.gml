gui_x1 = camera_get_view_x(global.Camera);
gui_y1 = camera_get_view_y(global.Camera);

gui_x2 = camera_get_view_x(global.Camera) + camera_get_view_width(global.Camera) - 50;
gui_y2 = camera_get_view_y(global.Camera) + camera_get_view_height(global.Camera) - 50;

cam_size = camera_get_view_height(global.Camera)

margin = 40

menu = box_new(gui_x1+margin, gui_y1+margin+cam_size, gui_x2-margin-gui_x1, gui_y2-margin-gui_y1, 5, [true, true, true, true], [255, 255, 255, 255], [0, 0, 0, 255], {})


settings = box_new(gui_x1+margin, gui_y1+margin, gui_x2-margin-gui_x1, gui_y2-margin-gui_y1, 5, [true, true, true, true], [255, 255, 255, 255], [0, 0, 0, 255], {
	gain_text: box_new_text("Master volume", #ffffff, PGMLib_default_font, 12, 20),
	gain_slider_box: box_new(20, 60, 300, 20, 0, [false, false, false, false], [0, 0, 0, 0], [0, 0, 0, 0], {
		gain_slider: box_new_slider(200, 100, c_red, set_game_gain)
	}),
	ktype_box: box_new(0, 80, 300, 20, 0, [false, false, false, false], [0, 0, 0, 0], [0, 0, 0, 0], {
		ktype_text: box_new_text("Keyboard type", #ffffff, PGMLib_default_font, 12, 20),
		ktype_button: box_new(20, 90, 96, 32, 2, [true, true, true, true], [255, 255, 255, 255], [0, 0, 0, 255], {
			text: box_new_text("UNKNOWN", #ffffff, PGMLib_default_font, 12, 10),
		})
	})
})