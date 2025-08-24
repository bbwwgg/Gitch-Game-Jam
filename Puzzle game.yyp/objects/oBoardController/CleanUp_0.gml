while array_length(global.board_state) > 0{
	ds_grid_destroy(array_pop(global.board_state).board)
}


ds_grid_destroy(global.board)