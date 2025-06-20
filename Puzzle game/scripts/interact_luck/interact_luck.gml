function interact_luck(){
	
	
	if 	interacting_inst.entity_id != ENITITY.PLAYER{
		moveable = true
	}else{
		if entity_var = -1{
			var _luck = global.luck_system.take()
			
			if is_array(_luck) image_index ++
			
			entity_var = _luck
			moveable = false
			
			play_sfx(sfxLuckTake)
			
		}else{
			moveable = true
		}
	}
}