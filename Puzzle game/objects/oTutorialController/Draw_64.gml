if draw{
	
	if !is_empty(){
			
		draw_sprite_ext(sBook,image_index,width,VIEW_HEIGHT-height/2,scale,scale,image_angle,c_white,1)

		draw_sprite_ext(sTutorialReminder,page,tutorial_x,tutorial_y,tutorial_scale,tutorial_scale,0,c_white,image_alpha)
	}
}