if (obj_player.is_turn && obj_player.is_alive){
if (keyboard_check_pressed(vk_up)) {
    selected = max(0, selected - 1);  //move pointer up
}

if (keyboard_check_pressed(vk_down)) {
    var menu_length;

    //find length of the current menu based on menu_state
    switch (menu_state) {
        case "main menu":
            menu_length = array_length(main_options);
            break;
        case "target select":
            menu_length = array_length(global.enemies_list);
            break;
        case "item select":
            menu_length = array_length(item_options);
            break;
    }
    selected = min(menu_length - 1, selected + 1);  // move pointer down
}

// selection
if (keyboard_check_pressed(vk_space)) {
    switch (menu_state) {
        case "main menu":
            // Handle the main menu options
            switch (selected) {
                case 0:  // Attack
                        menu_state = "target select";  // switch to target selection
                        obj_player.action = "Attack";  // setting action
                        selected = 0;  // reset selection
                        break;

                    case 1:  // Magic
                        menu_state = "target select";  // switch to target selection
                        obj_player.action = "Magic";  // seting action
                        selected = 0;  //reset selection
                        break;

                    case 2:  // Item
                        menu_state = "item select";  //move to item selection
                        obj_player.action = "Item";  // set action
                        selected = 0;  // reset selection
                        break;
            }
            selected = 0;  //reset selection for  next menu
            break;

        case "target select":
            if (keyboard_check_pressed(vk_up)) {
                selected -= 1;  // Move pointer up
                if (selected < 0) {
                    selected = array_length(global.enemies_list) - 1;  // Wrap around to the last target
                }
            }
            if (keyboard_check_pressed(vk_down)) {
                selected += 1;  // Move pointer down
                if (selected >= array_length(global.enemies_list)) {
                    selected = 0;  // wraps around to first target 
                }
            }
            if (keyboard_check_pressed(vk_space)) {
				
                 var target = global.enemies_list[obj_menu.selected];  // Assign the selected target
                
                if (obj_player.action == "Attack") {
                    shoot_enemy(target);  // Execute attack action
					
                } else if (obj_player.action == "Magic") {
                    shoot_enemy(target);  // Execute magic action
					
                } 

                menu_state = "main menu";  // Return to main menu
                selected = 0;  // Reset selection
                obj_player.is_turn = false;  // End the player's turn
            }
            break;
			
        case "item select":
            // Handle item selection
            if (selected == 0) {
                // Example: Heal the player
                obj_player.hp = min(obj_player.max_hp, obj_player.hp + 20);
                show_message("You used an HP+ item and restored 20 HP!");
            }
            menu_state = "main menu";  // Return to the main menu
            selected = 0;  // Reset selection
            break;
    }
}
}
