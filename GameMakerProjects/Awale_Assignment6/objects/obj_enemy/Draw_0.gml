// Draw Event (obj_enemy)
if (is_alive) {
    // Draw enemy's HP bar and stats
    draw_self();  // Draw the enemy sprite
    draw_text(x, y - 20, "HP: " + string(hp) + "/" + string(max_hp));  // Display HP
	draw_text(x, y - 40, "Name: " + string(id) );  // Display HP
}