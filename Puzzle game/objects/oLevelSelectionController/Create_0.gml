tile_width = sprite_get_width(sLevel)
tile_height = sprite_get_width(sLevel)

cursor_pos_x = 0
cursor_pos_y = 0

cursor_x = 0
cursor_y = 0

lock_x = 0
lock_y = 0
lock_num = 0


start_x = cursor_pos_x
start_y = cursor_pos_y
dest_x = start_x
dest_y = start_y

progress = 1.05

current_map = noone

state = Player_selecting_level

levels_to_unlock = []

time = 0
delay = 30

spawn_delay = 15
time_to_top = 35
wisps = []
wisps_to_add = 0


wisps_collected = 0

wisp_scale = 5
wisps_w = sprite_get_width(sWisp)*wisp_scale
wisps_h = sprite_get_height(sWisp)*wisp_scale
wisp_collection_x = VIEW_WIDTH - wisps_w
wisp_collection_y = 10

draw_lock = false