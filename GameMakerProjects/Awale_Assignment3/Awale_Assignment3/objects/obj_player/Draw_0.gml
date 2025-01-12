// Draw event for obj_player
draw_self();  // Draw the player sprite

// Display interaction message when near NPC
if (interaction_alan) {
    draw_text(x, y - 30, "Press Space to talk");
}

if (interaction_martha) {
    draw_text(x, y - 30, "Press Space to talk to Martha");
}