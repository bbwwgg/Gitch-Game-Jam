enum MAP_DATA{
	ENTITY, //Enity on tile.
	OBJECT, // object on tile
	TILE, //sprite for ground
	COUNT	
}

enum ENITITY{
	EMPTY,
	PLAYER,
	FLAG,
	COUNT
}

square_size = 16

var base_lay_id = layer_get_id("BaseTile");
var entity_lay_id = layer_get_id("Entities");


var entity_map = layer_tilemap_get_id(entity_lay_id);
var map_id = layer_tilemap_get_id(base_lay_id);


layer_set_visible(entity_lay_id, false)
layer_set_visible(base_lay_id, false)


grid_height = tilemap_get_tile_width(map_id);
grid_width = tilemap_get_tile_height(map_id);


global.map = ds_grid_create(grid_width,grid_height)

for(var i = 0; i < grid_height; i ++){
	for(var j = 0; j < grid_width; j ++){
		global.map[# j, i] = array_create(MAP_DATA.COUNT,noone)
		
		global.map[# j, i][MAP_DATA.TILE] = tilemap_get(map_id,j,i)
		
		var _entity = tilemap_get(entity_map,j,i)
		
		if _entity > 0{
			
			with instance_create_layer(j*square_size,i*square_size,"Entity", pEntity){
				entity_id = _entity
				global.map[# j, i][MAP_DATA.ENTITY] = id
			}

		}
		
	}
}

if !instance_exists(oPlayerController) instance_create_layer(0,0,"controllers",oPlayerController)