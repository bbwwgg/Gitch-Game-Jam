function transition(_room_to){
	
	if instance_exists(oTransition) { return false }
	
	with instance_create_depth(0,0,-999,oTransition){
		room_to =  _room_to
	}
	
	return true
	
}