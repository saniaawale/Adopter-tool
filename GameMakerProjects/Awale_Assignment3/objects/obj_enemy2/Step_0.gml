// Moving up and down
vspeed = 3;  // Vertical speed of the flying enemy
if (y <= 0 || y >= room_height - sprite_height) {
    vspeed = -vspeed;  // Change direction when reaching the top or bottom
}

// Move in the opposite direction of the player horizontally
if (obj_player.x < x) {
    x += 2;  // Move right if the player is to the left
} else if (obj_player.x > x) {
    x -= 2;  // Move left if the player is to the right
}

// Update vertical position
y += vspeed;
