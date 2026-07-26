draw_sprite(spr_lever, image_index, x, y)
if place_meeting(x, y, obj_player) 
	draw_text(x, y-32, "E to Set Checkpoint")