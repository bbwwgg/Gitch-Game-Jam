interactable = false
stop = true
moveable = false
sunk = false

xscale = 1
yscale = 1

entity_var = 0

draw = true

y_offset = 0
time = 0
dir = -1

image_speed = 0

function update_pos(){
	x = xTile*TILE_SIZE + global.camera_margin_width
	y = yTile*TILE_SIZE + global.camera_margin_height
	
	if !sunk{
		depth = -y
		
		if  entity_id = ENITITY.FLAG or 
		entity_id = ENITITY.PUSH_UP or entity_id = ENITITY.PUSH_DOWN
		 or entity_id = ENITITY.PUSH_LEFT or entity_id = ENITITY.PUSH_RIGHT{
			depth += 16
		}
	}
	
	if entity_id = ENITITY.PLAYER{
		if sprite_index != sPlayerWalk{
			sprite_index = sPlayerWalk
			
			image = 0
		}else{
			image ++
			if image = 3{
				image = 0	
			}
		}
		
		
		image_index = image + dir * 3
		
		move_delay = 30	

	}
}

function fall(){
	interactable = false
	moveable = false
	stop = false
	sunk = true
	depth = 100-y
	
	var _x = x + lengthdir_x(TILE_SIZE,dir*90)
	var _y = y + lengthdir_y(TILE_SIZE,dir*90)
	instance_create_layer(_x,_y,"effects", oPartSplash)
	
	switch entity_id{
		default:
			image_index ++	
		break
		case ENITITY.LOCK:
			image_index = 2
		break
		
		case ENITITY.PLAYER:
			explode()
			//visible = false
		break
		
		case ENITITY.LUCK_BLOCK:
			image_index += 2
		break 
	}

}

function interact(_inst){
	
	
	interacting_inst = _inst

	if entity_id = ENITITY.PLAYER{return}
	
	script_execute(interact_script)
}

function explode(){
		visible = false
		interactable = false
		stop = false
		moveable = false
		camera_shake(6, 0.75) 
		
		var _prev_ent_count = array_length(global.board[# xTile, yTile][MAP_DATA.ENTITY])
	
		if _prev_ent_count = 0{
			global.board[# xTile, yTile][MAP_DATA.ENTITY] = noone
		}else{
			for(var i = 0; i < _prev_ent_count; i ++){
				if global.board[# xTile, yTile][MAP_DATA.ENTITY][i] = id{
					array_delete(global.board[# xTile, yTile][MAP_DATA.ENTITY],i,1)
				}
			}
		}
		
		switch entity_id{
			case ENITITY.PLAYER:
			
				var _x = x + lengthdir_x(TILE_SIZE,dir*90)
				var _y = y + lengthdir_y(TILE_SIZE,dir*90)
			
				with instance_create_layer(_x+TILE_SIZE/2,_y+TILE_SIZE/2,"effects", oEffect){
					sprite_index = sPlayerFace
				
					depth = -999
					
					image_speed = 0
					hsp = random_range(-1.5,1.5)
					vsp = random_range(-1,-3)
				
					angle_change = (hsp+vsp)*4
				
					vsp_change = 0.12
				
					alpha_change = 0.02
				
					alarm[0] = 60
				}
				instance_create_layer(_x,_y,"effects", oPartPlayer)
			break
			case ENITITY.LOCK:
			var lock_created = false
		

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
			break
			
			case ENITITY.LUCK_BLOCK:
			var head_created = false
			var slate_created = false
				

			repeat(irandom_range(4,6)){
				with instance_create_layer(x+TILE_SIZE/2,y+TILE_SIZE/2,"effects", oEffect){
					sprite_index = sLuckpPart
				
					depth = -999
				
					image_index = irandom_range(0,2)
				
				
				
					image_speed = 0
					hsp = random_range(-1.5,1.5)
					vsp = random_range(-1,-3)
				
					angle_change = (hsp+vsp)*2
				
					if !head_created{
						head_created = true
						image_index = 3
						angle_change*=2
					}else{
						if !slate_created{
							slate_created = true
							if other.image_index div 2 = 0{
								image_index = 4
							}else{
								image_index = 5
							}
							angle_change*=2.5
						}
					}
				
					vsp_change = 0.12
				
					alpha_change = 0.02
				
					alarm[0] = 60
				}
			}
			break
			
			case ENITITY.WHISP:
				camera_shake(3, 0.65) 
				instance_create_layer(x,y,"effects",oPart)
			break
		}
}