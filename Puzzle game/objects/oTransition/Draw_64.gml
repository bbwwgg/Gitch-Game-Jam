
if state = TRANSITION_STATE.ENTER{
	if time <= time_duration{
		height = ease_in(time,0,max_height,time_duration)
		width = ease_in(time,0,max_width,time_duration)
	}else{
		//Do something (room restart or new room)
		
		room_goto(room_to)
		
		state = TRANSITION_STATE.EXIT
		time = 0
	}
	time ++
}else{
	if time <= time_duration{
		height = ease_out(time,max_height,-max_height,time_duration)
		width = ease_out(time,max_width,-max_width,time_duration)
	}else{
		instance_destroy()
	}	
	time ++
}


draw_set_color(c_black)
draw_rectangle(0,VIEW_HEIGHT,VIEW_WIDTH,VIEW_HEIGHT-height,false)
draw_rectangle(0,0,VIEW_WIDTH,height,false)

draw_rectangle(VIEW_WIDTH,0,VIEW_WIDTH-width,VIEW_HEIGHT,false)
draw_rectangle(0,0,width,VIEW_HEIGHT,false)

draw_set_color(c_white)