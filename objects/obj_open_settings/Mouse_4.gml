if mouse_on(id) {
	if not opened {
		menu_inst = instance_create_layer(0, 0, layer, obj_settings_menu)
	}
	else {
		instance_destroy(menu_inst)
	}
	opened = not opened
	image_index = not image_index
}
