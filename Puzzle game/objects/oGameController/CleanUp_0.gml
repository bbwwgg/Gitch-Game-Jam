//ds_grid_destroy()

while array_length(level_selecton) > 0{
	ds_grid_destroy(array_pop(level_selecton).levels)
}