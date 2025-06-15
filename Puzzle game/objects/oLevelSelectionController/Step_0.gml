var h = keyboard_check_pressed(ord("D"))-keyboard_check_pressed(ord("A")) 
var v = keyboard_check_pressed(ord("S"))-keyboard_check_pressed(ord("W")) 

if h != 0 or v != 0{
	
	var _new_xpos = cursor_pos_x + h
	var _new_ypos = cursor_pos_y + v
	
	if _new_xpos < 0 || _new_xpos >= board_width{ return }
	if _new_ypos < 0 || _new_ypos >= board_height{ return }
	
	if current_map[# _new_xpos, _new_ypos] != -1{
		if current_map[# _new_xpos, _new_ypos].active = 0{
			cursor_pos_x = _new_xpos
			cursor_pos_y = _new_ypos
			
			start_x = cursor_x
			start_y = cursor_y
			dest_x = cursor_pos_x*tile_width
			dest_y = cursor_pos_y*tile_height
			
			progress = 0
		}
	}
}


if keyboard_check_pressed(vk_space){
	transition(level_lock1)	
}

