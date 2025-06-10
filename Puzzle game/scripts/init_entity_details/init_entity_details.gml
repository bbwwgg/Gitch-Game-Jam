function init_entity_details(_id){
	switch(_id){
		case ENITITY.PLAYER:
			interactable = true
			stop = false
			sprite_index = sPlayer
		break
		case ENITITY.FLAG:
			stop = false
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
			sprite_index = sPlayer
		break
	}
	
	


}