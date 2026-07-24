//bug solved thanks to dekritteh

if global.room_id[1] {
	draw_sprite(spr_moving_platform_up, image_index, x, y)
}
else
{
	draw_sprite(spr_moving_platform_down, image_index, x, y)
}
