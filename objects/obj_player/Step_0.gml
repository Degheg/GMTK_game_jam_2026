// THE ORDER AT WICH COLLISIONS ARE CHECKED IS IMPORTANT
// make sure to know what you're doing before modifying it

// tilemap floor collision
if place_meeting(x, y+velocity.y+2, player_cons.level_tilemap) {
	////print("floor collision")
	velocity.y = 0
	can_jump = true
}
// freefall
else {
	////print("freefall")
	velocity.y = min(velocity.y+player_cons.gravity, player_cons.max_fall_speed)
	velocity.x = min(max(0, velocity.x-0.5), velocity.x-0.5)
};


// x velocity, for now only affected by keyboard inputs
input_vx = keyboard_check(global.keybinds.right)*_speed-keyboard_check(global.keybinds.left)*_speed;
velocity.x = input_vx

// moving platform floor collision 
var _movingPlatform = instance_place(x, y+velocity.y, obj_moving_platform)

if (_movingPlatform != noone) {
	if y < _movingPlatform.y+16 {
		velocity.x = _movingPlatform.velocity.x + input_vx;
		velocity.y = _movingPlatform.velocity.y;
		can_jump = true
	}
	else {
		//platform under grabbing
		if can_grab_platform and (distance_to_point(_movingPlatform.x, _movingPlatform.y) < 20) {
			can_jump = true;
			var current_platform = _movingPlatform;
			x = current_platform.x;
			y = current_platform.y + 35;
			velocity.x = _movingPlatform.velocity.x;
			velocity.y = _movingPlatform.velocity.y
		}
		else {
			velocity.y = 6
		}
	}
}
else {
	can_grab_platform = true
};

// right wall collision
if place_meeting(x+velocity.x, y-2, player_cons.level_tilemap) {
	////print("right wall")
	//making it impossible to move further right instead of locking th player in place
	velocity.x = -keyboard_check(global.keybinds.left)*_speed; 
};

//left wall collision
if place_meeting(x+velocity.x, y-2, player_cons.level_tilemap) {
	////print("left wall")
	//making it impossible to move further left instead of locking th player in place
	velocity.x = keyboard_check(global.keybinds.right)*_speed;
};

// ladder climbing
if place_meeting(x, y, obj_ladder) {	
	//lock the player on the ladder
	if can_grab_ladder {
		velocity.y = 0
		can_jump = true
		var current_ladder = instance_place(x, y, obj_ladder)
		x = current_ladder.x + 16
		velocity.x = 0
	};
	
	//moving on the ladder
	if keyboard_check(global.keybinds.up)
		velocity.y = -player_cons.ladder_speed
	else if keyboard_check(global.keybinds.down) {
		velocity.y = player_cons.ladder_speed
	}
}
else {
	can_grab_ladder = true
};

// jump
if keyboard_check_pressed(global.keybinds.jump){
	if can_jump {
		velocity.y = -player_cons.jump_height
		can_jump = false
		if place_meeting(x, y, obj_ladder) {
			can_grab_ladder = false
		}
		if (_movingPlatform != noone) and (y >= _movingPlatform.y) {
			can_grab_platform = false
			velocity.y = 6
		}
	}

};

//ceiling collision
if place_meeting(x, y+velocity.y-2, player_cons.level_tilemap) {
	velocity.y = 0
};

// apply velocity
if not dead {
	x += velocity.x;
	y += velocity.y
}



// EVERYTHING THAT IS NOT COLLISIONS RELATED



depth = -infinity

// respawn
if y > room_height+1000 {
	dead = true
	x = global.spawn_point.x
	y = global.spawn_point.y
}