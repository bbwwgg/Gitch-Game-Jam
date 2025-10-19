function add_to_entity_map(_entity){
	
	var xTile = _entity.xTile
	var yTile = _entity.yTile
	
	var _id = _entity.id
	
	with oPlayerController{
		
		var _arr = entity_map[# xTile, yTile]
		
		if is_array(_arr){
			
			var _val = _entity.entity_id
			var _insert_at = array_length(_arr)
			
			var _prio = -1
			
			//If this entity was here previously we add it to the front as it needs to be checked first
			if(_entity.xTile == _entity.xPrev and _entity.yTile == _entity.yPrev) {
				_insert_at = 0
		   }else{
				for(var i = _insert_at - 1; i >= 0; i --){
					var _e = _arr[i]
					if _e.entity_id > _val and (_e.xTile != _e.xPrev || _e.yTile != _e.yPrev){
						_insert_at = i
					}else{
						break	
					}
				}
				
				_prio = _arr[0].entity_id
			}
			
			array_insert(_arr,_insert_at,_id)
			
			entity_map[# xTile, yTile] = _arr
			
			ds_priority_add(_conflict_list,[xTile,yTile],_prio)
		}else{		
			entity_map[# xTile, yTile] = [_id]
			
			//Falling
			if global.board[# xTile, yTile] [MAP_DATA.TILE] = noone{
				ds_priority_add(_conflict_list,[xTile,yTile],0)
			}
		
		}
	}
}