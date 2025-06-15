function interact_flag(){
	if instance_exists(oPlayerController){
		oPlayerController.player_input = false
	}
	if instance_exists(oGameController){
		oGameController.completed_level = true
	}
	transition(level_select)
}