gui_x1 = display_get_gui_width() - camera_get_view_width(global.Camera);
gui_y1 = display_get_gui_height() - camera_get_view_height(global.Camera);

gui_x2 = display_get_gui_width() - 50;
gui_y2 = display_get_gui_height() - 50;

big_box_margin = 40
big_box = box_new(big_box_margin, big_box_margin+640, gui_x2-big_box_margin, gui_y2-big_box_margin)
