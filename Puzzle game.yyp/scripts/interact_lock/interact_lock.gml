function interact_lock(){
	
	
	// Only change status if we are being interacted with by a player or luck block
	if 	interacting_inst.use_luck = false || lock_status != -1{ return}
	

	var _luck;
	if interacting_inst.entity_id = ENITITY.LUCK_BLOCK{
		_luck = interacting_inst.luck
		
		if _luck = -1{return}
			
		if is_array(_luck){
				
			if _luck[1] != SEQUENCE_NUM_TYPE.REPEAT{
				interacting_inst.explode()
			}
				
			_luck = _luck[0]
		}else{
			interacting_inst.explode()
		}

			

			
	}else{
		_luck = global.luck_system.use()
	}
		
	lock_status = _luck
	
	if _luck <= 4{
		image_index ++
		camera_shake(3, 0.65) 
		play_sfx(sfxLock)
		moveable = true
	}else{
		explode()
	}
}