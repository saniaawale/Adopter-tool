// Check collision with obj_enemy1
if (place_meeting(x, y, obj_enemy1)) {
    var enemy = instance_place(x, y, obj_enemy1);  // Find the specific enemy instance
    if (enemy != noone) {
        with (enemy) {
            enemy_health -= 10;  // Reduce health of the specific enemy
        }
    }
    instance_destroy();  // Destroy the bullet after hitting an enemy
}

// Check collision with obj_enemy2
if (place_meeting(x, y, obj_enemy2)) {
    var enemy = instance_place(x, y, obj_enemy2);  // Find the specific enemy instance
    if (enemy != noone) {
        with (enemy) {
            enemy_health -= 10;  // Reduce health of the specific enemy
        }
    }
    instance_destroy();  // Destroy the bullet after hitting an enemy
}