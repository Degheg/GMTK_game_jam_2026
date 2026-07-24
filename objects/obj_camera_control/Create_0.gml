size = round(640*1.77);
global.Camera = camera_create_view(0, 0, 1280, 720);

view_enabled = true;
view_visible[0] = true;
view_set_camera(0, global.Camera)

//reality shift timer
t_shift_sec = global.shift_time
t_shift_mil = 0

alarm[0] = game_get_speed(gamespeed_fps)/10
alarm[1] = game_get_speed(gamespeed_fps)/10