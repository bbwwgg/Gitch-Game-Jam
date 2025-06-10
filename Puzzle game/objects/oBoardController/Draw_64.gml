var y_offset = (VIEW_HEIGHT - GUI_SEQUENCE_HEIGHT)/2
var x_offset = VIEW_WIDTH-GUI_SEQUENCE_WIDTH

var _width = GUI_SEQUENCE_WIDTH
var _height = GUI_SEQUENCE_HEIGHT

draw_rectangle(x_offset,y_offset,x_offset+_width,y_offset+_height,true)


//TODO THIS WILL LOOK UGLY, MOVE TO TOP OF SCREEN

//Sequence
var _sequence_len = array_length(global.sequence)

//Box for clover
var _scale = _width*0.65/sprite_get_width(sClover)

draw_sprite_ext(sClover,0,x_offset+(_width*0.35) / 2,y_offset,_scale,_scale,0,c_white,1)
var _sprite_height = sprite_get_height(sClover)*_scale

var _sequence_y_offset= y_offset + _sprite_height
var _sequence_max_height = _height - _sprite_height

var _sequence_number_box_height = _sequence_max_height/_sequence_len
for(var i = 0; i < _sequence_len; i ++){
	draw_rectangle(x_offset,_sequence_y_offset+_sequence_number_box_height * (i),x_offset+_width,_sequence_y_offset+_sequence_number_box_height * (i+1), true)
}