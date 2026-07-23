x_view_pos = min(max(0, obj_player.x - size/2), room_width);
y_view_pos = min(max(0, obj_player.y - round(size/1.77)/2), room_height);
//+ keyboard_check(global.keybinds.down)*round(size/1.77)/2.3
//- keyboard_check(global.keybinds.up)*round(size/1.77)/2.3;


camera_set_view_size(global.Camera, size, round(size/1.77));
camera_set_view_pos(global.Camera, x_view_pos, y_view_pos)
