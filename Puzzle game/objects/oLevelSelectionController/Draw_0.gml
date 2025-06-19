draw_set_valign(fa_middle)
draw_set_halign(fa_center)
draw_set_font(fntMain)

for (var _y = 0; _y < board_height; _y++) {
	for (var _x = 0; _x < board_width; _x++) {
		var val = ds_grid_get(current_map, _x, _y)

		if (val != -1) {		
			if val.active = true{
				if struct_exists(val, "level_number" ){
					draw_sprite(sLevel, val.complete, x_offset + _x * tile_width, y_offset + _y * tile_height)
			
				
					var _level_num = val.level_number
			
					if !is_string(_level_num){
						if string_length(_level_num) < 2{
							_level_num = "0"+string(_level_num)
						}
					}
			
					draw_text( x_offset + _x * tile_width + tile_width/2, y_offset + 2+ _y * tile_height+ tile_height/2,_level_num)
				}else{
					if struct_exists(val, "unlock_requirement" ){
						draw_sprite(sLevelBlocker, 0, x_offset + _x * tile_width, y_offset + _y * tile_height)	
					}else{
						if struct_exists(val, "world_dest" ){
							draw_sprite(sLevelNextWorld, 0, x_offset + _x * tile_width, y_offset + _y * tile_height)					
						}else{
							draw_sprite(sLevelPath, 0, x_offset + _x * tile_width, y_offset + _y * tile_height)					
						}
					}
				}
			}
		}
	}
}

if progress <= 1{
	progress += 0.05
	cursor_x = ease_overshoot(start_x, dest_x, progress);
	cursor_y = ease_overshoot(start_y, dest_y, progress);
}

if draw_lock {
	var _x = x_offset + lock_x * tile_width;
	var _y = y_offset + lock_y * tile_height;

	// Angle swing using damped sine
	if (lock_progress <= 1) {
		if lock_progress <= 0.35{
			lock_fade = ease_in(lock_progress, 0, 1, 0.35);
		}else{
			lock_fade = 1
		}
		
		// Damped oscillation
		var swing_amplitude = 45
		var damping = 1
		lock_angle = swing_amplitude * sin(lock_progress * pi * 2) * (1 - lock_progress) * exp(-lock_progress * damping);

		lock_progress += 0.02;
	} else {
		lock_angle = 0;
	}

	draw_sprite_ext(sLevelBlockerAlert, 0, _x+16, _y, 1, 1, lock_angle, c_white, lock_fade);
	draw_set_alpha(lock_fade)
	draw_text_transformed(_x + 10, _y+2, lock_num,1,1,lock_angle);
	draw_set_alpha(1)
}

draw_sprite(sCursor,0, x_offset + cursor_x, y_offset + cursor_y)

