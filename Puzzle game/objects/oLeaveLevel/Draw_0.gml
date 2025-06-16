if explode{ return}

// 1. Draw the back half first
for (var i = 0; i < number_of_orbiters; i++) {
	var angle = angle_offset + (360 / number_of_orbiters) * i;
	var normalized_angle = angle mod 360;

	if (normalized_angle > 90 && normalized_angle < 270) {
		var ox = center_x + lengthdir_x(orbit_radius_x, angle);
		var oy = center_y + lengthdir_y(orbit_radius_y, angle);
		var dir = 0;
		var a = angle mod 360;

		if (a >= 45 && a < 135) {
		    dir = 3; // Up
		} else if (a >= 135 && a < 225) {
		    dir = 0; // Left
		} else if (a >= 225 && a < 315) {
		    dir = 1; // Down
		} else {
		    dir = 2; // Right
		}

		draw_sprite(orbit_sprite, dir, ox, oy);
	}
}

// 2. Draw the object/person in the middle
draw_sprite(sprite_index,image_index,x,center_y)

// 3. Draw the front half
for (var i = 0; i < number_of_orbiters; i++) {
	var angle = angle_offset + (360 / number_of_orbiters) * i;
	var normalized_angle = angle mod 360;

	if (normalized_angle <= 90 || normalized_angle >= 270) {
		var ox = center_x + lengthdir_x(orbit_radius_x, angle);
		var oy = center_y + lengthdir_y(orbit_radius_y, angle);
		var dir = 0;
		var a = angle mod 360;

		if (a >= 45 && a < 135) {
		    dir = 3; // Up
		} else if (a >= 135 && a < 225) {
		    dir = 0; // Left
		} else if (a >= 225 && a < 315) {
		    dir = 1; // Down
		} else {
		    dir = 2; // Right
		}

		draw_sprite(orbit_sprite, dir, ox, oy);
	}
}