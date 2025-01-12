if (place_meeting(x,y,obj_player)){
	var player = instance_place(x,y,obj_player)
	instance_destroy()
	
	player.hp -=1/3;
	obj_player.is_turn = true; // this destroys bullet upon colliding with player and toggles player turn
	
}