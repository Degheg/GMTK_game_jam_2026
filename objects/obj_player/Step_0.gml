// tilemap collision
if place_meeting(x, y+2, player_cons.level_tilemap) {
	velocity.y = 0
	can_jump = true
}
// freefall
else {
	velocity.y = min(velocity.y+1, player_cons.max_fall_speed) 
};


// x velocity, for now only affected by keyboard inputs
velocity.x = keyboard_check(global.keybinds.right)*_speed-keyboard_check(global.keybinds.left)*_speed; 

// x plane collision

if place_meeting(x+velocity.x, y-2, player_cons.level_tilemap) {
	velocity.x = 0
}

// jump
if keyboard_check_pressed(global.keybinds.jump) and can_jump {
	velocity.y = -15
	can_jump = false
}


// apply velocity
x += velocity.x;
y += velocity.y
