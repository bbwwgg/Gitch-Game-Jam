map1 = {
	room_index : level_select 
}


level_selecton = [ map1 ]


completed_level = false

tutorial = instance_create_layer(0,0,"Instances",oTutorialController)


//if instance_exists(oCamera){ instance_destroy(oCamera) }


if !instance_exists(oCamera){ instance_create_layer(0,0,"Instances",oCamera) }


										
function active_surrounding(_level, _x, _y) {
	var _levels_to_unlock = [] 
	var _unlock_dir = [[1,0],[-1,0],[0,1],[0,-1]]
	var _board_width = ds_grid_width(_level)
	var _board_height= ds_grid_height(_level)
						
	for(var i = 0; i < array_length(_unlock_dir); i ++){
		var _cur_dir = _unlock_dir[i]
						
		var _new_xpos = _x + _cur_dir[0]
		var _new_ypos = _y + _cur_dir[1]
						
		if _new_xpos < 0 or _new_xpos >= _board_width{	continue	}
		if _new_ypos < 0 or _new_ypos >= _board_height{	continue	}
						
		var _new_level = _level[# _new_xpos, _new_ypos] 
						
		if _new_level != -1{
			if _new_level.active = false{
				_new_level.active = 2
				if !struct_exists(_new_level, "dest"){
					var extra = active_surrounding(_level, _new_xpos,_new_ypos)
										
					if array_length(extra) != 0{
						_levels_to_unlock = array_concat(_levels_to_unlock,extra)
					}
				}
				array_push(_levels_to_unlock,[_new_xpos, _new_ypos])
			}
		}
	}
	return _levels_to_unlock
}
						