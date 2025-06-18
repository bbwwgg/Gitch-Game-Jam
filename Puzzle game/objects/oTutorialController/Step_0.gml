switch (state){
	case HELP_STATE.IDLE:
		
		var h = sign(keyboard_check_pressed(ord("D"))-keyboard_check_pressed(ord("A"))+keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))
		if (h != 0) {
			var max_page = array_length(unlocked_tips) - 1;
			var new_index = page + h;

			while (new_index >= 0 && new_index <= max_page) {
				if (unlocked_tips[new_index]) {
					page = new_index;
					break;
				}
				new_index += h;
			}
		}
		
		if keyboard_check_pressed(ord("H")) or keyboard_check_pressed(vk_escape){
			activate()			
		}
		
		if mouse_check_button(mb_left){
			var _mousex = device_mouse_x_to_gui(0)
			var _mousey = device_mouse_y_to_gui(0)

			if !point_in_rectangle(_mousex,_mousey,tutorial_x-tutorial_w/2,tutorial_y-tutorial_h/2,tutorial_x+tutorial_w/2,tutorial_y+tutorial_h/2){
	
				activate()
			}
		}
	
	break
	
	case HELP_STATE.ALERT:
		wobble_time += 0.15;
		angle = sin(wobble_time) * exp(-wobble_time * 0.12) * 60

		if wobble_time > 25{
			wobble_time = 0
		}

		image_angle = angle
	break
	case HELP_STATE.ENTER:
		tutorial_x = ease_out(move_time, x_start, x_to-x_start, time_to)
		tutorial_y = ease_out(move_time, y_start, y_to-y_start, time_to)
		
		image_alpha = ease_out(move_time,0,1,time_to)
		
		if time_to < move_time{
			switch_state(HELP_STATE.IDLE)	
		}
		

		move_time ++
		
	break
	
	case HELP_STATE.EXIT:
		tutorial_x = ease_in(move_time, x_start, x_to-x_start, time_to)
		tutorial_y = ease_in(move_time, y_start, y_to-y_start, time_to)
		image_alpha = ease_out(move_time,1,-1,time_to)
		
		if time_to < move_time{
			switch_state(HELP_STATE.HIDDEN)	
		}
		
		if move_time = round(move_time/2){
			if instance_exists(oPlayerController){
				oPlayerController.player_input = true
			}
		}
		
		move_time ++
		
	break

}