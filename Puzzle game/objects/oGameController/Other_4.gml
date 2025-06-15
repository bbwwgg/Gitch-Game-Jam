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

			// Place instances into the grid
			var inst = instance_find(oLevel, 0)
			while inst != noone {
				

				var grid_x = floor((inst.x - min_x) / grid_cell_w)
				var grid_y = floor((inst.y - min_y) / grid_cell_h)
				
				var _level_info = {
					active : inst.active,
					complete : false,
					dest : inst.dest
				}
				
				ds_grid_set(level_grid, grid_x, grid_y, _level_info)
				
				instance_destroy(inst)
				inst = instance_find(oLevel, 0)
			}

			// Store the grid in the struct
			struct_set(_cur_level, "levels", level_grid)
		}else{
			instance_destroy(oLevel)	
		}
		
			
		if !instance_exists(oLevelSelectionController){
			with instance_create_layer(0,0,"Instances",oLevelSelectionController){
				current_map = _cur_level.levels
				
				setup_map_camera()
				
				board_width = ds_grid_width(current_map)
				board_height= ds_grid_height(current_map)
				
				x_offset = (global.camera_max_width - board_width*sprite_get_width(sLevel)) /2
				y_offset = (global.camera_max_height - board_height*sprite_get_height(sLevel)) /2
				
				
			}
		}
		
		break
		
	}
}

if i = array_length(level_selecton){
	setup_board_camera()	
}