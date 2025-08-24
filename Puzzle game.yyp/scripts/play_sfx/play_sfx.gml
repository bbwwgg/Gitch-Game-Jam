
function play_sfx(_snd_effect){
	var snd = _snd_effect; 
	var sfx_id = audio_play_sound(snd, 1, false);

	var pitch = random_range(0.9, 1.1)
	audio_sound_pitch(sfx_id, pitch);
}