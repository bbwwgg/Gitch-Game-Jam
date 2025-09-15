function player_on_board(){
	if !player_input{
		return
	}

	if  keyboard_check_pressed(ord("Z")){
		oBoardController.undo_board_state()
		return
	}

	if  keyboard_check_pressed(ord("R")){
		
		if instance_exists(oTransition){return}
		
		
		oBoardController.reset_board()
		
		player_input = false
		return
	}
	
	if instance_exists(oTutorialController){
		if !oTutorialController.is_empty(){
			if keyboard_check_pressed(ord("H")){
				if instance_exists(oTutorialController){
					if oTutorialController.state != HELP_STATE.EXIT{
						oTutorialController.activate()
						player_input = false
					}
				}
			}
		
			if mouse_check_button(mb_left){
				if oTutorialController.mouse_on(){
					oTutorialController.activate()
					player_input = false
				}
			}
		}
	}
	
	if  keyboard_check_pressed((vk_escape)){
		transition(oGameController.world)	
	}

	
	var h = sign(keyboard_check_pressed(ord("D"))-keyboard_check_pressed(ord("A"))+keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left))
	var v = sign(keyboard_check_pressed(ord("S"))-keyboard_check_pressed(ord("W"))+keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up))

	var _dir = -1


	if (h != 0) {
	    _dir = (h == 1) ? 0 : 2; // 0 = right, 2 = left
	}
	else if (v != 0) {
	    _dir = (v == -1) ? 1 : 3; // 1 = up, 3 = down
	}


	if _dir != -1{
		dir = _dir
		__commit_step()
	}
}