player_speed = 4;


function fire_bullets(){
	var bullet_instance = instance_create_layer(x , y ,"Instances", obj_bullet_player);
	bullet_instance.vspeed = -10;
	bullet_instance.hspeed = 0;
	
}

