function interact_wisp(){
	
	interactable = false
	stop = false
	delay = true
	
	visible = false

	camera_shake(3, 0.65) 
	instance_create_layer(x,y,"effects",oPart)

}