global.player.x = x;
global.player.y = y;
global.player.velocity = velocity;

//print("Switching reality");
global.room_id[1] = not global.room_id[1]; //switching reality

alarm[0] = 5*game_get_speed(gamespeed_fps);