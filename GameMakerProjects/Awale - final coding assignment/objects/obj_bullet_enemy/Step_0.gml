if (instance_place(x,y,obj_player) || instance_place(x,y,obj_bullet_player)){
	
	instance_destroy();
	
	with (obj_player){
		
		instance_destroy();
	}
}