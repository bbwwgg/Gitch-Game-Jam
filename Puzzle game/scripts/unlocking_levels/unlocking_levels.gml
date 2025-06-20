function unlocking_levels(){
	
	if instance_exists(oTransition){return}
	
	if time < delay*0.3{
		time ++
	}else{
		time = 0
		if array_length(levels_to_unlock) > 0{
			var _cur = array_pop(levels_to_unlock)
			current_map[# _cur[0], _cur[1]].active = true
			camera_shake(5,0.6)
			
			play_sfx(sfxLevelExplosion)
			
			instance_create_layer(x_offset + _cur[0] * tile_width, y_offset + _cur[1] * tile_height,"effects", oPartLevel)
			//with instance_create_layer(x_offset + _cur[0] * tile_width + tile_width/2, y_offset + _cur[1] * tile_height + tile_height/2,"effects", oEffect){
			//	sprite_index = choose(sLevelCreation2,sLevelCreation3,sLevelCreation4)
			//}
		}
		
		if array_length(levels_to_unlock) = 0{
			state = Player_selecting_level
		}
	}
}