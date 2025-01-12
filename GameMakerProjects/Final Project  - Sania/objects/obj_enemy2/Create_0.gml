enemy_speed = 3;
enemy_health = 50;
original_positionx = x
original_positiony = y

// Range within which the enemy will start chasing the player
chase_range = 150;

// Speed of the enemy while chasing
chase_speed = 2;

// Reference to the player object (e.g., obj_player1)
target_player = noone;

// State tracking: whether the enemy is chasing or idle
is_chasing = false;