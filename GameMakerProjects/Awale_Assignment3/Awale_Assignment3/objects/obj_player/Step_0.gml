


if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    x -= 4;  // Move left
}
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    x += 4;  // Move right
}
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
    y -= 4;  // Move up
}
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
    y += 4;  // Move down
}

interaction_alan = false;

var alan_x= alan_grier.x;
var alan_y= alan_grier.y;
var distance_to_alan=point_distance(x,y,alan_x,alan_y);

if(distance_to_alan <= 50){
	interaction_alan = true;
}

if (interaction_alan && keyboard_check(vk_space)){
	show_message("Hello you! You must be the investigator the mayor hired to investigate recent...happenings - in this neighbourhood..Anyway, for more information go to Martha Riddler. To go to hers, follow the path then take a left at the intersection ");
}
interaction_martha = false;  // Reset interaction status

// Check if the player is near Martha (use a proximity distance)
var npc_x = obj_martha.x;  // Martha's x-coordinate
var npc_y = obj_martha.y;  // Martha's y-coordinate
var distance_to_martha = point_distance(x, y, npc_x, npc_y);  // Calculate distance

if (distance_to_martha <= 50) {  // 50 is the interaction radius
    interaction_martha = true;  // Player is near Martha
	
}

if (interaction_martha && keyboard_check_pressed(vk_space)) {
    if (has_collected_item) {
        // After collecting the item (letter)
        show_message("Ah, you picked up the letter! Now, with this in hand, you should head over to the old mansion. It’s where your next lead awaits.");
    } else {
        // Before collecting the item (letter)
        show_message("Ah, investigator! I have the letter you need to move forward. Take it; it's important for your investigation.");
    }
}
