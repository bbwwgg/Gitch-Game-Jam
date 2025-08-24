
time ++
if time <= time_to{
	image_alpha = ease_out(time,0,1,time_to)	
}
draw_sprite_ext(thanks,0,VIEW_WIDTH/2,VIEW_HEIGHT/2,5,5,sin(time*0.03)*15,c_white,image_alpha)