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
			sprite_index = sFlag
		break
		case ENITITY.BOX:
			moveable = true
			stop = true
			sprite_index = sBox
		break
		case ENITITY.LOCK:
			interactable = true
			stop = true
			interact_script = interact_lock
			sprite_index = sLock
			image_speed = 0
		break
	}
	
	


}