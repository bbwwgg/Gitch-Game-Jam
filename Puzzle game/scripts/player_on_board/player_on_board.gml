function player_on_board(){
	if !player_input{
		return
	}

	if  keyboard_check_pressed(ord("Z")){
		oBoardController.undo_board_state()
	}

	if  keyboard_check_pressed(ord("R")){
		oBoardController.reset_board()
		player_input = false
		return
	}
	
	if  keyboard_check_pressed((vk_escape)){
		transition(level_select)
	}

	//Check if any players are active
	for(var i = 0; i < player_count; i ++){
		var _player = player_instance[i]
		if player_instance[i].interactable{
			break
		}
	}
	if i = player_count{
		show_debug_message("No more players")
		exit	
	}



	var h = keyboard_check_pressed(ord("D"))-keyboard_check_pressed(ord("A")) 
	var v = keyboard_check_pressed(ord("S"))-keyboard_check_pressed(ord("W")) 

	var dir = -1


	if (h != 0) {
	    dir = (h == 1) ? 0 : 2; // 0 = right, 2 = left
	}
	else if (v != 0) {
	    dir = (v == -1) ? 1 : 3; // 1 = up, 3 = down
	}


	if dir != -1{
		oBoardController.save_board_state()
		for(current_player_index = 0; current_player_index< player_count; current_player_index++){
			var _player = player_instance[current_player_index]
			if _player.interactable{
				var _prev_dir = _player.dir 
				_player.dir = dir
			
				var _prev_tile = [_player.xTile, _player.yTile]
			
			
				if move(_player, dir) {
	
					var _wisp_trail = wisp_follow[current_player_index];

					if array_length(_wisp_trail) != 0 {
						var _prev_pos = _prev_tile; // Start with the player's previous position				
					
						for (var i = 0; i < array_length(_wisp_trail); i++) {
							var _cur_wisp = _wisp_trail[i];
			
							if _cur_wisp.delay {
								_cur_wisp.delay = false;
								i++
								continue; // Skip movement this turn
							}

							// Save current wisp position before moving
							var _current_pos = [_cur_wisp.xTile, _cur_wisp.yTile];
							var _cur_dir = _cur_wisp.dir
							// Only update if position is different
							if !array_equals(_prev_pos, _current_pos) {
								_cur_wisp.xTile = _prev_pos[0];
								_cur_wisp.yTile = _prev_pos[1];
								_cur_wisp.dir = _prev_dir
								_cur_wisp.update_pos();
							}
			
							// Set previous position for next wisp in line
							_prev_pos = _current_pos;
							_prev_dir = _cur_dir
						}
					}
				

			
					with _player{
						var _dustx = lengthdir_x(TILE_SIZE,dir*90)
						var _dusty = lengthdir_y(TILE_SIZE,dir*90)
					
						with instance_create_depth(x-_dustx+TILE_SIZE/2,y-_dusty+TILE_SIZE/2,-y-_dusty,oEffect){
							sprite_index = sDust1	
							hsp = -_dusty*0.01
							vsp = -_dustx*0.01
						}
					}
				}
			}
		}
	}
}