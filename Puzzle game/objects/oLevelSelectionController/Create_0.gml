tile_width = sprite_get_width(sLevel)
tile_height = sprite_get_width(sLevel)

cursor_pos_x = 0
cursor_pos_y = 0

cursor_x = 0
cursor_y = 0


start_x = cursor_pos_x
start_y = cursor_pos_y
dest_x = start_x
dest_y = start_y

progress = 1.05

current_map = noone


function ease_overshoot(_start, _end, _t, _s = 1.70158) {
	var c = _end - _start;
	var t = _t - 1;
	return c * (t * t * ((_s + 1) * t + _s) + 1) + _start;
}