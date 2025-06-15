enum DIR{ 
	RIGHT,
	UP,
	LEFT,
	DOWN
}

function move(_inst, _dir){

	var _start_x = _inst.xTile
	var _start_y = _inst.yTile
	//show_message([_start_x,_start_y])
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


	if (_end_x <0 or _end_y < 0) or
		(_end_x >= ds_grid_width(global.board) or (_end_y >= ds_grid_height(global.board))){
		return false
	}
	
	
	//Check collisions
	
	var _next_square = global.board[# _end_x, _end_y]
	var _next_ent = _next_square[MAP_DATA.ENTITY]
	
	var _next_ent_count = array_length(_next_square[MAP_DATA.ENTITY])
	var _prev_ent_count = array_length(global.board[# _start_x, _start_y][MAP_DATA.ENTITY])
	
	
	if _next_square[MAP_DATA.OBJECT] != noone{
		//Cannot move
		return false
	}
	

	if _next_ent != noone{
		for(var i = 0; i < _next_ent_count; ++i){
			
			var _cur_next_ent = _next_ent[i]
			
			if _cur_next_ent.moveable{
				if move(_cur_next_ent,_dir){
					var _updated_next_square = global.board[# _end_x, _end_y]
					_next_ent = _updated_next_square[MAP_DATA.ENTITY]
					_next_ent_count = array_length(_updated_next_square[MAP_DATA.ENTITY])
					if _next_ent != noone{
						continue
					}else{
						break	
					}
				}else{
					return false	
				}
			}
			
			if _inst.entity_id = ENITITY.PLAYER{
				

				
				if _cur_next_ent.interactable{
					_cur_next_ent.interact()
				}
				
				if _cur_next_ent.stop and _cur_next_ent.entity_id != ENITITY.FLAG{
					return false
				}
				

			}else{
				if _cur_next_ent.stop{
					return false	
				}
			}
		}	
	}
	
	if _next_square[MAP_DATA.TILE] = 0{
		//Check if there is an object floating here
		if _next_ent = noone{
			_inst.fall()

		}else{
			for(var i = 0; i < _next_ent_count; ++i){
				if !_next_ent[i].sunk{
					_inst.fall()
					break
				}
			}	
		}
	}
	

	
	_inst.xTile = _end_x
	_inst.yTile = _end_y
	
	

	if _next_ent = noone{
		global.board[# _end_x, _end_y][MAP_DATA.ENTITY] = [_inst]
	}else{
		global.board[# _end_x, _end_y][MAP_DATA.ENTITY][array_length(_next_ent)] = _inst
	}

	

	if _prev_ent_count = 1{
		global.board[# _start_x, _start_y][MAP_DATA.ENTITY] = noone
	}else{
		for(var i = 0; i < _prev_ent_count; i ++){
			if global.board[# _start_x, _start_y][MAP_DATA.ENTITY][i] = _inst{
				array_delete(global.board[# _start_x, _start_y][MAP_DATA.ENTITY],i,1)
			}
		}
	}
	
	_inst.update_pos()

	return true
}