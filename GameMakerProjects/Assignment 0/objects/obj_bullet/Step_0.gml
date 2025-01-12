
y -= speed; // moving in the negative y direction
if ( y < 0){
	instance_destroy(); // bullet destroyed when it moves off screen
}

var enemy = instance_place(x, y, obj_enemy);  // Check for collision with obj_enemy

if (enemy != noone) {
    instance_destroy();  // Destroy the bullet itself
    
    with (enemy) {
        instance_destroy();  // Destroy the enemy that collided with the bullet
    
	
	}
	
}
