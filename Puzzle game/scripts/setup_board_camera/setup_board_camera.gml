function setup_board_camera(){
	
	//Find common factor between the width and height and set the corresponding margins
	var board_width = ((global.board_width + global.board_height) * (MAP_TILE_W * 0.5))
	var board_height= ((global.board_width + global.board_height) * (MAP_TILE_H * 0.5)) + LARGEST_SPRITE_HEIGHT

	var _board_margin_width = GUI_MAP_MARGIN / VIEW_WIDTH
	var _board_margin_top = (GUI_MAP_TOP_MARGIN) / VIEW_HEIGHT
	var _board_margin_bot = (GUI_MAP_BOT_MARGIN) / VIEW_HEIGHT 


	var ratio = clamp(max((board_width *(1+_board_margin_width*2)) div CAMERA_WIDTH_RATIO,(board_height *(1+_board_margin_top+_board_margin_bot)) div CAMERA_HEIGHT_RATIO),CAMERA_SMALLEST_FACTOR,VIEW_SIZE_RATIO) + 1


	var cam_width = CAMERA_WIDTH_RATIO * ratio 
	var cam_height = CAMERA_HEIGHT_RATIO * ratio

	_board_margin_top *= cam_height
	_board_margin_bot *= cam_height

	var _extra_width = max(0, cam_width - (board_width + _board_margin_width*2))
	var _extra_height = max(0, cam_height - (board_height + _board_margin_bot+_board_margin_top))

	global.camera_margin_width = _extra_width / 2 + _board_margin_width 
	global.camera_margin_height = _extra_height + (_board_margin_top) + LARGEST_SPRITE_HEIGHT

	camera_set_view_size(global.Camera,cam_width,cam_height)
	global.camera_max_width = cam_width
	global.camera_max_height = cam_height
	
	with oCamera{
		target_width  =	global.camera_max_width
		target_height = global.camera_max_height
		
		current_width =	global.camera_max_width
		current_height= global.camera_max_height
		
	}

}