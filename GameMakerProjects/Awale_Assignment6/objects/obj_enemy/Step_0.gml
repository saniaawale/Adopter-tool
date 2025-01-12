for (var i = 0; i < 3; i++){
	var inst = instance_create_layer(1366, 768 +( i * 20), "Instances",obj_enemy)
	array_push(global.enemies_list, inst.id);
}

// Step Event (obj_enemy)
if (!is_alive){
	for (var i =0; i < array_length(global.enemies_list); i++){
		
	}
	return;  // Skip turn if the enemy is defeated
}
if (is_turn) {
    // Randomly choose a target (player character)
    var player_obj = instance_find(obj_player,0); // Add player objects to this array
    

    // Deal damage to the selected target
		
        var damage = irandom_range(attack_power - 2, attack_power + 2);
        target.hp -= damage;  // Subtract damage from the player's HP

        // Log the attack (for debugging or feedback)
        show_message("Enemy attacked " + string(target) + " for " + string(damage) + " damage!");

        // Check if the player is defeated
        if (target.hp <= 0) {
            target.hp = 0;  // Prevent negative HP
            show_message("Player defeated!");
        }
    

    // End enemy's turn
    is_turn = false;  // Enemy's turn ends
    instance_find(obj_player, 0).is_turn = true;  // Pass turn back to the player
}
