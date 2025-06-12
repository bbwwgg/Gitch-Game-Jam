function interact_lock(){
	
	var _luck = global.luck_system.use()
	
	if _luck <= 4{
		moveable = true
		interactable = false
	}else{
		interactable = false
		stop = false
		visible = false
	}
	
}