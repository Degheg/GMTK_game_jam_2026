size = round(640*1.77);
global.Camera = camera_create_view(0, 0, 1280, 720);

view_enabled = true;
view_visible[0] = true;
view_set_camera(0, global.Camera)
