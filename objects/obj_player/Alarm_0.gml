global.player.x = x;
global.player.y = y;
global.player.velocity = velocity;


// intended function, save the current room's layout
for(var map=layer_tilemap_get_id("Layer"), H=tilemap_get_height(map), W=tilemap_get_width(map), xx, yy=0; yy<H; yy++){
	for(xx=0; xx<W; xx++){
		tilemap_array[yy,xx] = tilemap_get(map,xx,yy);
	}
	tilemap_info = [tilemap_get_tileset(map), tilemap_get_tile_width(map), tilemap_get_tile_height(map)];
}


//print("Switching reality");
global.room_id[1] = not global.room_id[1]; //switching reality

// intended function, draw the previous room layout after switching (probably need to include alpha adjustment)
for(var H=array_height_2d(tilemap_array), yy=0; yy<H; yy++)
	for(var W=array_length_2d(tilemap_array, yy), xx=0; xx<W; xx++)
		draw_tile(tilemap_info[0], tilemap_array[xx,yy], 0, xx * tilemap_info[1], yy * tilemap_info[2]);

alarm[0] = 5*game_get_speed(gamespeed_fps);