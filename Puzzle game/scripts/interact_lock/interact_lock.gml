function interact_lock(){
	
	var _luck = global.luck_system.use()
	
	if _luck <= 4{
		moveable = true
		interactable = false
		image_index ++
		
		camera_shake(3, 0.65) 
		
	}else{
		interactable = false
		stop = false
		visible = false
		
		var lock_created = false
		
		camera_shake(6, 0.75) 
		
		repeat(irandom_range(4,6)){
			with instance_create_layer(x+TILE_SIZE/2,y+TILE_SIZE/2,"effects", oEffect){
				sprite_index = sDoorPart
				
				depth = -999
				
				image_index = irandom_range(0,2)
				
				
				
				image_speed = 0
				hsp = random_range(-1.5,1.5)
				vsp = random_range(-1,-3)
				
				angle_change = (hsp+vsp)*2
				
				if !lock_created{
					lock_created = true
					image_index = 3
					angle_change = (hsp+vsp)*2
				}
				
				vsp_change = 0.12
				
				alpha_change = 0.02
				
				alarm[0] = 60
			}
		}
	}
	
}