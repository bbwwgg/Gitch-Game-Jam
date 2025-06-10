if current_width != target_width{
	var prev_height = current_height
	var prev_width = current_width
	
	current_width  = lerp(current_width, target_width,0.15)
	current_height = lerp(current_height, target_height,0.15)
	
	
	var _x_adjust = -(current_width - prev_width) / 2
	var _y_adjust = -(current_height - prev_height) / 2
	x += _x_adjust
	y += _y_adjust
	
	x_to += _x_adjust
	y_to += _y_adjust
	
	camera_set_view_size(global.Camera, current_width, current_height)
	
}

if target != noone{
	x_to = target.x
	y_to = target.y
}


if x != x_to{ x = lerp(x, x_to, 0.2)}
if y != y_to{ y = lerp(y, y_to, 0.2)}

if lock_to_board{
	x_to = clamp(x_to,0,global.camera_max_width-current_width)
	y_to = clamp(y_to,0,global.camera_max_height-current_height)
}

//show_debug_message([[x,y],[x_to,y_to]])
camera_set_view_pos(global.Camera, x, y)

