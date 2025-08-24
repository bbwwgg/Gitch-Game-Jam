function init_entity_details(_id){
	switch(_id){
		case ENITITY.PLAYER:
			interactable = true
			stop = false
			sprite_index = sPlayerIdle
		break
		case ENITITY.FLAG:
			stop = true
			moveable = false
			interactable = true
			interact_script = interact_flag
			sprite_index = sExit
			
		break
		case ENITITY.BOX:
			moveable = true
			stop = true
			sprite_index = sBox
		break
		case ENITITY.LOCK:
			interactable = true
			entity_var = -1
			stop = true
			interact_script = interact_lock
			sprite_index = sLock
			image_speed = 0
		break
		case ENITITY.STOP_LOCK:
			interactable = true
			entity_var = -1
			stop = true
			interact_script = interact_lock
			sprite_index = sLock
			image_speed = 0
		break
		case ENITITY.WHISP:
			interactable = true
			stop = true
			moveable = false
			
			interact_script = interact_wisp
			following = false
			sprite_index = sWisp
			image_speed = 0
		break
		
		case ENITITY.LUCK_BLOCK:
			interactable = true
			stop = true
			moveable = true
			entity_var = -1
			interact_script = interact_luck
			sprite_index = sLuck
			image_speed = 0
		break
		
		case ENITITY.PUSH_DOWN:
			image_index ++
		case ENITITY.PUSH_LEFT:
			image_index ++
		case ENITITY.PUSH_UP:
			image_index ++
		case ENITITY.PUSH_RIGHT:
			sprite_index = sPush
			interactable = true
			stop = false
			moveable = false
			interact_script = interact_push
		break
	}
	
	


}