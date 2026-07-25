if menu.y > gui_y1 + margin {menu.y -= cam_size/20}
else {
	menu = settings;
		if not instance_exists(obj_settings_keybinds) {
			setkbinds_obj = instance_create_layer(gui_x1+margin+0+20, gui_y1+margin+80+90,layer, obj_settings_keybinds)
		}
		settings.content.ktype_box.content.ktype_button.content.text.text = setkbinds_obj.keyboard_types[setkbinds_obj.selected][0]
	}