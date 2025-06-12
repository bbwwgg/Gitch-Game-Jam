
if sunk{
	y_offset = round(0.75*sin(time*0.05)+2)	
	time ++
}

switch(entity_id){

	case ENITITY.LOCK:
		if !interactable{
			image_index = 1
		}else{
			image_index = 0
		}
		draw_sprite(sprite_index,image_index,x,y+y_offset)
	break

	case ENITITY.PLAYER:
		
		
		
		if move_delay > 0{
			move_delay --
		}else{
			sprite_index = sPlayerIdle	
			image_index = dir
		}

	default:
		draw_sprite(sprite_index,image_index,x,y+y_offset)
	break
}

