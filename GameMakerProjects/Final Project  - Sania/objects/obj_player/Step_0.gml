if (keyboard_check(vk_up) || keyboard_check(ord("W"))){
	if (! instance_place(x,y - p_speed,obj_wall)){
	y-=p_speed
	}else{
	y-=0;
	}
	
}
if (keyboard_check(vk_down) || keyboard_check(ord("S"))){
	if (!instance_place(x,y+p_speed,obj_wall)){
	y+=p_speed
	} else{
	y += 0;
	}
	
}
if (keyboard_check(vk_left) || keyboard_check(ord("A"))){
	if (!instance_place(x-p_speed,y,obj_wall)){
	x-=p_speed
	}else{
	x -= 0;
	}
	
}
if (keyboard_check(vk_right) || keyboard_check(ord("D"))){
	if (!instance_place(x+p_speed,y,obj_wall)){
	x+=p_speed
	}else{
	x += 0;
	}
	
}

x = clamp(x, 0, room_width - sprite_width);
y = clamp(y, 0, room_height - sprite_height);

// Damage cooldown timer for each enemy
if (place_meeting(x,y,obj_enemy1)){
		
	if (damage_cooldown <= 0){
			p_health -= 10;
			damage_cooldown = cooldown;
		}
}

if (damage_cooldown>0){
	damage_cooldown--;
}

if (place_meeting(x,y,obj_enemy2)){
		
	if (damage_cooldown <= 0){
			p_health -= 10;
			damage_cooldown = cooldown;
		}
}

if (damage_cooldown>0){
	damage_cooldown--;
}


if (place_meeting(x,y,obj_enemy3)){
		
	if (damage_cooldown <= 0){
			p_health -= 10;
			damage_cooldown = 60;
		}
}

if (damage_cooldown>0){
	damage_cooldown--;
}


if (keyboard_check_pressed(vk_space) && mana >= 1) {
    // Determine the direction the player is facing
    var bullet_direction = 0;  // Default: right
    if (image_xscale < 0) {  // Assuming image_xscale determines facing direction
        bullet_direction = 180;  // Left
    }

    // Create the bullet slightly offset from the player's position
    var bullet = instance_create_depth(x + sprite_width/2 , y + sprite_height/2, -1, obj_bullet);
    bullet.direction = bullet_direction;  // Set bullet direction
    bullet.speed = 10;  // Set bullet speed
	mana -= 1;
}


if (p_health <= 0){
	room_goto(game_over)
}