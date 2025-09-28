function add_to_entity_map(_entity){
	
	var xTile = _entity.xTile
	var yTile = _entity.yTile
	
	var _id = _entity.id
		
	with oPlayerController{
		if is_array(entity_map[# xTile, yTile]){
			array_push(entity_map[# xTile, yTile],_id)
		
			var _smallest = _entity.entity_id
			for(var i = array_length(entity_map[# xTile, yTile]) - 2; i >= 0; i --){
				var _new = entity_map[# xTile, yTile][i].entity_id 
				if _new < _smallest{
					_smallest = _new
				}
			}
				
			ds_priority_add(_conflict_list,{inst_calling :_id,location : [xTile,yTile]},_smallest)
		}else{		
			entity_map[# xTile, yTile] = [_id]
			
			//Falling
			if global.board[# xTile, yTile] [MAP_DATA.TILE] = noone{
				ds_priority_add(_conflict_list,{inst_calling :_id,location : [xTile,yTile]},0)
			}
		
		}
	}
}