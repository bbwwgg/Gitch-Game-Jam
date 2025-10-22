function __entity_data(){

_entity_data = array_create(ENITITY.COUNT)

// entity_data.gml
_entity_data[ENITITY.PLAYER] = {
        stop: true,
        sprite_index: sPlayerIdle,
        step_script: step_player
}

_entity_data[ENITITY.FLAG] = {
        stop: true,
        moveable: false,
        interact_script: interact_flag,
        sprite_index: sExit
}

_entity_data[ENITITY.BOX] = {
        stop: true,
        moveable: false,
        sprite_index: sBox,
        step_script: step_move
}

_entity_data[ENITITY.LOCK] = {
        stop: true,
        entity_var: -1,
        interact_script: interact_lock,
        sprite_index: sLock,
        image_speed: 0
}

_entity_data[ENITITY.STOP_LOCK] = {
        stop: true,
        entity_var: -1,
        interact_script: interact_lock,
        sprite_index: sLock,
        image_speed: 0
}

_entity_data[ENITITY.WHISP] = {
        stop: true,
        moveable: false,
        following: false,
        interact_script: interact_wisp,
        sprite_index: sWisp,
        image_speed: 0
}

_entity_data[ENITITY.LUCK_BLOCK] = {
        stop: true,
        moveable: true,
        entity_var: -1,
        interact_script: interact_luck,
        sprite_index: sLuck,
        image_speed: 0
}

_entity_data[ENITITY.PUSH_DOWN] = {
        stop: false,
        moveable: false,
        sprite_index: sPush,
        interact_script: interact_push,
        image_index_add: 1
}

_entity_data[ENITITY.PUSH_LEFT] = {
        stop: false,
        moveable: false,
        sprite_index: sPush,
        interact_script: interact_push,
        image_index_add: 1
}

_entity_data[ENITITY.PUSH_UP] = {
        stop: false,
        moveable: false,
        sprite_index: sPush,
        interact_script: interact_push,
        image_index_add: 1
}

_entity_data[ENITITY.PUSH_RIGHT] = {
        stop: false,
        moveable: false,
        sprite_index: sPush,
        interact_script: interact_push
    }


}