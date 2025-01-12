hp = irandom_range(30, 50);  // Enemy's health (randomized for variety)
max_hp = hp;                // Maximum health
attack_power = irandom_range(5, 10);  // Damage dealt by the enemy
is_alive = true;            // Enemy's status
target = noone;             // Target for attack (assigned during their turn)
is_turn = false;
global.enemies_list = [];