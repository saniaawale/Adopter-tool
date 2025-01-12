if (keyboard_check_pressed(ord("W")) && y - global.size_cell >= 0) {
    y -= global.size_cell;
	player_moved = true;
	player_health = min(player_health + 1,100); // Regenerate health by one at each move, capping it at 1000
}
if (keyboard_check_pressed(ord("S")) && y + global.size_cell <= (room_height - sprite_height)) {
    y += global.size_cell;
	player_moved = true;
	player_health = min(player_health + 1,100);
	
}
if (keyboard_check_pressed(ord("A")) && x - global.size_cell >= 0) {
    x -= global.size_cell;
	player_moved = true;
	player_health = min(player_health + 1,100);
}
if (keyboard_check_pressed(ord("D")) && x + global.size_cell <= (room_width - sprite_width)) {
    x += global.size_cell;
	player_moved = true;
	player_health = min(player_health + 1,100);
}

if (player_moved) {
    // Handle interaction with enemies
    var enemy = instance_place(x, y, obj_enemy);
    if (enemy != noone) {
        // Combat interaction
        player_health -= enemy.enemy_attack;
        enemy.enemy_health -= player_attack;

        enemy.is_attacked = true;

        // Player health check
    if (player_health <= 0) {
        room_goto(game_over);
    }
	
	if (enemy.enemy_health <= 0) {
            // Get the enemy's grid position
            var ex = enemy.x / global.size_cell;
            var ey = enemy.y / global.size_cell;

            // Update the grid to clear the enemy's position
            grid[ex, ey] = 0;

            // Remove the enemy from the enemies array
            for (var i = array_length(global.enemies) - 1; i >= 0; i--) {
                if (global.enemies[i].instance == enemy) {
                    array_delete(global.enemies, i, 1); // Remove the enemy from the array
                    break;
                }
            }

            // Destroy the enemy instance
            instance_destroy(enemy);

            // Move the player to the enemy's position
            x = ex * global.size_cell;
            y = ey * global.size_cell;
	}
	

        }
}



