/// @desc Simple Layer Control

//Only updates the layer of the active object if we have to

//We update our layer only if we moved vertically
//and are visible
if ( visible && y != yprevious ) {
	
	//If i am inside the room vertically
	if ( y >= 0 && y < room_height ) {
		
		//Assign my layer in grid
		updateLayers();
		
	}
		
}
