var h = sign(keyboard_check_pressed(ord("D"))-keyboard_check_pressed(ord("A"))+keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))
var v = sign(keyboard_check_pressed(ord("S"))-keyboard_check_pressed(ord("W"))+keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up))


if h != 0 or v != 0{
	
	var _new_xpos = cursor_pos_x + h
	var _new_ypos = cursor_pos_y + v
	
	if _new_xpos < 0 || _new_xpos >= board_width{ return }
	if _new_ypos < 0 || _new_ypos >= board_height{ return }
	
	if current_map[# _new_xpos, _new_ypos] != -1{
		if current_map[# _new_xpos, _new_ypos].active = true{
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


if keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter){
	oGameController.saved_cursor_pos = [cursor_pos_x,cursor_pos_y]
	oGameController.completed_level = false
	
	var _dest = current_map[# cursor_pos_x, cursor_pos_y].dest
	
	if _dest = noone {_dest = level_lock1}

	transition(_dest)	
}

