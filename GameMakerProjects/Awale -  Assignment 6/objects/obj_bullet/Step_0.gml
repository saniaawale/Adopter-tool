if (place_meeting(x,y,obj_enemy)){
	var enemy = instance_place(x,y,obj_enemy)
	instance_destroy()
	
	enemy.hp -=1;
	obj_enemy.is_turn = true; // this destroys bullet upon colliding with enemy and toggles enemy turn
	
}