
//if (mouse_check_button_pressed(mb_left)) {
//    // Define the new waypoint coordinates
//    var waypoint_x = mouse_x;
//    var waypoint_y = mouse_y;

//    // Check if Shift is not held
//    if (!keyboard_check(vk_shift)) {
//        // Clear existing waypoints if Shift is not held
//        with (obj_player1) {
//            if (is_selected) {
//                waypoints = []; // Reset the waypoint array
//            }
//        }

//        // Destroy all existing waypoint instances
//        with (obj_waypoint) {
//            instance_destroy();
//        }
//    }

//    // Add the new waypoint to the selected player's waypoint array
//    with (obj_player1) {
//        if (is_selected) {
//            array_push(waypoints, [waypoint_x, waypoint_y]);
//            instance_create_layer(waypoint_x, waypoint_y, "Instances", obj_waypoint);
//        }
//    }
//}

if (mouse_check_button_pressed(mb_left)){
	var waypoint_x = mouse_x;
	var waypoint_y = mouse_y;
	
	//with (obj_player1) {
    //    is_selected = false;
    //}
    //with (obj_player2){
    //    is_selected = false;
    //}
    //with (obj_player3){
    //    is_selected = false;
    //}

	var clicked_player = noone;
	with (obj_player1){
		if (point_in_rectangle(mouse_x,mouse_y,x-sprite_width/2,y - sprite_height/2, x+sprite_width/2,y + sprite_height/2)){
			is_selected = true;
			clicked_player = id;
		}
	}
	with (obj_player2){
		if (point_in_rectangle(mouse_x,mouse_y,x-sprite_width/2,y - sprite_height/2, x+sprite_width/2,y + sprite_height/2)){
			is_selected = true;
			clicked_player = id;
		}
	}
	with (obj_player3){
		if (point_in_rectangle(mouse_x,mouse_y,x-sprite_width/2,y - sprite_height/2, x+sprite_width/2,y + sprite_height/2)){
			is_selected = true;
			clicked_player = id;
		}
	}
if (clicked_player ==noone){
	if (!keyboard_check(vk_shift)){
		with (obj_player1){
			if (is_selected){
				waypoints1=[];
			}
		}
		
		with (obj_player2){
			if (is_selected){
				waypoints2=[];
			}
		}
		with(obj_player3){
			if (is_selected){
				waypoints3=[];
			}
		}
		
		with (obj_waypoint){
			instance_destroy();
		}
	}
		
		with (obj_player1) {
       if (is_selected) {
            array_push(waypoints1,[waypoint_x, waypoint_y]);
            instance_create_layer(waypoint_x, waypoint_y, "Instances", obj_waypoint);
        }
	 }
	 
	 with (obj_player2){
       if (is_selected) {
            array_push(waypoints2,[waypoint_x, waypoint_y]);
            instance_create_layer(waypoint_x, waypoint_y, "Instances", obj_waypoint);
        }
	 }
	 with (obj_player3) {
       if (is_selected) {
            array_push(waypoints3,[waypoint_x, waypoint_y]);
            instance_create_layer(waypoint_x, waypoint_y, "Instances", obj_waypoint);
        }
	 }
}
	
}
	



	 
	 
	

