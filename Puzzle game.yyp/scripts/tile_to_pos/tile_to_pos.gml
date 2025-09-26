function tile_to_x(xTile){
	return xTile*TILE_SIZE + global.camera_margin_width
}

function tile_to_y(yTile){
	return yTile*TILE_SIZE + global.camera_margin_height
}