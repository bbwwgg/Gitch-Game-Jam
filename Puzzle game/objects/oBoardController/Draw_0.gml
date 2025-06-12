var new_y_offset = 0

switch state{
	case LEVEL_STATE.ENTER:
		if time <= time_per_segment{		
			time ++
		}else{
			state = LEVEL_STATE.PLAYING	
		}
	break
	
}


//Render the board
for(var i = 0; i < grid_height; i ++){
	for(var j = 0; j < grid_width; j ++){
		
		if state = LEVEL_STATE.ENTER{
			
			if time <= time_per_segment{
				new_y_offset = ease_in(time,16,-16,time_per_segment)
			}
		}
		var _x = base_xOffset + square_size*j
		var _y = base_yOffset + square_size*i + new_y_offset
		
		draw_sprite(sGrass_tile,global.board[# j, i][MAP_DATA.TILE],_x,_y)
		if global.board[# j, i][MAP_DATA.OBJECT] != noone{
			draw_sprite(sWall,global.board[# j, i][MAP_DATA.TILE],_x,_y)
		}
		//if global.board[# j, i][MAP_DATA.ENTITY] != noone{
		//	draw_text(_x,_y,global.board[# j, i][MAP_DATA.ENTITY])
		//}
		
	}
}