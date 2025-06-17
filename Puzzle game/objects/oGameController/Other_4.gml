//if instance_exists(oCamera){ instance_destroy(oCamera) }


if !instance_exists(oCamera){ instance_create_layer(0,0,"Instances",oCamera) }

for(var i=0; i < array_length(level_selecton); i ++){
	var _cur_level = level_selecton[i]
	if _cur_level.room_index = room{
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

			var grid_cell_w = sprite_get_width(sLevel)   
			var grid_cell_h = sprite_get_height(sLevel)

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
				
				ds_grid_set(level_grid, grid_x, grid_y, _level_info)
				
				instance_destroy(inst)
				inst = instance_find(oLevel, 0)
			}

			// Store the grid in the struct
			struct_set(_cur_level, "levels", level_grid)
			
			level_grid[# starting_location[0], starting_location[1]].active = true
			
			saved_cursor_pos = starting_location
			
			
		}else{

			instance_destroy(oLevel)	
		
			if completed_level = true{
				
				var pos_x = saved_cursor_pos[0]
				var pos_y = saved_cursor_pos[1]
				
				if _cur_level.levels[# pos_x, pos_y].complete = false{
					_cur_level.levels[# pos_x, pos_y].complete = true
					
					var _unlock_dir = [[1,0],[-1,0],[0,1],[0,-1]]
					
					var _board_width = ds_grid_width(_cur_level.levels)
					var _board_height= ds_grid_height(_cur_level.levels)
					
					for(var i = 0; i < array_length(_unlock_dir); i ++){
						var _cur_dir = _unlock_dir[i]
						
						var _new_xpos = pos_x + _cur_dir[0]
						var _new_ypos = pos_y + _cur_dir[1]
						
						if _new_xpos < 0 or _new_xpos >= _board_width{	continue	}
						if _new_ypos < 0 or _new_ypos >= _board_height{	continue	}
						
						var _new_level = _cur_level.levels[# _new_xpos, _new_ypos] 
						
						if _new_level != -1 and _new_level.active = false{
							//Preform unlock animation
							_new_level.active = true
						}
						
					}
					
				}
			}
		}
		
			
		if !instance_exists(oLevelSelectionController){
			with instance_create_layer(0,0,"Instances",oLevelSelectionController){
				current_map = _cur_level.levels
				
				setup_map_camera()
				
				board_width = ds_grid_width(current_map)
				board_height= ds_grid_height(current_map)
				
				x_offset = (global.camera_max_width - board_width*sprite_get_width(sLevel)) /2
				y_offset = (global.camera_max_height - board_height*sprite_get_height(sLevel)) /2
				
				
				cursor_pos_x = other.saved_cursor_pos[0]
				cursor_pos_y = other.saved_cursor_pos[1]
				
				cursor_x = cursor_pos_x*tile_width
				cursor_y = cursor_pos_y*tile_height


			}
		}
		
		break
		
	}
}

if i = array_length(level_selecton){
	setup_board_camera()	
}