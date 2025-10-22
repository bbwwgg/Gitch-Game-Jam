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


__entity_data()
//

//Create a key of all entities
global.entity_key = array_create(ENITITY.COUNT, noone)

//Board
for(var i = 0; i < grid_height; i ++){
	for(var j = 0; j < grid_width; j ++){
		global.board[# j, i] = array_create(MAP_DATA.COUNT,noone)
		
		//TODO change sGHrass to a var
		var _tile_index = tilemap_get(map_id,j,i)
		var _tile = noone
		if _tile_index != 0{
			_tile = [sGrass_tile,_tile_index]	
		}
		global.board[# j, i][MAP_DATA.TILE] = _tile
		
		var _entity = tilemap_get(entity_map,j,i)
		
		//If there is an entity here
		if _entity > 0{
			
			with instance_create_layer(0,0,"Entity", pEntity){
				entity_id = _entity
				xTile = j
				yTile = i
				xPrev = xTile
				yPrev = yTile
				
				var keys = variable_struct_get_names(other._entity_data[entity_id]);

				// Loop through the array of keys
				for (var z = 0; z < array_length(keys); z++)
				{
				    var key = keys[z]; // Get the name of the current variable
				    var value = other._entity_data[entity_id][$ key]; // Get the value of the current variable using the accessor
					variable_instance_set(self, key, value)
				}
	
				var _entity_key = global.entity_key[entity_id]
				
				if _entity_key == noone{
					global.entity_key[entity_id] = []	
				}
				
				array_push(global.entity_key[entity_id],id)
	
				var _inst_count = array_length(global.entity_key[entity_id])
	
				entity_key = _inst_count - 1
				global.board[# j, i][MAP_DATA.ENTITY] = [entity_id,entity_key]
				update_pos()
				

			}

		}
		
		
		var _object =  tilemap_get(object_map,j,i)
		
		if _object > 0{
			global.board[# j, i][MAP_DATA.SOLID] =  [sHedge,_object]
		}
		
	}
}


if !instance_exists(oPlayerController){instance_create_layer(0,0,"controllers",oPlayerController)}

oPlayerController.entity_map = ds_grid_create(grid_width,grid_height)


base_xOffset = global.camera_margin_width
base_yOffset = global.camera_margin_height

state = LEVEL_STATE.ENTER

animation_timer = 60
time_per_segment = 20
time = 0



global.board_state = []

function save_board_state() {

	var snapshot = clone_deep_board(global.board)
		
	var _entities = []
	
	for (var i = 0; i < instance_number(pEntity); i++){
	    var _inst = instance_find(pEntity, i);
		
		var _ent_id = _inst.entity_id
		
		var _saved_vars = {
			stop: _inst.stop,
			moveable: _inst.moveable,
			image_index : _inst.image_index
		}
		var keys = variable_struct_get_names(_entity_data[_ent_id]);
		
		// Loop through the array of keys
		for (var z = 0; z < array_length(keys); z++)
		{
			var key = keys[z]; // Get the name of the current variable
			if key = "stop" || key = "moveable"{
				continue	
			}
			
			variable_struct_set(_saved_vars,key,variable_instance_get(_inst, key))		
		}
		
		var _inst_info = {
			object_type : _ent_id,
			entity_key : _inst.entity_key,
			pos : [_inst.xTile, _inst.yTile],
			vars: _saved_vars
		}
		array_push(_entities,_inst_info)
	}
	
	
	var world_snapshot = {
		luck : global.luck_system.index,
		board : snapshot,
		entities : _entities
	}
	

    array_push(global.board_state, world_snapshot);

}

function reset_board(){
	
	if transition(noone){
		while array_length(global.board_state) > 1{
			ds_grid_destroy(array_pop(global.board_state).board)
		}
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
	
	// Free the old board
	if (ds_exists(global.board, ds_type_grid)) {
	    ds_grid_destroy(global.board);
	}

	// Make a fresh grid and copy into it
	global.board = ds_grid_create(grid_width,grid_height);
	ds_grid_copy(global.board, snapshot);

	ds_grid_destroy(snapshot);

    
	//Entity making
	var _entity_fix = world_snapshot.entities
	
	for(var i = 0; i < array_length(_entity_fix); i ++ ){
		var _cur_set = _entity_fix[i]
		var _cur_entity =global.entity_key[_cur_set.object_type, _cur_set.entity_key]
		
		if !instance_exists(_cur_entity){
			
			_cur_entity = instance_create_layer(0,0,"Entity", pEntity)
			
			with _cur_entity{
				entity_key = _cur_set.entity_key
				entity_id = _cur_set.object_type
				global.entity_key[entity_id,entity_key] = id
				
				var keys = variable_struct_get_names(other._entity_data[entity_id]);

				// Loop through the array of keys
				for (var z = 0; z < array_length(keys); z++)
				{
				    var key = keys[z]; // Get the name of the current variable
				    var value = other._entity_data[entity_id][$ key]; // Get the value of the current variable using the accessor
					variable_instance_set(self, key, value)
				}
			}

		}
		
		
		with _cur_entity {

			xPrev = xTile
			yPrev = yTile

			xTile = _cur_set.pos[0]
			yTile = _cur_set.pos[1]
					
			update_pos()		
				
			
			var _var_data = _cur_set.vars
			var keys = variable_struct_get_names(_var_data);
		
			// Loop through the array of keys
			for (var z = 0; z < array_length(keys); z++)
			{
				var key = keys[z]; // Get the name of the current variable
				
				variable_instance_set(self,key,variable_struct_get(_var_data,key))

			}
		}
		
	}
		
    //show_debug_message("Board state restored from undo.");
}