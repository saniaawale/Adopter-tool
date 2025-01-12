// Collision with the player
if (place_meeting(x, y + 1, obj_player)) {
    // If the player is falling onto the enemy (i.e., jumping on top of it)
    if (obj_player.vspeed > 0) {
        // Destroy the enemy when the player lands on it
        instance_destroy();  // Destroy the enemy
        // Add any extra effects or points if needed
    }
} else if (place_meeting(x - sprite_width / 2, y, obj_player) || place_meeting(x + sprite_width / 2, y, obj_player)) {
    // If the player collides with the enemy from the side (left or right)
    game_restart();  // Restart the level if the player touches the enemy from the side
}
