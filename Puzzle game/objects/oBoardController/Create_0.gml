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




global.board_state = []

/// @func save_board_state()
/// @desc Saves the current global.board state into global.board_state stack

function save_board_state() {
    // Create a new ds_grid copy for the snapshot
    var snapshot = ds_grid_create(global.board_width, global.board_height);

    for (var _y = 0; _y < global.board_height; _y++) {
        for (var _x = 0; _x  < global.board_width; _x ++) {
            var cell = global.board[# _x , _y];
            // Deep copy the cell array
            var cell_copy = array_create(array_length(cell), noone);
            for (var i = 0; i < array_length(cell); i++) {
                // If nested arrays inside cell[i], copy deeper if needed. For now assuming flat arrays or primitives
                // If you have nested arrays inside cell[i], recursively deep copy here.
                if (is_array(cell[i])) {
                    // Deep copy nested array
                    var nested = cell[i];
                    var nested_copy = array_create(array_length(nested), noone);
                    for (var j = 0; j < array_length(nested); j++) {
                        nested_copy[j] = nested[j];
                    }
                    cell_copy[i] = nested_copy;
                } else {
                    cell_copy[i] = cell[i];
                }
            }
            snapshot[# _x, _y] = cell_copy;
        }
    }

    // Push snapshot to global.board_state stack
    array_push(global.board_state, snapshot);
}

// Similarly for undo:
function undo_board_state() {
    if (array_length(global.board_state) == 0) {
        show_debug_message("No saved board states to undo.");
        return;
    }

    // Pop the last saved state snapshot
    var snapshot = array_pop(global.board_state);

    // Replace global.board with snapshot
    // First free the current grid
    if (ds_exists(global.board, ds_type_grid)) {
        ds_grid_destroy(global.board);
    }
	
	
    global.board = snapshot;

    // You may want to refresh or update entities and objects visually here if needed
    // For example, update instances or tilemaps based on restored grid

    for (var _y = 0; _y < global.board_height; _y++) {
        for (var _x = 0; _x  < global.board_width; _x ++) {
			var cell = global.board[# _x, _y][MAP_DATA.ENTITY] 
			if cell != noone{
				for (var i = 0; i < array_length(cell); i++) {
					cell[i].xTile = _x
					cell[i].yTile = _y
					
					cell[i].update_pos()
				}
			}
		}
	}

    show_debug_message("Board state restored from undo.");
}