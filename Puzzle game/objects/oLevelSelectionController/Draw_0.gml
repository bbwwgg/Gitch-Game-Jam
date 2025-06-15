for (var _y = 0; _y < board_height; _y++) {
	for (var _x = 0; _x < board_width; _x++) {
		var val = ds_grid_get(current_map, _x, _y)

		if (val != -1) {
			if val.active = true{
				draw_sprite(sLevel, val.complete, x_offset + _x * tile_width, y_offset + _y * tile_height)
			
				var _level_num = string(val.level_number)
			
				if string_length(_level_num) < 2{
					_level_num = "0"+_level_num
				}
			
				draw_text( x_offset + _x * tile_width, y_offset + _y * tile_height,_level_num)
			}
		}
	}
}

if progress <= 1{
	progress += 0.05
	cursor_x = ease_overshoot(start_x, dest_x, progress);
	cursor_y = ease_overshoot(start_y, dest_y, progress);
	//show_message([cursor_x,dest_x])
	
	//show_message(progress)
}

draw_sprite(sCursor,0, x_offset + cursor_x, y_offset + cursor_y)