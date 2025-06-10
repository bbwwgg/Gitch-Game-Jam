square_size = TILE_SIZE

var base_lay_id = layer_get_id("BaseTile");
var entity_lay_id = layer_get_id("Entities");
var object_lay_id = layer_get_id("Objects");


var entity_map = layer_tilemap_get_id(entity_lay_id);
var object_map = layer_tilemap_get_id(object_lay_id);
var map_id = layer_tilemap_get_id(base_lay_id);


layer_set_visible(object_lay_id, false)
layer_set_visible(entity_lay_id, false)
layer_set_visible(base_lay_id, false)


global.board_width = tilemap_get_width(map_id);
global.board_height = tilemap_get_height(map_id);
grid_height = global.board_height
grid_width = global.board_width

global.board = ds_grid_create(grid_width,grid_height)

//Camera

if !instance_exists(oCamera){ instance_create_depth(0,0,0,oCamera) }

setup_board_camera()


//Board
for(var i = 0; i < grid_height; i ++){
	for(var j = 0; j < grid_width; j ++){
		global.board[# j, i] = array_create(MAP_DATA.COUNT,noone)
		
		global.board[# j, i][MAP_DATA.TILE] = tilemap_get(map_id,j,i)
		
		var _entity = tilemap_get(entity_map,j,i)
		
		if _entity > 0{
			
			with instance_create_layer(0,0,"Entity", pEntity){
				entity_id = _entity
				xTile = j
				yTile = i
				global.board[# j, i][MAP_DATA.ENTITY] = [id]
				
				init_entity_details(entity_id)
				
				update_pos()
			}

		}
		
		var _object =  tilemap_get(object_map,j,i)
		
		if _object > 0{
			global.board[# j, i][MAP_DATA.OBJECT] = _object
		}
		
	}
}


if !instance_exists(oPlayerController){instance_create_layer(0,0,"controllers",oPlayerController)}

base_xOffset = global.camera_margin_width
base_yOffset = global.camera_margin_height




global.board_state[0] = []

function copy_board(){
	
}

function undo_board(_board_grid){
	
	for(var i = 0; i < grid_height; i ++){
		for(var j = 0; j < grid_width; j ++){

		}
	}
}
