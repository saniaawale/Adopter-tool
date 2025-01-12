// Starting direction
x+=player_speed;

if (keyboard_check_pressed(vk_space)){
	player_speed = -player_speed;
	fire_bullets();
}

if (x > room_width) {
	x = 0;
}
if (x < 0) {
	x = room_width;
}

var collision_destroy1 = instance_place(x,y,obj_enemy);

var collision_destroy2 =  instance_place(x,y,obj_bullet_enemy);

if (collision_destroy1 != noone || collision_destroy2 != noone){
	instance_destroy()
}

