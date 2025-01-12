x += enemy_speed

if ( instance_place(x + enemy_speed,y,obj_wall)){
	enemy_speed = -enemy_speed
}

if (enemy_health <= 0){
	instance_destroy();
}
