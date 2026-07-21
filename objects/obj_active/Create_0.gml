/// @desc Init Active Objects

//Active objects are any object that moves so needs its layers updated
//in this template, they dont get deactivated when outside the view
//they instead switch off thier draw event to save cycles when you
//cant see them, in the case of the AI, we could also slow down thier 
//AI alarm[10] to fire less often if we wanted as well.

//Active Objs: NPC, Animals, Player, Troops, Workers etc.

image_speed = 0;

alarm[11] = room_speed * 2;

//Assign my layer in grid
updateLayers();