

// Create obj_dataCarrier if it doesn't exist
if (!instance_exists(obj_dataCarrier)) {
 instance_create_depth(0, 0, 0, obj_dataCarrier);
}



// Check gems_collected and if player has key and unlock the door if conditions are met
if (!unlocked && instance_exists(obj_dataCarrier)) {
    if (obj_player.gems >= 50 && obj_player.has_key) {
        unlocked = true;  // Mark the door as unlocked
        sprite_index = s_door_open;  // Change the door's sprite
        show_debug_message("KEY APPEARED AND DOOR UNLOCKED");
    }
}

// Check if the door is unlocked and the player is interacting with it
if (unlocked && place_meeting(x, y, obj_player)) {
    show_debug_message("Player reached the unlocked door!");
    room_goto(Victory);  // Go to the Victory room
}

