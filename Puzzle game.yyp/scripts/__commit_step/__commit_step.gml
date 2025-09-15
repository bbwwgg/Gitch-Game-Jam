function __commit_step(){
	//Preform a step
	ds_grid_clear(entity_map,0)
	
	_conflict_list = ds_priority_create()
	
	//Make desired points
	with(pEntity){
		if step_script != noone{ 
			script_execute(step_script)
		}
	}
	
	while ds_priority_size(_conflict_list) > 0{
		
		show_message(ds_priority_delete_min(_conflict_list))
		
		//Resolve any conflicts
		
	
	}
	
	
	ds_priority_destroy(_conflict_list)
}