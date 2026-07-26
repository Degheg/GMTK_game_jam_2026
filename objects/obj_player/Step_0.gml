// THE ORDER AT WICH COLLISIONS ARE CHECKED IS IMPORTANT
// make sure to know what you're doing before modifying it

// tilemap floor collision
if place_meeting(x, y+velocity.y+2, player_cons.level_tilemap) {
	////print("floor collision")
	velocity.y = 0
	global.player.uabilities.jumps = global.player.abilities.jumps
}
// freefall
else {
	////print("freefall")
	velocity.y = min(velocity.y+player_cons.gravity, player_cons.max_fall_speed)
	//velocity.x = sign(global.player.image_direction)*min(max(0, sign(global.player.image_direction)*velocity.x-0.5), 0)
};


// x velocity, for now only affected by keyboard inputs
input_vx = keyboard_check(global.keybinds.right)*_speed-keyboard_check(global.keybinds.left)*_speed;
sprint_coeff = keyboard_check(global.keybinds.sprint)*1.5+1
if not global.dead {
	if input_vx != 0 { 
		global.player.image_direction = 1*sign(input_vx)
		velocity.x = sign(input_vx)*min(abs(velocity.x + 0.4*sign(input_vx)), abs(sprint_coeff*input_vx))
		if (abs(velocity.x) > _speed) { 
			velocity.x = sign(input_vx)*min(abs(velocity.x - 0.2*sign(input_vx)), abs(sprint_coeff*input_vx))
			if (keyboard_check(global.keybinds.jump)){
				if (global.player.uabilities.jumps == 2)//first jump
					action = "running jump"
				else
					action = "running boost jump" //jumping additional times after first jump
			} else {
				action = "run"
			}
		} else { 
			if (keyboard_check(global.keybinds.jump)){
				action = "walk jump"
			} else { 
				action = "walk"
			}
		}
	} else {
		if (velocity.x != 0) {
			show_debug_message("Finger off key, bleeding momentum")
			if (abs(velocity.x) > _speed) {
				velocity.x = sign(global.player.image_direction)*max(sign(global.player.image_direction)*velocity.x - 0.3, 0)
				action = "run"
			} else {
				velocity.x = sign(global.player.image_direction)*max(sign(global.player.image_direction)*velocity.x - 0.5, 0)
				action = "walk"
			}
		} else {
			action = "idle"
		}
	}
} else { // makes it so input doesn't do anything if dead
	velocity.x = 0
}
// moving platform floor collision 
var _movingPlatform = instance_place(x, y+velocity.y, obj_moving_platform)

if (_movingPlatform != noone) {
	if y < _movingPlatform.y+16 {
		velocity.x = _movingPlatform.velocity.x + input_vx;
		velocity.y = _movingPlatform.velocity.y;
		global.player.uabilities.jumps = global.player.abilities.jumps
	}
	else {
		//platform under grabbing
		if can_grab_platform and (distance_to_point(_movingPlatform.x, _movingPlatform.y) < 30) {
			global.player.uabilities.jumps = global.player.abilities.jumps;
			var current_platform = _movingPlatform;
			x = current_platform.x;
			y = current_platform.y + 35;
			global.player.grabbing = true;
			velocity.x = _movingPlatform.velocity.x;
			velocity.y = _movingPlatform.velocity.y
			action = "idle"
		}
		else {
			global.player.grabbing = false;
			velocity.y = 6
		}
	}
}
else {
	global.player.grabbing = true;
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
	// check if player is dead, if so they just fall off
	if not global.dead {
		//lock the player on the ladder
		if can_grab_ladder {
			velocity.y = 0
			global.player.uabilities.jumps = global.player.abilities.jumps
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
}
else {
	can_grab_ladder = true
};

// jump
if (!global.dead && keyboard_check_pressed(global.keybinds.jump)){
	if global.player.uabilities.jumps > 0 {
		velocity.y = -player_cons.jump_height
		global.player.uabilities.jumps -= 1
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

//hazard collision
if place_meeting(x, y, obj_hazard) || place_meeting(x, y, obj_floor_hazard) {
	if not global.dead && !inv_frames {
		global.player.hp -= 1
		inv_frames = true
		alarm[1] = 100
		if (global.player.hp == 0) {
			global.dead = true
		}
	}
}

// apply velocity
if not (global.dead or global.times_up or instance_exists(obj_settings_menu)) {
	x += velocity.x;
	y += velocity.y
}



// EVERYTHING THAT IS NOT COLLISIONS RELATED

// player on the foreground
depth = -infinity

// death by falling in the void
if y > room_height+1000 {
	global.dead = true
}

// respawn
if global.dead {
	x = global.spawn_point.x
	y = global.spawn_point.y
}

print(global.player.uabilities.jumps)
