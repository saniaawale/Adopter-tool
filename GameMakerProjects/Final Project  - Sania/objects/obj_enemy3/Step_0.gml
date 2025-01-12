// Calculate the distance to the player
var dist_to_player = point_distance(x, y, obj_player.x, obj_player.y);

// Check if the player is within chase range
if (dist_to_player <= chase_range) {
    // Move towards the player
    var angle_to_player = point_direction(x, y, obj_player.x, obj_player.y);
    x += lengthdir_x(chase_speed, angle_to_player);
    y += lengthdir_y(chase_speed, angle_to_player);
    
   
} else {
 //upon collision with wall stop
	if (instance_place(x,y,obj_wall)){
				x+=0 
	
	}
}

// Check for collision with bullets and reduce health
if (place_meeting(x, y, obj_bullet)) {
    var bullet = instance_place(x, y, obj_bullet);
    if (bullet != noone) {
        enemy_health -= 10;  // Reduce health when hit by bullet
        instance_destroy(bullet);  // Destroy the bullet after hit
    }
}

// Destroy the enemy if health reaches zero
if (enemy_health <= 0) {
    instance_destroy();  // Destroy the enemy when health is zero
}
