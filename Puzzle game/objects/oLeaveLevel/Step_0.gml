

y_offset = 2*cos(time*0.15) - 4
center_y = y + y_offset
	
angle_offset = (angle_offset + orbit_speed) mod 360;

if time <= time_to{
	
	orbit_radius_x = ease_out(time, 0, orbit_radius_x_max,time_to)
	orbit_radius_y = ease_out(time, 0, orbit_radius_y_max,time_to)
	

}else{
	if  rise_time <= rise_time_to{
		rise_time ++
	}else{
		if explode = false{
			explode = true
			time = 0
			for (var i = 0; i < number_of_orbiters; i++) {
				var angle = angle_offset + (360 / number_of_orbiters) * i;
				var ox = center_x + lengthdir_x(orbit_radius_x, angle);
				var oy = center_y + lengthdir_y(orbit_radius_y, angle);
				
				instance_create_layer(ox,oy,"effects",oPart)
			}
			
			instance_create_layer(x+TILE_SIZE/2,y+TILE_SIZE/2,"effects",oPartPlayer)
		
			camera_shake(10)
		}
		
		if time >= delay{
			transition(level_select)	
		}
		//
	}
	
}

time ++