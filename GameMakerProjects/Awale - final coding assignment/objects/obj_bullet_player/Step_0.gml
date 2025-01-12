

if (instance_place(x,y,obj_enemy) || instance_place(x,y,obj_bullet_enemy)){
	instance_destroy();
	with (obj_enemy){
		instance_create_layer(random(room_width),0, "Instances", obj_enemy)
		instance_create_layer(random(room_width),0, "Instances", obj_enemy)
		instance_destroy();
	}
}