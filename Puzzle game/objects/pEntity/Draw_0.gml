if sunk{
	y_offset = round(0.75*sin(time*0.05)+2)	
	time ++
}




switch(entity_id){

	case ENITITY.LOCK:

		draw_sprite_ext(sprite_index,image_index,x,y+y_offset,1,1,0,c_white,image_alpha)
	break

	case ENITITY.WHISP:
		image_index = dir
		y_offset = round(0.75*sin(time*0.05)+2)	
		time ++
		draw_sprite_ext(sprite_index,image_index,x,y+y_offset,1,1,0,c_white,image_alpha)
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
