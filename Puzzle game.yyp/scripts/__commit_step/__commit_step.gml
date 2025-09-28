function __commit_step(){
	
	oBoardController.save_board_state()
	
	//Preform a step
	ds_grid_clear(entity_map,0)
	
	//List of any interaction/movement overlaps
	_conflict_list = ds_priority_create()
	
	
	//Create a new blank array to add movement wishes to
	_update_list = [ [] ]
	
	//Make desired points
	with(pEntity){
		
		
		if step_script != noone{ 
			update_step = 0
			script_execute(step_script)
		}else{
			//If we are not preforming an action we are stationary
			add_to_entity_map(self)
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
				_add_step_action(ACTION.FALL,_entities_involved[0])
			}
		}else{
			//Check who initiated, if both are moving? do something idk
			
			
		}
		
		//Resolve any conflicts
		
	}
	
	ds_priority_destroy(_conflict_list)
	
	
	//Preform movement, and interactions
	for(var i = 0; i < array_length(_update_list); i ++){
		for(var j = 0; j < array_length(_update_list[i]); j ++){

			var _cur = _update_list[i][j]
			var _inst = _cur[0]
			var _action = _cur[1]
			
			switch (_action){
				case ACTION.MOVE:
					_inst.update_pos()
				break
				case ACTION.FALL:
					_inst.fall()
				break
			}
			
			
		}
	}
	
}