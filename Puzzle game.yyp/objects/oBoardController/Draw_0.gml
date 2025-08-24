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
			
			
			var _entity = global.board[# j, i][MAP_DATA.ENTITY]
			
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
		
		draw_sprite_ext(sGrass_tile,global.board[# j, i][MAP_DATA.TILE],_x,_y,1,1,0,c_white,_alpha)
		
		var _obj = global.board[# j, i][MAP_DATA.OBJECT]

		if _obj != noone{
			draw_sprite_ext(sHedge,_obj,_x,_y,1,1,0,c_white,_alpha)
		}	
	}
}