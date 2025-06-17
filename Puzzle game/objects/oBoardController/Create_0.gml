enum LEVEL_STATE{
	ENTER,
	PLAYING,
	EXIT
}




global.luck_system = {
    sequence: [],
    index: 0,
    last_step: -1,
    current_value: 0,

    init: function(_sequence) {
		sequence = _sequence
		
		if !is_array(array_last(sequence)){
			array_push(sequence,[0,SEQUENCE_NUM_TYPE.REPEAT])
		}
    },

    use: function() {
        var current_step = current_time;
        if (last_step != current_step) {
            last_step = current_step;
            if (index < array_length(sequence)) {
				var _cur_value = sequence[index]
				if is_array(_cur_value){
					
					if _cur_value[1] != SEQUENCE_NUM_TYPE.REPEAT{
						index += 1	
					}
					_cur_value = _cur_value[0]

				}else{
					index += 1	
				}
				
                current_value = _cur_value;
            } else {
				
                current_value = 0;
            
			}
        }
		
		
		if is_array(current_value){
			return current_value[0]	
		}
		
        return current_value;
    },
	
	//Will always go to next
    take: function() {
        var current_step = current_time;
        if (last_step != current_step) {
            last_step = current_step;
            if (index < array_length(sequence) - 1) {
				var _cur_value = sequence[index]
				index += 1
                current_value = _cur_value;
            } else {
				current_value = sequence[index];
			}
        }
        return current_value;
    }
}

luck_cursor_x =  0
luck_cursor_x_to = 0
luck_cursor_progress = 1
luck_cursor_x_start = 0

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



state = LEVEL_STATE.ENTER

animation_timer = 60
time_per_segment = 20
time = 0



global.board_state = []

function save_board_state() {
    var snapshot = ds_grid_create(global.board_width, global.board_height);

    for (var _y = 0; _y < global.board_height; _y++) {
        for (var _x = 0; _x < global.board_width; _x++) {
            var cell = global.board[# _x, _y];
            var cell_copy = array_create(array_length(cell), noone);

            for (var i = 0; i < array_length(cell); i++) {
                var item = cell[i];

                if (is_array(item)) {
                    // If this is an array, deep copy its contents, but also check if it contains instances
                    var nested = item;
                    var nested_copy = array_create(array_length(nested), noone);

                    for (var j = 0; j < array_length(nested); j++) {
                        var nested_item = nested[j];
						
                        if (instance_exists(nested_item)) {
                            // Save instance with vars
							
                            nested_copy[j] = {
                                inst: nested_item,
                                vars: {
                                    interactable: nested_item.interactable,
                                    stop: nested_item.stop,
                                    moveable: nested_item.moveable,
                                    sunk: nested_item.sunk,
									visible : nested_item.visible,
									image_index : nested_item.image_index,
									depth : nested_item.depth,
									entity_var : nested_item.entity_var
                                }
                            };
                        } else {
                            nested_copy[j] = nested_item;
                        }
                    }
                    cell_copy[i] = nested_copy;

                 } else {
                    // Primitive or noone
                    cell_copy[i] = item;
                }
            }

            snapshot[# _x, _y] = cell_copy;
        }
    }

	var world_snapshot = {
		luck : global.luck_system.index,
		board : snapshot
	}

    array_push(global.board_state, world_snapshot);
}

function reset_board(){
	
	transition(noone)
	
	while array_length(global.board_state) > 1{
		ds_grid_destroy(array_pop(global.board_state).board)
	}
}

// Similarly for undo:
function undo_board_state() {
    if (array_length(global.board_state) == 0) {
        show_debug_message("No saved board states to undo.");
        return;
    }

    // Pop the last saved state snapshot
    var world_snapshot = array_pop(global.board_state);
    var snapshot = world_snapshot.board
	
	//Undo the luck
	global.luck_system.index = world_snapshot.luck
	
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
				var _inst_ar = []
				for (var i = 0; i < array_length(cell); i++) {
					var _cur_cell = cell[i]
					var _cur_inst = _cur_cell.inst
					
					_cur_inst.xTile = _x
					_cur_inst.yTile = _y
					
					_cur_inst.update_pos()
					
					_cur_inst.interactable = _cur_cell.vars.interactable
					_cur_inst.stop = _cur_cell.vars.stop
					_cur_inst.moveable = _cur_cell.vars.moveable
					_cur_inst.sunk = _cur_cell.vars.sunk
					_cur_inst.visible = _cur_cell.vars.visible
					_cur_inst.image_index = _cur_cell.vars.image_index
					_cur_inst.depth = _cur_cell.vars.depth
					_cur_inst.entity_var = _cur_cell.vars.entity_var
					array_push(_inst_ar, _cur_inst)
				}
				
				global.board[# _x, _y][MAP_DATA.ENTITY] = _inst_ar
			}
		}
	}

    //show_debug_message("Board state restored from undo.");
}