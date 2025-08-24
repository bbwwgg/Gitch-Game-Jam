
on_enter = true

time = 0
wisp_release_delay = 30


player_instance[0] = noone
player_count = 0
current_player_index = 0

wisp_count = 0
wisp_instance[0] = noone
wisp_follow[0] = []

var _count = instance_number(pEntity)

for(var _i = 0; _i < _count; _i ++){
	var _inst = instance_find(pEntity,_i)
	
	switch _inst.entity_id{
		case ENITITY.PLAYER:
			player_instance[player_count] = _inst
			wisp_follow[player_count] = []

			player_count ++
		break
		
		case ENITITY.WHISP:
			wisp_instance[wisp_count] = _inst
			wisp_count ++
			
		break
	}

	
	
}




state = player_on_board

player_input = true

