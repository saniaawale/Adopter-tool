y += enemy_speed //enemy behaviour

if ( instance_place(x,y + enemy_speed,obj_wall)){
	enemy_speed = -enemy_speed // bounces off walls
} 

if (enemy_health <= 0){
	instance_destroy(); //destroy enemy if health is out
}