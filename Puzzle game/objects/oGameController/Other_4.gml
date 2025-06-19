//if instance_exists(oCamera){ instance_destroy(oCamera) }


if !instance_exists(oCamera){ instance_create_layer(0,0,"Instances",oCamera) }

for(var i=0; i < array_length(level_selecton); i ++){
	var _cur_level = level_selecton[i]
	
	if _cur_level.room_index = room{
		
		world = _cur_level.room_index
		
		var _levels_to_unlock = undefined
		if (!struct_exists(_cur_level, "levels")) {
			
			// Get all oLevel instances
			var inst_count = instance_number(oLevel)

			// Determine min and max x/y to calculate grid size
			var min_x = 999999
			var min_y = 999999
			var max_x = -999999
			var max_y = -999999

			for (var j = 0; j < inst_count; j++) {
				var inst = instance_find(oLevel, j)
				if (inst.x < min_x) min_x = inst.x
				if (inst.y < min_y) min_y = inst.y
				if (inst.x > max_x) max_x = inst.x
				if (inst.y > max_y) max_y = inst.y
			}

			var grid_cell_w = sprite_get_width(sLevelPath)   
			var grid_cell_h = sprite_get_height(sLevelPath)

			// Calculate grid dimensions
			var grid_w = floor((max_x - min_x) / grid_cell_w) + 1
			var grid_h = floor((max_y - min_y) / grid_cell_h) + 1

			// Create the ds_grid
			var level_grid = ds_grid_create(grid_w, grid_h)
			ds_grid_clear(level_grid, -1)
			
			//starting level
			var starting_level = 9999
			var starting_location = [0,0]

			// Place instances into the grid
			var inst = instance_find(oLevel, 0)
			while inst != noone {
				
				var grid_x = floor((inst.x - min_x) / grid_cell_w)
				var grid_y = floor((inst.y - min_y) / grid_cell_h)
				
				switch (inst.object_index){
					case (oNextWorld):
						var _active = 0
						if DEBUG_MODE or inst.active {
							_active = 1
						}
					
						var _level_info = {
							world_dest : inst.world_dest,
							active : _active
						}					
					break
					case (oLevelPath):
						var _level_info = {
							active : DEBUG_MODE
						}
					break
					case (oLevelBlocker):
						var _level_info = {
							active : DEBUG_MODE,
							unlock_requirement : inst.unlock_requirement
						}
					break
					default:
						var _level_number = inst.level_number
				
						var _level_info = {
							active : DEBUG_MODE, //CHANGE 
							complete : false,
							level_number : _level_number,
							dest : inst.dest
						}
				
						if !is_string(_level_number){
							if _level_number < starting_level{
								starting_level = _level_number
								starting_location = [grid_x,grid_y]
							}
						}
					break
				}
				
				ds_grid_set(level_grid, grid_x, grid_y, _level_info)

				
				instance_destroy(inst)
				
				
				
				inst = instance_find(oLevel, 0)
				
				
			}

			// Store the grid in the struct
			struct_set(_cur_level, "levels", level_grid)
			
			level_grid[# starting_location[0], starting_location[1]].active = true
			
			_cur_level.saved_cursor_pos = starting_location
			
			
		}else{

			instance_destroy(oLevel)	
		
			if completed_level = true{

				var pos_x = _cur_level.saved_cursor_pos[0]
				var pos_y = _cur_level.saved_cursor_pos[1]
				
				if _cur_level.levels[# pos_x, pos_y].complete = false{
					_cur_level.levels[# pos_x, pos_y].complete = true
										
					_levels_to_unlock = active_surrounding(_cur_level.levels, pos_x, pos_y)
				}
			}
		}
		
			
		if !instance_exists(oLevelSelectionController){
			
			var _pos = _cur_level.saved_cursor_pos
			
			with instance_create_layer(0,0,"Instances",oLevelSelectionController){
				
				wisps_collected = other.wisp_total
				
				if !is_undefined(_levels_to_unlock){
					state = adding_wisps
					
					wisps_to_add = other.wisp_count
					other.wisp_total +=  other.wisp_count
					levels_to_unlock = _levels_to_unlock

				}
				current_map = _cur_level.levels
				
				setup_map_camera()
				
				board_width = ds_grid_width(current_map)
				board_height= ds_grid_height(current_map)
				
				x_offset = (global.camera_max_width - board_width*sprite_get_width(sLevelPath)) /2
				y_offset = (global.camera_max_height - board_height*sprite_get_height(sLevelPath)) /2
				
				
				cursor_pos_x = _pos[0]
				cursor_pos_y = _pos[1]
				
				cursor_x = cursor_pos_x*tile_width
				cursor_y = cursor_pos_y*tile_height


			}
		}
		
		
		tutorial.draw = false
		
		break
		
	}
}

if i = array_length(level_selecton){
	tutorial.draw = true

	with oTutorialController{
		var _count = instance_number(pEntity)

		for(var _i = 0; _i < _count; _i ++){
			var _ent_id = instance_find(pEntity,_i).entity_id
			
			if entity_index[_ent_id] != -1{
				if unlocked_tips[entity_index[_ent_id]] = false{
					unlocked_tips[entity_index[_ent_id]] = true
					if updated_tips = noone{
						updated_tips = entity_index[_ent_id]
					}
					switch_state(HELP_STATE.ALERT)
				}
			}
			
		}
	}

	setup_board_camera()	
}