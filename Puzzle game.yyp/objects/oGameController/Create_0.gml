map1 = {
	room_index : level_select 
}

map2 = {
	room_index : level_select2 
}




level_selecton = [ map1 , map2]

intro_level = level_select2



completed_level = false

tutorial = instance_create_layer(0,0,"Instances",oTutorialController)

wisp_count = 0

wisp_total = 0
world = map1.room_index

//Music
global.music = sndMusicMain;
global.music_volume = 0.5;
global.music_id = noone;
global.music_paused = DEBUG_MODE;
play_music(sndMusicMain);


set_music_volume(0.5);				
				