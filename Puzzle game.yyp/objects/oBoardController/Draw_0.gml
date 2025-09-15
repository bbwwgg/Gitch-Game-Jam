var new_y_offset = 0

switch state{
	case LEVEL_STATE.ENTER:
		if time <= time_per_segment + grid_height + grid_width{		
			time ++
		}else{
			state = LEVEL_STATE.PLAYING	
		}
	break
	
}


//Render the board
for(var i = 0; i < grid_height; i ++){
	for(var j = 0; j < grid_width; j ++){
		var _alpha = 1
		var _cur_board = global.board[# j, i]
		
		if state = LEVEL_STATE.ENTER{
			var _cur_time = time - (grid_height - i) - (grid_width - j )
			if _cur_time >= 0{
				if _cur_time <= time_per_segment{ 
					new_y_offset = ease_out(_cur_time,16,-16,time_per_segment)		
					_alpha = ease_out(_cur_time,0,1,time_per_segment)
				}
				

		
			}else{
				_alpha = 0
			}
			
			
			var _entity = _cur_board[MAP_DATA.ENTITY]
			
			if _entity != noone{
				for(var c = 0; c < array_length(_entity); c ++){
					with _entity[c]{
						image_alpha = _alpha
						y_offset = new_y_offset
					}
				}
			}
		}
		
		var _x = base_xOffset + square_size*j
		var _y = base_yOffset + square_size*i + new_y_offset
		
		if _cur_board[MAP_DATA.TILE] != noone{
			draw_sprite_ext(_cur_board[MAP_DATA.TILE][0],_cur_board[MAP_DATA.TILE][1],_x,_y,1,1,0,c_white,_alpha)
		}
		var _solid = _cur_board[MAP_DATA.SOLID]

		if _solid != noone{
			draw_sprite_ext(_solid[0],_solid[1],_x,_y,1,1,0,c_white,_alpha)
		}	
	}
}