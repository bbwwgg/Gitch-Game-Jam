var y_offset = 0
var x_offset = (VIEW_WIDTH-GUI_SEQUENCE_WIDTH) /2 

var _width = GUI_SEQUENCE_WIDTH
var _height = GUI_SEQUENCE_HEIGHT

draw_rectangle(x_offset,y_offset,x_offset+_width,y_offset+_height,true)


//TODO THIS WILL LOOK UGLY, MOVE TO TOP OF SCREEN

//Sequence
var _sequence_len = array_length(global.luck_system.sequence)

var _sequence_x_offset= x_offset
var _sequence_max_width = _width

var _sequence_number_box_width = _sequence_max_width/_sequence_len

var _sequence_number_height = string_height("9")
var _sequence_number_scale = _height/_sequence_number_height

for(var i = 0; i < _sequence_len; i ++){
	
	var cur_num = string(global.luck_system.sequence[i])
	
	if i = global.luck_system.index{
		draw_set_color(c_black)
		draw_rectangle(x_offset+_sequence_number_box_width*(i),y_offset,x_offset+_sequence_number_box_width*(i+1),y_offset+_height, true)
		
		var x_center = (_sequence_number_box_width-string_width(cur_num)*_sequence_number_scale) / 2
		draw_text_transformed(x_offset+_sequence_number_box_width*(i)+x_center,y_offset,cur_num,_sequence_number_scale,_sequence_number_scale,0)
		draw_set_color(c_white)
	}else{
		draw_rectangle(x_offset+_sequence_number_box_width*(i),y_offset,x_offset+_sequence_number_box_width*(i+1),y_offset+_height, true)
		var x_center = (_sequence_number_box_width-string_width(cur_num)*_sequence_number_scale) / 2
		draw_text_transformed(x_offset+_sequence_number_box_width*(i)+x_center,y_offset,cur_num,_sequence_number_scale,_sequence_number_scale,0)
	}
}