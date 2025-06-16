// Create a particle system and emitter
part_sys = part_system_create();
part_system_depth(part_sys, depth);

emitter = part_emitter_create(part_sys);

// Create the particle type
part = part_type_create();
part_type_shape(part, pt_shape_pixel);
part_type_size(part,4, 6, -0.1, 0);
part_type_color2(part, c_black,c_black);
part_type_alpha3(part, 1, 1, 0); 
part_type_life(part, 40, 45);
part_type_speed(part, 3, 6, -0.2, 0);
part_type_direction(part, 0, 360, 0, 0);


// Burst from center
var px = x + TILE_SIZE/2;
var py = y + TILE_SIZE/2;
part_emitter_region(part_sys, emitter, px, px, py, py, ps_shape_rectangle, ps_distr_linear);
part_emitter_burst(part_sys, emitter, part, 20); // Number of particles

alarm[0] = 60