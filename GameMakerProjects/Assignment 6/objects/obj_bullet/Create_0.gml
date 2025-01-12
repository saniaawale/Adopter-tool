bullet_speed = 10;


function fire_to_player(){
	var player = instance_find(obj_player,0);
	var selected_enemy = obj_enemy.enemies_list[obj_menu.selected];
	bullet_obj = instance_create_layer(player.x,player.y,"Instances",obj_bullet);
	move_towards_point(selected_enemy.x+sprite_width/2,selected_enemy.y+sprite_height/2,bullet_speed)
}

function fire_to_enemy(enemy){
	if (enemy != noone) {
        // Create the bullet at the enemy's position
        var bullet = instance_create_layer(enemy.x, enemy.y, "Instances", obj_bullet);
        
        // Move the bullet towards the player
        var bullet_speed = 5; // Define your bullet speed (adjust as needed)
        bullet.move_towards_point(player.x + sprite_width / 2, player.y + sprite_height / 2, bullet_speed);
	}
}