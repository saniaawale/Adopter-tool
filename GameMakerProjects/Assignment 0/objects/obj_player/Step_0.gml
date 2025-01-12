

if (keyboard_check(ord("W")) || keyboard_check(vk_up)){ // up key or W to move up
    y -= player_speed;
}
if (keyboard_check(ord("A")) || keyboard_check(vk_left)){ // left key or A to move left
    x -= player_speed;
}
if (keyboard_check(ord("S")) || keyboard_check(vk_down)){  // to move down
    y += player_speed;
}
if (keyboard_check(ord("D")) || keyboard_check(vk_right)){  // to mpve right
    x += player_speed;
}
// for when sprite moves out of frame
if (x<0){ x=0; }
if (y<0){ y=0;}
if (x>room_width-sprite_width) { x= room_width - sprite_width; }
if (y> room_height - sprite_height) { y= room_height-sprite_height }


//spacebar to create instances of bullet
  if ( keyboard_check(vk_space) && bullet_timer <= 0) {
	var bullet = instance_create_depth(x+(sprite_width/2),y ,-2,obj_bullet);
	bullet_timer = bullet_delay; // reset bullet timer
  }
  
  
  if (bullet_timer > 0) {
    bullet_timer -= 1;  // Decrease the timer each frame
}