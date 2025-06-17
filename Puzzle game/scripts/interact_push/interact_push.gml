function interact_push() {
	
	if interacting_inst.dir != image_index{
		return false
	}

	
	var _luck;

	// Prevent re-entry
	if current_time = entity_var {
		return;
	}
	entity_var = current_time;

	// Get luck value
	if interacting_inst.entity_id == ENITITY.LUCK_BLOCK {
		_luck = interacting_inst.entity_var;
		if _luck == -1 return;

		if is_array(_luck) {
			_luck = _luck[0];
		}
	} else {
		_luck = global.luck_system.use();
	}

	//If there is a block here move it first
	var _cur_ent = global.board[# xTile, yTile][MAP_DATA.ENTITY]
	if array_length(_cur_ent) > 1
	for(var i = 0; i <  array_length(_cur_ent); ++i){
		
		if _cur_ent[i] = id{
			continue	
		}
		
		if _cur_ent[i].moveable{
			if !move(_cur_ent[i],interacting_inst.dir){
				return false
			}
		}else{
			return false	
		}
	}


	//Push the instance
	var _prev_xTile = interacting_inst.xTile
	var _prev_yTile = interacting_inst.yTile
	
	var _prev_ent_count = array_length(global.board[# _prev_xTile, _prev_yTile][MAP_DATA.ENTITY])
	
	if _prev_ent_count = 1{
		global.board[# _prev_xTile, _prev_yTile][MAP_DATA.ENTITY] = noone
	}else{
		for(var i = 0; i < _prev_ent_count; i ++){
			if global.board[# _prev_xTile, _prev_yTile][MAP_DATA.ENTITY][i] = interacting_inst{
				array_delete(global.board[# _prev_xTile, _prev_yTile][MAP_DATA.ENTITY],i,1)
			}
		}
	}

	interacting_inst.xTile = xTile;
	interacting_inst.yTile = yTile;

	interacting_inst.update_pos()

	global.board[# xTile, yTile][MAP_DATA.ENTITY][array_length(global.board[# xTile, yTile][MAP_DATA.ENTITY])] = interacting_inst


	var dir =  (4 +image_index + _luck mod 2 * -2 + 1) mod 4
	
	//show_message(dir)
	return move(interacting_inst, dir);
}