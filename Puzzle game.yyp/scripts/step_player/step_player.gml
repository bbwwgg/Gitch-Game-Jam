function step_player(){
	if oPlayerController.dir != -1{

		move(self, oPlayerController.dir)
		add_to_entity_map(self)
		/*if move(self, dir) {
	
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
				
					//play_sfx(sfxWalk)
			
					with _player{
						var _dustx = lengthdir_x(TILE_SIZE,dir*90)
						var _dusty = lengthdir_y(TILE_SIZE,dir*90)
					
						with instance_create_depth(x-_dustx+TILE_SIZE/2,y-_dusty+TILE_SIZE/2,-y-_dusty,oEffect){
							sprite_index = sDust1	
							hsp = -_dustx*0.01
							vsp = -_dusty*0.01
						}
					}
				}*/
	}
}
	
