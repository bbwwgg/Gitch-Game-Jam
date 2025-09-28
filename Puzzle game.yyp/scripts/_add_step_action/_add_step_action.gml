function _add_step_action(_action, _inst = id){
    while (array_length(oPlayerController._update_list) <= _inst.update_step) {
        array_push(oPlayerController._update_list, []);
    }
	
	array_push(oPlayerController._update_list[_inst.update_step],[_inst,_action])
	_inst.update_step ++ 
}