if mouse_check_button_released(mb_left) and mouse_on(id) {
	selected = (selected + 1) mod len(keyboard_types)
}
global.keybinds = keyboard_types[selected][1]
