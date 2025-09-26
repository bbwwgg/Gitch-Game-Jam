function __commit_step(){
	
	oBoardController.save_board_state()
	
	//Preform a step
	ds_grid_clear(entity_map,0)
	
	_conflict_list = ds_priority_create()
	
	//Make desired points
	with(pEntity){
		if step_script != noone{ 
			script_execute(step_script)
		}
	}
	
	var _board_updated = false
	
	while ds_priority_size(_conflict_list) > 0{
		
		_board_updated = true
		
		var _conflict_info = ds_priority_delete_min(_conflict_list)
		
		var _entities_involved = entity_map[# _conflict_info.location[0],_conflict_info.location[1]]
		
		//By default lower priority take the square
		
		if array_length(_entities_involved) == 1{
			//we are falling
			if global.board[# _conflict_info.location[0],_conflict_info.location[1]][MAP_DATA.TILE] == noone{
				_entities_involved[0].xTile = _conflict_info.location[0]
				_entities_involved[0].yTile = _conflict_info.location[1]
				_entities_involved[0].fall()
			
			}
		}
		
		//Resolve any conflicts
		
	}
	
	ds_priority_destroy(_conflict_list)
	
	
}