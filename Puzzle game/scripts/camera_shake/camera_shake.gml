/// @function camera_shake(strength)
/// @param strength  The intensity of the shake
function camera_shake(_strength, _decay = 0.9) {
    
	if !instance_exists(oCamera){ return }
	
	oCamera.shake_decay = _decay
	oCamera.shake_strength = _strength;
}