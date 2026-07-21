/// @desc Destroy Layers

for ( var i = 0; i < global.GRID_H; i++ ) {

	layer_destroy( global.layerGrid[# 0, i] );
	
}

if ( ds_exists(global.layerGrid, ds_type_grid ) ) {
	
	ds_grid_destroy( global.layerGrid );	
	
}