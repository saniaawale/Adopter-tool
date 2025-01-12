


if (instance_place(x, y, obj_player)) {
   
        obj_player.gems++;
		with (obj_player) {
			gems_collected += 1;  // Update collected gems
		}
		instance_destroy();  // Destroy the gem
        
}

