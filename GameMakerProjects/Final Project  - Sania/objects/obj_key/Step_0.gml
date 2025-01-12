
if (obj_player.gems >= 50){
	visible = true;  //Reveal key
}

// Check if the player collects the key
if (visible && place_meeting(x, y, obj_player)) {
    obj_player.has_key = true; // Player gets the key
    instance_destroy();        // Remove the key
}

