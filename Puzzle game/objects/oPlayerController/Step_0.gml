if  keyboard_check_pressed(ord("Z")){
	oBoardController.undo_board_state()
}

if  keyboard_check_pressed(ord("R")){
	room_restart()
}

//Check if any players are active
for(var i = 0; i < player_count; i ++){
	var _player = player_instance[i]
	if player_instance[i].interactable{
		break
	}
}
if i = player_count{
	show_debug_message("No more players")
	exit	
}



var h = keyboard_check_pressed(ord("D"))-keyboard_check_pressed(ord("A")) 
var v = keyboard_check_pressed(ord("S"))-keyboard_check_pressed(ord("W")) 

var dir = -1


if (h != 0) {
    dir = (h == 1) ? 0 : 2; // 0 = right, 2 = left
}
else if (v != 0) {
    dir = (v == -1) ? 1 : 3; // 1 = up, 3 = down
}


if dir != -1{
	oBoardController.save_board_state()
	for(var i = 0; i < player_count; i ++){
		var _player = player_instance[i]
		if player_instance[i].interactable{
			move(player_instance[i], dir)
		}
	}
}


