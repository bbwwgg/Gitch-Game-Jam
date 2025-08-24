if sunk{
	y_offset = round(0.75*sin(time*0.05)+2)	
	time ++
}else{
	y_offset = 0	
}




switch(entity_id){

	case ENITITY.LUCK_BLOCK:


		draw_sprite_ext(sprite_index,image_index,x,y+y_offset,1,1,0,c_white,image_alpha)
		var _string_height = "";
		if !sunk and entity_var != -1{
			
			var _draw_number = entity_var
			
			if image_index = 0{
				draw_set_color(#2E222F)
			}else{
				draw_set_color(#C7DCD0)
				if is_array(entity_var){
					_draw_number = entity_var[0]
	
				}
			}
			
			_draw_number = string(_draw_number)
			
			draw_set_valign(fa_top);
			draw_set_halign(fa_left);
			draw_text_transformed(x + 13, y + 8 + y_offset, _draw_number, 0.8, 0.8, 0);
		}
	
	break
	case ENITITY.WHISP:
		image_index = dir
		y_offset = round(0.75*sin(time*0.05)+2)	
		time ++
		draw_sprite_ext(sprite_index,image_index,x,y+y_offset,1,1,0,c_white,image_alpha)	
	break
	case ENITITY.PUSH_RIGHT:
	case ENITITY.PUSH_UP:
	case ENITITY.PUSH_LEFT:
	case ENITITY.PUSH_DOWN:
		time ++
		
		if xscale != 1{ xscale = lerp(xscale,1,0.25)}
		if yscale != 1{ yscale = lerp(yscale,1,0.25)}

		
		draw_sprite_ext(sprite_index,image_index,x+16,y+13+y_offset,xscale,yscale,0,c_white,image_alpha)
	break
	case ENITITY.PLAYER:
			
		if move_delay > 0{
			move_delay --
		}else{
			sprite_index = sPlayerIdle	
			image_index = dir
		}

	default:
		draw_sprite_ext(sprite_index,image_index,x,y+y_offset,1,1,0,c_white,image_alpha)
	break
}
