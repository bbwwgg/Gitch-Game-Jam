
function play_music(_sound) {
    if (global.music_id != noone) {
        audio_stop_sound(global.music_id);
    }
    global.music = _sound;
    global.music_id = audio_play_sound(global.music, 1, true); // Looping = true
    audio_sound_gain(global.music_id, global.music_volume, 0);
    global.music_paused = false;
}

function pause_music() {
    if (global.music_id != noone && !global.music_paused) {
        audio_pause_sound(global.music_id);
        global.music_paused = true;
    }
}

function resume_music() {
    if (global.music_id != noone && global.music_paused) {
        audio_resume_sound(global.music_id);
        global.music_paused = false;
    }
}

function set_music_volume(_vol) {
    global.music_volume = clamp(_vol, 0, 1);
    if (global.music_id != noone) {
        audio_sound_gain(global.music_id, global.music_volume, 0);
    }
}
