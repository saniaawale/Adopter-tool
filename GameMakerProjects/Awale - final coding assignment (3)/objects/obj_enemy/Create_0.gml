fire_timer =120; // for four secs
pspeed = 2
function fire_bullets(){
	position_x =x;
	position_y = y;
	var bullet_instance = instance_create_layer(position_x , position_y ,"Instances", obj_bullet_enemy);
	bullet_instance.vspeed = 10;
	if (pspeed == 2){
	bullet_instance.hspeed = 2;
	}
	if (pspeed == -2){
	bullet_instance.hspeed = -2;
	}
	
}
