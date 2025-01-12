player_gravity=0.5
jump_speed=-15 //jump speed would be nagetive as it moves obj upward
player_speed=5; //players horizontal speed
acceleration=0.2;

if (keyboard_check(ord("A"))) {
    if (!place_meeting(x - player_speed, y , obj_barrier)) {
        x -= player_speed;  // Move left if no collision
    }
}
if (keyboard_check(ord("D"))) {
    if (!place_meeting(x + player_speed, y, obj_barrier)) {
        x += player_speed;  // Move right if no collision
    }
}

if (!place_meeting(x, y , obj_ground) && !place_meeting(x, y , obj_barrier)) {
    vspeed += player_gravity;  // Apply gravity when the player is in the air
} else {
     
    if (vspeed > 0) {
        vspeed = 0;  // Prevent the player from falling through the ground
        
    }
}

if (keyboard_check(vk_space)&& (place_meeting(x,y,obj_ground)||place_meeting(x,y,obj_barrier))){
	vspeed=jump_speed;
}

if (place_meeting(x,y,obj_goal)){
	room_goto(Room2);
}

