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
	
	while true{
		//Conflict
		while ds_priority_size(_conflict_list) > 0{
		
			var _conflict_info = ds_priority_delete_min(_conflict_list)
			var _entities_involved = entity_map[# _conflict_info.location[0],_conflict_info.location[1]]
			
			//Check who initiated, if both are moving? do something idk
			//TODO change this so that it takes from the database instead (for consistancy)
			var _entity_priority = ds_priority_create()
			var _interactable_entities = []
					
			for (var i = 0; i < array_length(_entities_involved); i++) {
				var _e = _entities_involved[i];
                if (_e.xTile != _e.xPrev || _e.yTile != _e.yPrev) {
					ds_priority_add(_entity_priority,_e,_e.entity_id)
			    }else{
					array_push(_interactable_entities,_e)
				}
			}
				
			array_sort(_interactable_entities, function( a, b){
				return a.entity_id - b.entity_id;	
			
			})
				
				while !ds_priority_empty(_entity_priority){
					var _e = ds_priority_delete_min(_entity_priority)
					
					var _can_move = false
					
					
					for(var i = 0; i < array_length(_interactable_entities); i ++){
						var _interaction_entity = _interactable_entities[i]
						
						if _interaction_entity.interact_script != noone{
							//script_execute(_interaction_entity.interact_script)
						}
					}
					
					if !_can_move{
						_e.xTile = xPrev
						_e.yTile = yPrev
					}
					
				}
				
				
				ds_priority_destroy(_entity_priority)
		
			
		}
		
		
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
		

		//moving to square with a stationary object
		//
		
		//Resolve any conflicts
		
	
	
		
		
		break
		
		
		
	}
	
	

	ds_priority_destroy(_conflict_list)
	
	

	
}