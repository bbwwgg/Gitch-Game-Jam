function interact_flag(){

	if 	interacting_inst.entity_id != ENITITY.PLAYER{ return}
	
	var _count = instance_number(pEntity)

	var _level_finished = undefined

	for(var _i = 0; _i < _count; _i ++){
		var _inst = instance_find(pEntity,_i)
	
		switch _inst.entity_id{
			case ENITITY.WHISP:
				if _inst.visible = false{
					if is_undefined(_level_finished){
						_level_finished = true
					}
				}else{
					_level_finished = false
				}
			break
		}
		

	}
	
	if !_level_finished or is_undefined(_level_finished ){
		exit
	}
	
	if instance_exists(oPlayerController){
		oPlayerController.player_input = false
		oPlayerController.state = player_level_complete
		oPlayerController.winning_index = oPlayerController.current_player_index
	}
	if instance_exists(oGameController){
		oGameController.completed_level = true
	}
	//
}