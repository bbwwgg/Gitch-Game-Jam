enum DIR{ 
	RIGHT,
	UP,
	LEFT,
	DOWN
}

function move(_inst, _dir){


	var _start_x = _inst.xTile
	var _start_y = _inst.yTile
	
	_inst.xPrev = _start_x
	_inst.yPrev = _start_y

	_inst.dir = _dir
	
	var _end_x = _start_x
	var _end_y = _start_y
	
    switch (_dir) {
        case DIR.RIGHT:
            _end_x ++;
            break;
        case DIR.UP:
            _end_y --;
            break;
        case DIR.LEFT:
            _end_x --;
            break;
        case DIR.DOWN:
			_end_y ++;
            break;
    }


	//Check if we are in bounds
	if (_end_x <0 or _end_y < 0) or
		(_end_x >= ds_grid_width(global.board) or (_end_y >= ds_grid_height(global.board))){
		return false
	}

	//Check collisions
	var _next_square = global.board[# _end_x, _end_y]
	
	if _next_square[MAP_DATA.SOLID] != noone{
		//Cannot move
		return false
	}
	
	/*
	if _next_square[MAP_DATA.ENTITY] != noone{
		var _inst_to_find = global.entity_key[_next_square[MAP_DATA.ENTITY] [0],_next_square[MAP_DATA.ENTITY][1]]
		
		if _inst_to_find == oPlayerController.entity_map[# _start_x, _start_y]{
			return false
		}
	}*/
	

	
	_inst.xTile = _end_x
	_inst.yTile = _end_y
	
	//if global.board[# xTile, yTile][MAP_DATA.TILE] != noone{
	//	_add_step_action(ACTION.MOVE, _inst)
	//}
	
	add_to_entity_map(_inst)
	
	return true
	
	/*
	//var _entities = oPlayerController.entity_map[# _end_x, _end_y];
	
	var _entity_priority = -1
	
	if _entities != 0{

		if false{// _next_square[MAP_DATA.ENTITY].interact_script = noone{
			if _next_square[MAP_DATA.ENTITY].stop = true{
				return false
			}
		}else{
			_entity_priority = _inst.entity_id
			//Is array
			if is_array(_entities){
				array_push(oPlayerController.entity_map[# _end_x, _end_y],_inst)
			}else{
				
				//Add this plus the entity we are interacting with
				oPlayerController.entity_map[# _end_x, _end_y] = [_inst,_next_square[MAP_DATA.ENTITY]]
			}
			
		}
	}else{
	
	
		if _next_square[MAP_DATA.TILE] = noone{	
			//If the map is empty
			_entity_priority = 0
		}
	
		if is_array(_entities){
			array_push(oPlayerController.entity_map[# _end_x, _end_y],_inst)
			_entity_priority = _inst.entity_id
		}else{
			oPlayerController.entity_map[# _end_x, _end_y] = [_inst]
		}

	}
	
 


	if _entity_priority >= 0 {
		
		var _conflict_info = {
			inst_calling :_inst.id,
			location : [_end_x,_end_y]
		}
		
		ds_priority_add(oPlayerController._conflict_list,_conflict_info,_entity_priority)

	}else{
		_inst.xTile = _end_x
		_inst.yTile = _end_y
		_inst.update_pos()
		return true
	}
	
	return false*/
}