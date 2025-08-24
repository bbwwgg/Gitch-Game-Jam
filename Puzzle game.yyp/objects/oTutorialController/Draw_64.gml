if draw{
	if !is_empty(){
			
		draw_sprite_ext(sBook,image_index,book_x,book_y,scale,scale,image_angle,c_white,book_alpha)


		draw_sprite_ext(sTutorialReminder,page,tutorial_x,tutorial_y,tutorial_scale,tutorial_scale,tutorial_angle,c_white,image_alpha)
	
		if state != HELP_STATE.HIDDEN and state != HELP_STATE.ALERT{
			
			var _offset = sin(arrow_time*0.1)*4
			arrow_time ++
			
			if (page < array_length(unlocked_tips)) {
				var new_index = page + 1
				while (new_index < array_length(unlocked_tips)) {
					if (unlocked_tips[new_index]) {
						draw_sprite_ext(sArrow,0,tutorial_x+tutorial_w*0.53+_offset,tutorial_y,tutorial_scale,tutorial_scale,0,c_white,image_alpha)
						break
					}
					new_index ++;
				}
			}
			
			
			if page > 0 {
				draw_sprite_ext(sArrow,1,tutorial_x-tutorial_w*0.53-_offset,tutorial_y,tutorial_scale,tutorial_scale,0,c_white,image_alpha)
			}
		}
			
	}
}