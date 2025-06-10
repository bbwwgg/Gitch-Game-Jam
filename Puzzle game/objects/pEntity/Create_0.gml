interactable = false
stop = true
moveable = false
sunk = false

function update_pos(){
	x = xTile*TILE_SIZE + global.camera_margin_width
	y = yTile*TILE_SIZE + global.camera_margin_height
}

function fall(){
	interactable = false
	moveable = false
	stop = false
	sunk = true
	depth = 99
}

function interact(){
	
	
	if entity_id = ENITITY.PLAYER{return}
	
	script_execute(interact_script)
}