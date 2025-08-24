function interact_lock(){
	
	if entity_var != -1{
		moveable = true
		interactable = false
		return
	}
	
	if 	interacting_inst.entity_id != ENITITY.PLAYER and interacting_inst.entity_id != ENITITY.LUCK_BLOCK { return}
	

		var _luck;
		if interacting_inst.entity_id = ENITITY.LUCK_BLOCK{
			_luck = interacting_inst.entity_var
			
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
		
		entity_var = _luck
		if _luck <= 4{
			image_index ++
			camera_shake(3, 0.65) 
			play_sfx(sfxLock)
		}else{
			explode()
		}
}