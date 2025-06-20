enum HELP_STATE{
	FIRST_APPEAR,
	ENTER,
	IDLE,
	EXIT,
	HIDDEN,
	ALERT
}

draw = false

entity_index = array_create(ENITITY.COUNT,-1)

entity_index[ENITITY.PUSH_UP] = 3
entity_index[ENITITY.PUSH_DOWN] = 3
entity_index[ENITITY.PUSH_RIGHT] = 3
entity_index[ENITITY.PUSH_LEFT] = 3
entity_index[ENITITY.LOCK] = 2
entity_index[ENITITY.LUCK_BLOCK] = 4

unlocked_tips = array_create(sprite_get_number(sTutorialReminder), false)

unlocked_tips[0] = true

updated_tips = 0


#macro TUTORIAL_WIDTH VIEW_WIDTH*0.7

tutorial_scale = TUTORIAL_WIDTH/sprite_get_width(sTutorialReminder)

tutorial_w = tutorial_scale*sprite_get_width(sTutorialReminder)
tutorial_h = tutorial_scale*sprite_get_height(sTutorialReminder)

time = 0
read_delay = 60

wobble_time = 0
angle = 0

image_speed = 0

page = 0

image_alpha = 0
y_to = 0
x_to = 0

mid_y = VIEW_HEIGHT/2 
mid_x = VIEW_WIDTH/2 

x_start = mid_x
y_start = VIEW_HEIGHT+tutorial_h/2



tutorial_x = x_start
tutorial_y = y_start

first_open = true

move_time = 0
time_to = 15

arrow_time = 0
tutorial_angle = 0

book_alpha = 1

function is_empty(){
	for(var i = 0; i < array_length(unlocked_tips); i ++){
		if unlocked_tips[i] != false{
			return false	
		}
	}
	return true
}



function switch_state(_state){
	image_angle = 0
	
	switch(state){
		case HELP_STATE.FIRST_APPEAR:
			if instance_exists(oPlayerController){ 		oPlayerController.player_input = true }
		break
		case HELP_STATE.ALERT:
			wobble_time = 0
			angle = 0
		break
	}

	switch(_state){
		case HELP_STATE.IDLE:
		break
		case HELP_STATE.ENTER:
			
			play_sfx(sfxPaper)
			
			if updated_tips != noone{
				page = updated_tips
				updated_tips = noone
			}
			
			x_start = tutorial_x
			y_start = tutorial_y
			
			x_to = mid_x
			y_to = mid_y
			move_time = 0
			image_index = 1
		break	
		case HELP_STATE.EXIT:
			
			x_start =tutorial_x
			y_start =tutorial_y 
			
			x_to = mid_x
			y_to = VIEW_HEIGHT
			move_time = 0
			image_index = 0
		break	
	}
	
	
	state = _state
}

function activate(){
	switch (state){
		case HELP_STATE.ENTER:
		case HELP_STATE.IDLE:
			switch_state(HELP_STATE.EXIT)
		break
		case HELP_STATE.EXIT:
		case HELP_STATE.HIDDEN:
		case HELP_STATE.ALERT:
			switch_state(HELP_STATE.ENTER)
		break
	}
}

function mouse_on(){
	
	var _mousex = device_mouse_x_to_gui(0)
	var _mousey = device_mouse_y_to_gui(0)

	return point_in_rectangle(_mousex,_mousey,x_offset-width/2,y_offset-height/2,x_offset+width/2,y_offset+height/2)
	
}


scale = 5
min_scale = 5
max_scale = 20



width = sprite_get_width(sBook)*scale
height = sprite_get_height(sBook)*scale

y_offset = VIEW_HEIGHT-height/2
x_offset = width*0.7

book_x = x_offset
book_y = y_offset
book_x_dest = x_offset
book_y_dest = y_offset

state = HELP_STATE.ALERT
switch_state( HELP_STATE.ALERT)