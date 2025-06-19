//ds_grid_destroy()

while array_length(level_selecton) > 0{
	var _cur = array_pop(level_selecton)
	if (struct_exists(_cur, "levels")) {
		ds_grid_destroy(_cur.levels)
	}
}