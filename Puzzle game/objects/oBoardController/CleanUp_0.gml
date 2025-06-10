while array_length(global.board_state) > 0{
	ds_grid_destroy(array_pop(global.board_state))
	//var _snapshot = array_pop(global.board_state)
	//ds_grid_destroy(_snapshot.board)
	//ds_grid_destroy(_snapshot.entities)

}


ds_grid_destroy(global.board)