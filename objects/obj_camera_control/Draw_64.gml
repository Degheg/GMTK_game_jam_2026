// draw global timer

draw_set_colour(c_white)
draw_set_font(ft_aces07)


var t = ""
t += string(global.t_min) + ":" 
if global.t_sec> 9 {
	t += ""+string(global.t_sec)};
if global.t_sec< 10 {
	t += "0" + string(global.t_sec)};
t += ".";
t += string(global.t_mil);

gui_center_h = display_get_gui_width()/2;
gui_center_v = display_get_gui_height()/2;
gui_h = display_get_gui_width() - 30;
gui_v = display_get_gui_height() - 20;


draw_text(gui_center_h, 5, t);

var t_shift = ""
t_shift += string(t_shift_sec) + "." + string(t_shift_mil)
if not global.times_up
	if global.dead {draw_text(gui_center_h, gui_center_v, t_shift)}
	else {draw_text(gui_h, gui_v, t_shift)}
else {
	draw_text(gui_h, gui_v, "Time's up!")}