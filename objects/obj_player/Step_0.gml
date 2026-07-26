// THE ORDER AT WICH COLLISIONS ARE CHECKED IS IMPORTANT
// make sure to know what you're doing before modifying it

// tilemap floor collision
if place_meeting(x, y+velocity.y+2, player_cons.level_tilemap) {
	velocity.y = 0
	global.player.uabilities.jump.number = global.player.abilities.jumps
}
// freefall
else {
	velocity.y = min(velocity.y+player_cons.gravity, player_cons.max_fall_speed)
	//velocity.x = sign(global.player.image_direction)*min(max(0, sign(global.player.image_direction)*velocity.x-0.5), 0)
};


// x velocity, for now only affected by keyboard inputs
input_vx = 0
if !stun {
	input_vx = keyboard_check(global.keybinds.right)*_speed-keyboard_check(global.keybinds.left)*_speed;
}
sprint_coeff = keyboard_check(global.keybinds.sprint)*1.5+1
if not global.dead {
	if input_vx != 0 { 
		global.player.image_direction = 1*sign(input_vx)
		velocity.x = sign(input_vx)*min(abs(velocity.x + 0.4*sign(input_vx)), abs(sprint_coeff*input_vx))
		if (abs(velocity.x) > _speed) { 
			velocity.x = sign(input_vx)*min(abs(velocity.x - 0.2*sign(input_vx)), abs(sprint_coeff*input_vx))
			if (keyboard_check(global.keybinds.jump)){
				if (global.player.uabilities.jump.number == global.player.abilities.jumps)//first jump
					action = ACTION.RUNNING_JUMP
				else
					action = ACTION.RUNNING_BOOST_JUMP //jumping additional times after first jump
			} else {
				action = ACTION.RUN
			}
		} else { 
			if (keyboard_check(global.keybinds.jump)){
				action = ACTION.WALK_JUMP
			} else { 
				action = ACTION.WALK
			}
		}
	} else {
		if (velocity.x != 0) {
			if (abs(velocity.x) > _speed) {
				velocity.x = sign(global.player.image_direction)*max(sign(global.player.image_direction)*velocity.x - 0.5, 0)
				action = ACTION.RUN
			} else {
				velocity.x = sign(global.player.image_direction)*max(sign(global.player.image_direction)*velocity.x - 0.8, 0)
				action = ACTION.WALK
			}
		} else {
			action = ACTION.IDLE
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
		global.player.uabilities.jump.number = global.player.abilities.jumps
	}
	else {
		//platform under grabbing
		if can_grab_platform and (distance_to_point(_movingPlatform.x, _movingPlatform.y) < 60) {
			grabable = true
			if keyboard_check(global.keybinds.interact) {
				grabable = false
				global.player.grabbing = true
			}
			if global.player.grabbing == true {
				global.player.uabilities.jump.number = global.player.abilities.jumps;
				var current_platform = _movingPlatform;
				x = current_platform.x;
				y = current_platform.y + 35;
				velocity.x = _movingPlatform.velocity.x;
				velocity.y = _movingPlatform.velocity.y;
				grabable = false
				action = ACTION.GRAB_OVERHEAD
				if keyboard_check_pressed(global.keybinds.jump) || keyboard_check_pressed(global.keybinds.interact){
					global.player.grabbing = false
				}
			}
		}
		else {
			grabable = false
			velocity.y = 6
		}
	}
}
else {
	can_grab_platform = true
	grabable = false
};

// right wall collision
if place_meeting(x+velocity.x, y-2, player_cons.level_tilemap) {
	//making it impossible to move further right instead of locking th player in place
	velocity.x = -keyboard_check(global.keybinds.left)*_speed; 
};

//left wall collision
if place_meeting(x+velocity.x, y-2, player_cons.level_tilemap) {
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
			global.player.uabilities.jump.number = global.player.abilities.jumps
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
if keyboard_check(global.keybinds.jump) && !stun {
	if global.player.uabilities.jump.timer > 0 {
		global.player.uabilities.jump.timer += 1
		velocity.y = -player_cons.jump_timer_height
		if global.player.uabilities.jump.timer > player_cons.jump_max_timer {
			global.player.uabilities.jump.timer = 0
		}
	}
	else if global.player.uabilities.jump.number > 0 {
		velocity.y = -player_cons.jump_height
		global.player.uabilities.jump.number -= 1
		global.player.uabilities.jump.timer = 1
		if place_meeting(x, y, obj_ladder) {
			can_grab_ladder = false
		}
		if (_movingPlatform != noone) and (y >= _movingPlatform.y) {
			can_grab_platform = false
			velocity.y = 6
		}
	}
};
if keyboard_check_released(global.keybinds.jump) {
	global.player.uabilities.jump.timer = 0
}

//ceiling collision
if place_meeting(x, y+velocity.y-2, player_cons.level_tilemap) {
	velocity.y = 0
};

//hazard collision
if place_meeting(x, y, obj_hazard) || place_meeting(x, y, obj_floor_hazard) {
	if not global.dead && !inv_frames {
		global.player.hp -= 1
		inv_frames = true
		hurt_frames = true
		stun = true
		alarm[1] = 100
		alarm[2] = 20
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
	global.player.hp = 0
	global.dead = true
}

//damage stun
if stun {
	action = ACTION.INJURY
}

// dead, waiting for respawn
if global.dead {
	action = ACTION.DEAD
}