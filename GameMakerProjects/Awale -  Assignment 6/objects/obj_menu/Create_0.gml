main_options = ["Attack","Magic","Item"];

item_options = ["HP+"];
selected = 0;
menu_state = "main menu";
main_menu_state = noone; 
target_menu_state = noone;
item_menu_state = noone;
pointer = noone;
max_hp = 100;
menu_length = 0;

global.enemies_list = [];


for (var i = 0; i < 3; i++){
	var inst = instance_create_layer(800, 150 +( i * 200), "Instances",obj_enemy)
	array_push(global.enemies_list, inst.id);
}

function shoot_enemy(enemy) {
    // Create the bullet instance
    var bullet = instance_create_layer(obj_player.x + sprite_width / 2, obj_player.y + sprite_height / 2, "Instances", obj_bullet);

    // Ensure the enemy exists before calculating direction
    if (instance_exists(enemy)) {
        // Set the bullet's direction towards the enemy
        var angle = point_direction(bullet.x, bullet.y, enemy.x, enemy.y);
        bullet.direction = angle;
        bullet.speed = 6; // Adjust speed as needed
	
    }
}

