#macro TILE_SIZE 32



enum MAP_DATA{
	ENTITY, //Enity on tile.
	OBJECT, // object on tile
	TILE, //sprite for ground
	COUNT	
}

enum ENITITY{
	EMPTY,
	PLAYER,
	FLAG,
	BOX,
	LOCK,
	STOP_LOCK,
	WHISP,
	LUCK_BLOCK,
	COUNT
}