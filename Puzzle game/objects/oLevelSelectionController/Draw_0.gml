for (var _y = 0; _y < board_height; _y++) {
	for (var _x = 0; _x < board_width; _x++) {
		var val = ds_grid_get(current_map, _x, _y)

		if (val != -1) {
			draw_sprite(sLevel, 0, x_offset + _x * tile_width, y_offset + _y * tile_height);
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