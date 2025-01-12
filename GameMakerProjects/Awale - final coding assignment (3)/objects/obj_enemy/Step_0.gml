
y += 2;


if (y > room_height) {
	y = 0;
}


if (x <= 0 || x>= room_width - sprite_width) {
	pspeed = -pspeed
}

x+= pspeed

fire_timer -= 1;

if (fire_timer <= 0){
	fire_bullets();
	fire_timer = 120;
	
	
if (instance_place(x,y,obj_player) ){
	instance_create_layer(random(room_width),0, "Instances", obj_enemy)
	instance_create_layer(random(room_width)+100,0, "Instances", obj_enemy)
	instance_destroy();
	
	with(obj_player){
		instance_destroy()
	}
}

// i tried to do somthing but 

if (instance_place(x,y,obj_bullet_player)){
	instance_create_layer(random(room_width),0, "Instances", obj_enemy)
	instance_create_layer(random(room_width)+100,0, "Instances", obj_enemy)
	instance_destroy();
	with(obj_bullet_player){
		instance_destroy()
}

}
}