// Check if the player is overlapping with the health boost
var inst = instance_place(x, y, obj_player);

if (inst != noone) {
    // Check if the health has not already been collected
        instance_destroy();
        
        inst.p_health = min(100,inst.p_health+10)
        
    }
