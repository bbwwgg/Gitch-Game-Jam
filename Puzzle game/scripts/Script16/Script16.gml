function ease_overshoot(_start, _end, _t, _s = 1.70158) {
	var c = _end - _start;
	var t = _t - 1;
	return c * (t * t * ((_s + 1) * t + _s) + 1) + _start;
}