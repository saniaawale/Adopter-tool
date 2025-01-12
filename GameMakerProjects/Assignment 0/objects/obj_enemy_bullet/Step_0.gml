y += speed; // moving in the negative y direction
if ( y > room_height){
	instance_destroy(); // bullet destroyed when it moves off screen
}