function unlock_blocker(){


	if time = 0{
		camera_shake(5,0.6)
		instance_create_layer(x_offset + lock_x * tile_width, y_offset + lock_y * tile_height,"effects", oPartLevel)
		struct_remove(current_map[# lock_x,lock_y], "unlock_requirement")
		
		play_sfx(sfxLevelExplosion)
		var _base_created = false
		
		repeat(2){
			with instance_create_layer(x_offset + lock_x * tile_width + tile_width/2, y_offset + lock_y * tile_height+ tile_height/2,"effects", oEffect){
				sprite_index = sLevelBlockerPart
				
				depth = -999

				if !_base_created{
					image_index = 0
					_base_created = true
				}else{
					image_index = 1	
				}
				image_speed = 0
				hsp = random_range(-1.5,1.5)
				vsp = random_range(-1,-3)
				
				angle_change = (hsp+vsp)*5
				
				vsp_change = 0.12
				
				alpha_change = 0.02
				
				alarm[0] = 60
			}
		}
	}

	
	if time < delay{
		time ++
	}else{
		state = unlocking_levels
		time = 0
	}
}