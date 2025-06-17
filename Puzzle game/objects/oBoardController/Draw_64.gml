if array_length(global.luck_system.sequence) = 0 return






var _width = GUI_SEQUENCE_WIDTH
var _height = GUI_SEQUENCE_HEIGHT

var x_offset = (VIEW_WIDTH-_width) /2 
var y_offset = 0

var _xscale = _width / GUI_HUD_INTERIOR_WIDTH
var _yscale = _height / GUI_HUD_INTERIOR_HEIGHT
draw_sprite_ext(sHud,0,x_offset,y_offset,_xscale,_yscale,0,c_white,1)



//draw_rectangle(,x_offset+_width,y_offset+_height,true)


//Sequence
var _sequence_len = array_length(global.luck_system.sequence)

var _sequence_x_offset= x_offset
var _sequence_max_width = _width

var _sequence_number_box_width = _sequence_max_width/_sequence_len

var _sequence_number_height = string_height("9")

var _sequence_number_scale = _height/_sequence_number_height
var y_center = _height/2 + _height*0.15
var x_center = (_sequence_number_box_width) / 2
	
draw_set_valign(fa_middle)
draw_set_halign(fa_center)

for(var i = 0; i < _sequence_len; i ++){
	
	var cur_num = (global.luck_system.sequence[i])
	
	draw_sprite_stretched(sHudDivider,0,x_offset+_sequence_number_box_width*(i),y_offset,_sequence_number_box_width,_height)
	
	if i = global.luck_system.index{
		draw_set_color(#e6904e)
	}else{
		draw_set_color(#2E222F)
	}
	
	if is_array(cur_num){
		cur_num = cur_num[0]
		var _line_y = y_offset+string_height(string(cur_num))*0.85* _sequence_number_scale
		var _line_x = x_offset+_sequence_number_box_width*(i)+x_center
		
		var _line_width = string_width(string(cur_num)) * _sequence_number_scale *0.7
		
		draw_line_width(_line_x-_line_width,_line_y, _line_x+_line_width, _line_y,_yscale)
	}
	
	draw_text_transformed(x_offset+_sequence_number_box_width*(i)+x_center,y_offset+y_center,cur_num,_sequence_number_scale,_sequence_number_scale,0)

}

draw_set_color(c_white)
if global.luck_system.index < array_length(global.luck_system.sequence){
	if luck_cursor_x_to != global.luck_system.index*_sequence_number_box_width+x_offset{
		luck_cursor_progress = 0	
		luck_cursor_x_start = luck_cursor_x
		luck_cursor_x_to = global.luck_system.index*_sequence_number_box_width+x_offset
	}

	if luck_cursor_progress <= 1{
		luck_cursor_x = ease_out(luck_cursor_progress,luck_cursor_x_start,luck_cursor_x_to-luck_cursor_x_start,1)	
	
		luck_cursor_progress += 0.05
	}

	draw_sprite_ext(sHudCursor,0,luck_cursor_x+x_center,y_offset,_xscale,_yscale,0,c_white,1)
}

