
for(var i = 0; i < grid_height; i ++){
	for(var j = 0; j < grid_width; j ++){
		draw_sprite(sGrass_tile,global.map[# j, i][MAP_DATA.TILE],square_size*j,square_size*i)
		
		//draw_text(square_size*j,square_size*i,global.map[# j, i][MAP_DATA.TILE])
			
		
	}
}