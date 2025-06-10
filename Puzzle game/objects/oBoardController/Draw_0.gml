//Render the board
for(var i = 0; i < grid_height; i ++){
	for(var j = 0; j < grid_width; j ++){
		
		var _x = base_xOffset + square_size*j
		var _y = base_yOffset + square_size*i
		
		draw_sprite(sGrass_tile,global.board[# j, i][MAP_DATA.TILE],_x,_y)
		
		if global.board[# j, i][MAP_DATA.ENTITY] != noone{
			//show_debug_message(global.board[# j, i][MAP_DATA.ENTITY])
		}
		
	}
}