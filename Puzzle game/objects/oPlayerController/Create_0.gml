
player_instance[0] = noone
player_count = 0


var _count = instance_number(pEntity)

for(var _i = 0; _i < _count; _i ++){
	var _inst = instance_find(pEntity,_i)
	
	if _inst.entity_id = ENITITY.PLAYER{
		player_instance[player_count] = _inst
		player_count ++
	}
}

state = noone


