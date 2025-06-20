number_of_orbiters = 6
orbit_radius_x = 0
orbit_radius_y = 0

orbit_radius_x_max = 40
orbit_radius_y_max = 20

time_to = 25
time = 0

rise_time = 0
		

rise_time_to = 30
if room == level_final{
	rise_time_to = 300
	instance_create_layer(0,0,"effects",oThanks)
}
delay = 5

explode = false



orbit_speed = 2

center_x = x
center_y = y

y_offset =0 

angle_offset = 0

orbit_sprite = sWisp

image_speed = 0
image_index = 3

stop = true

depth = -999