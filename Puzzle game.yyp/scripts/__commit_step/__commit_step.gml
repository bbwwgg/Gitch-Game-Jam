function __commit_step(){
	
	oBoardController.save_board_state()
	
	//Preform a step
	ds_grid_clear(entity_map,0)
	
	//List of any interaction/movement overlaps
	_conflict_list = ds_priority_create()
	
	
	//Create a new blank array to add movement wishes to
	_update_list = [[]]
		
	//Make desired points
	with(pEntity){		
		if step_script != noone{ 
			script_execute(step_script)
		}else{
			//If we are not preforming an action we are stationary
			add_to_entity_map(self.id)
		}
	}
	
	

	//Conflict
	while ds_priority_size(_conflict_list) > 0{
		
		var _conflict_info = ds_priority_delete_min(_conflict_list)
		
		var _xTile = _conflict_info[0]
		var _yTile = _conflict_info[1]
		
		var _entities_involved = entity_map[# _xTile, _yTile]

		var _real_tile = global.board[# _xTile, _yTile]
		
		var _square_taken = false
		var _new_square = []
		var _entities_on_square = 0
		
		var _is_void = _real_tile[MAP_DATA.TILE] == noone
	
		for (var i = 0; i < array_length(_entities_involved); i++) {
			
			var _e = _entities_involved[i]
			var _can_take = true

			//If there is a void here, someone has to go and fill it first
			if _is_void{
				_is_void = false
				_add_step_action(ACTION.MOVE, _e)
				_add_step_action(ACTION.FALL, _e)
				
				continue
			}
			
			
			//Check if any of the entites on this square can be interacted with
			for(var j = 0; j < _entities_on_square; j++){
				var _interact = _new_square[j]
				
				if _interact.stop = true{
					_can_take = false
				}	
			}
				
			if _can_take{
				array_push(_new_square,_e)
				_entities_on_square ++
			}else{
				_e.xTile = _e.xPrev
				_e.yTile = _e.yPrev
				add_to_entity_map(_e)
			}
						
		}
		
		
								
	}
	
	

	
	//Preform movement, and interactions
	for(var i = 0; i < array_length(_update_list); i ++){
		for(var j = 0; j < array_length(_update_list[i]); j ++){

			var _cur = _update_list[i][j]
			var _inst = _cur[0]
			var _action = _cur[1]
			if !instance_exists(_inst) continue
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
	
	ds_priority_destroy(_conflict_list)
	
	

	
}