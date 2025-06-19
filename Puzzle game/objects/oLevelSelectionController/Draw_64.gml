draw_sprite_ext(sWisp,3,wisp_collection_x,wisp_collection_y,wisp_scale,wisp_scale,0,c_white,1)

draw_set_valign(fa_middle)
draw_set_halign(fa_right)
draw_text_transformed(wisp_collection_x+50,wisp_collection_y+wisps_h/2+5,wisps_collected,wisp_scale,wisp_scale,0)

if array_length(wisps) > 0{
	for(var i =  array_length(wisps)-1; i >= 0; i --){
		
		var cur_wisp = wisps[i]
		
		if cur_wisp[0] = false{
			break	
		}
		
		draw_sprite_ext(sWisp,3,cur_wisp[1],cur_wisp[2],wisp_scale,wisp_scale,0,c_white,1)

	}
}