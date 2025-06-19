function Player_selecting_level(){
var h = sign(keyboard_check_pressed(ord("D"))-keyboard_check_pressed(ord("A"))+keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))
var v = sign(keyboard_check_pressed(ord("S"))-keyboard_check_pressed(ord("W"))+keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up))


if h != 0 or v != 0{
	
	var _new_xpos = cursor_pos_x + h
	var _new_ypos = cursor_pos_y + v
	
	if _new_xpos < 0 || _new_xpos >= board_width{ return }
	if _new_ypos < 0 || _new_ypos >= board_height{ return }
	
	if current_map[# _new_xpos, _new_ypos] != -1{
		if current_map[# _new_xpos, _new_ypos].active = true{
			if struct_exists(current_map[# _new_xpos, _new_ypos], "unlock_requirement" ){
				lock_x = _new_xpos
				lock_y = _new_ypos
				if current_map[# _new_xpos, _new_ypos].unlock_requirement <= wisps_collected or DEBUG_MODE{
					levels_to_unlock = active_surrounding(current_map,_new_xpos,_new_ypos)

					time = 0
					state = unlock_blocker
					draw_lock = false
				}else{
					lock_num = current_map[# _new_xpos, _new_ypos].unlock_requirement 
					draw_lock = true
					lock_fade = 0
					lock_progress = 0
				}
				
			}else{
				draw_lock = false
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
}


if keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter){
	
	
	with oGameController{
		for(var i=0; i < array_length(level_selecton); i ++){
			var _cur_level = level_selecton[i]
	
			if _cur_level.room_index = room{
				_cur_level.saved_cursor_pos = [other.cursor_pos_x,other.cursor_pos_y]


				break
			}
		}
		completed_level = false
	}
	
	if struct_exists(current_map[# cursor_pos_x, cursor_pos_y], "world_dest"){
		
		var _dest = current_map[# cursor_pos_x, cursor_pos_y].world_dest
	
		if _dest = noone {_dest = level_select}

		transition(_dest)
		
		return
	}
	
	if !struct_exists(current_map[# cursor_pos_x, cursor_pos_y], "dest") { return }
	

	
	var _dest = current_map[# cursor_pos_x, cursor_pos_y].dest
	
	if _dest = noone {_dest = level_lock1}

	transition(_dest)	
}


}