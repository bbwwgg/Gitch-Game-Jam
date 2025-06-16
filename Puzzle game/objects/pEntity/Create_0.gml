interactable = false
stop = true
moveable = false
sunk = false

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
		
		if  entity_id = ENITITY.FLAG{
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
	
	switch entity_id{
		default:
			image_index ++	
		break
		case ENITITY.LOCK:
			image_index = 2
		break
		
		case ENITITY.PLAYER:
			visible = false
		break
	}

}

function interact(){
	
	
	if entity_id = ENITITY.PLAYER{return}
	
	script_execute(interact_script)
}