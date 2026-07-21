/// @desc Reset Layer

//If the object is persistent (player, prop?), we need to put it back on the
//sort_begin layer or there could be an error on room change
if ( persistent ) {
	layer = layer_get_id( "sort_begin" );
}
