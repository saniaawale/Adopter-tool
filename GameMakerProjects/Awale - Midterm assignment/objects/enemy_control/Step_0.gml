
var player = instance_find(obj_player, 0); // Assuming one player


if (player.player_moved) {
    for (var i = array_length(global.enemies) - 1; i >= 0; i--) {
    if (i >= array_length(global.enemies)) {
        // Skip if the index is no longer valid
        continue;
    }

    if (instance_exists(global.enemies[i].instance)) {
        // Update enemy behavior
        move_enemy(global.enemies[i]);
    } else {
        // Remove invalid entries
        array_delete(global.enemies, i, 1);
    }

	}
    player.player_moved = false; // Reset after moving enemies
}






