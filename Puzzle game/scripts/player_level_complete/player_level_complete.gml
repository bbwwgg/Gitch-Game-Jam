function player_level_complete(){
	if !instance_exists(oLeaveLevel){
		instance_create_layer(player_instance[winning_index].x,player_instance[winning_index].y,"Entity", oLeaveLevel)	
		
		oLeaveLevel.number_of_orbiters = wisp_count
		
		instance_destroy(player_instance[winning_index])
		
		time = 0
	}
	
}