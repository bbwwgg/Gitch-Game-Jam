function adding_wisps(){
	
	if instance_exists(oTransition){return}
	
	
	if wisps_to_add != 0{
		var cam = view_camera[0];
		var view_x = camera_get_view_x(cam);
		var view_y = camera_get_view_y(cam);
		var view_w = camera_get_view_width(cam);
		var view_h = camera_get_view_height(cam);

		var gui_w = display_get_gui_width();
		var gui_h = display_get_gui_height();


		wisp_x_start = ((cursor_x  - view_x + x_offset) / view_w) * gui_w;
		wisp_y_start = ((cursor_y  - view_y + y_offset) / view_h) * gui_h;

		wisps = array_create(wisps_to_add)
		
		for (var i = 0; i < wisps_to_add; i++) {
			wisps[i] = [false, wisp_x_start, wisp_y_start, 0];
		}
		
		wisp_index = wisps_to_add - 1
		wisps_to_add = 0
		
		time = round(spawn_delay/2)
	}
	
	if time mod spawn_delay == 0{
		if wisp_index >= 0{
			wisps[wisp_index][0] = true
			wisps[wisp_index][3] = time
			
			instance_create_layer(cursor_x+x_offset,cursor_y+y_offset,"effects",oPart)
			camera_shake(5,0.6)
			wisp_index --
			
			
		}

	}
	
	
	for(var i = array_length(wisps)-1; i >= 0; i --){
		
			
		var cur_wisp = wisps[i]
		
		if !cur_wisp[0]{
			break	
		}
		
		if time - cur_wisp[3] <= time_to_top{
			
			wisps[i][1] = ease_in_out(time - cur_wisp[3], wisp_x_start, wisp_collection_x-wisp_x_start,time_to_top)	
			wisps[i][2] = ease_in_out(time - cur_wisp[3], wisp_y_start, wisp_collection_y-wisp_y_start,time_to_top)	
		}else{
			wisps_collected ++
			array_pop(wisps)
		}
	}
	
	
	if array_length(wisps) <= 0{
		time = delay
		state = unlocking_levels	
	}
	time ++
	
}