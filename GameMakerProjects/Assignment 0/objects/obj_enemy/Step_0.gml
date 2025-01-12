
x+=enemy_speed; //moving in the x direction

if (x <= 0 || x >= room_width - sprite_width) 
{
   enemy_speed = -enemy_speed;
    y += sprite_height;
	
}