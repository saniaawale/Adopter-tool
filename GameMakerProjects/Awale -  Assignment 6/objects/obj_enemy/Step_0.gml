
if (!is_alive){
	for (var i =0; i < array_length(global.enemies_list); i++){
		
	}
	return;  // skip the turn if enemy is defeated
}
if (is_turn) {
    
    //choose rando enemy and
    // create the bullet instance
	var rando_enemy = global.enemies_list[random(3)]
    var bullet = instance_create_layer(rando_enemy.x  + sprite_width / 2 , rando_enemy.y + sprite_height / 2, "Instances", obj_enemy_bullet);

  
    
        // Set the bullet direction toward the enemy
        var angle = point_direction(bullet.x, bullet.y, obj_player.x, obj_player.y);
        bullet.direction = angle;
        bullet.speed = 6; // Adjust speed as needed
		
		is_turn = false;  // enemy turn ends
	
    
}

 