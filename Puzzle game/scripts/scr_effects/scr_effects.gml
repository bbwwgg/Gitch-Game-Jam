function ease_linear(t, b, c, d){
	t/=d
	return c*t + b
}

function ease_in(t,b,c,d){
	t/=d
	return c*t*t*t+b
}

function ease_out(t,b,c,d){
	t/=d
	return -c *t*(t-2) + b
}

function ease_in_out(t,b,c,d){
	t /=d/2
	if (t < 1) return c/2*t*t + b
	t--
	return -c/2 * (t * (t-2) - 1) + b
}

function ease_out_elastic(t,b,c,d, bounce = .4){
	var s = 1.7
	var p = 0
	var a = c
	if (t==0) return b;
	t/=d
	if (t ==1) return b+c;
	if (!p) p =d*bounce
	if (a < abs(c)){
		a=c
		s=p/4
	}else{
		s = p/(2*pi)*arcsin(c/a)	
	}
	
	return a*power(2,-10*t)*sin((t*d-s)*(2*pi)/p)+c+b
}