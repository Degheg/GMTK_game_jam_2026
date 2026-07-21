/// @desc Init Static Objects

//Static objects are just that, static. They dont move so will
//never need thier layers updated again, nor would they be
//persistent objects. All Static objects are deactivated when they are
//outside the view more than 2 seconds (changeable).

//Static Objs: Decorations, Buildings, Plants\Trees

//Random Starting sprite for terrain stuff
image_index = choose(0, 0, 0, 1, 1, 1, 2, 3);
image_speed = 0; // Change at animated Inst, like campfire

alarm[11] = room_speed * 2; // 2 seconds

//Assign my layer in grid
updateLayers();