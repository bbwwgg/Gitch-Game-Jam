function clone_deep_board(_src){
    var w = ds_grid_width(_src);
    var h = ds_grid_height(_src);
    var _dest = ds_grid_create(w, h);

    for (var yy = 0; yy < h; yy++) {
        for (var xx = 0; xx < w; xx++) {
            var val = _src[# xx, yy];

            // If the cell is an array, clone it
            if (is_array(val)) {
				_dest[# xx, yy] = []
				array_copy(_dest[# xx, yy], 0, val, 0, array_length(val))
            }
            else {
                _dest[# xx, yy] = val;
            }
        }
    }

    return _dest;
}
