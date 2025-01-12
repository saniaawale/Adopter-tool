
// navigation 
if (keyboard_check_pressed(vk_up)){
	selected = max(0, selected -1);
}

if (keyboard_check_pressed(vk_down)){
	
	switch (menu_state) {
	case "main menu":  // Main menu implementation
	menu_length = array_length(main_options);
	break;
	case "target menu": // Target menu implemetation
	menu_length = array_length(global.enemies_list);
	break;
	case "item menu":  // Item menu implementation
	menu_length = array_length(item_options)
	break;
	}
	selected = min(menu_length -1, selected +1);
}
//selection
if (keyboard_check_pressed(vk_space)){
	switch (menu_state){
		case "main menu" :
			switch (selected){
				case 0:
					menu_state = "target select"
				break;
				case 1:
					menu_state = "target select"
				break;
				case 2:
					menu_state = "item select"
				break;
			}
			break;
		case "target select":
			if (keyboard_check_pressed(vk_up)) {
            selected = max(0, selected - 1);  // Move pointer up
        }
        if (keyboard_check_pressed(vk_down)) {
            selected = min(array_length(global.enemies_list) - 1, selected + 1);  // Move pointer down
        }

        if (keyboard_check_pressed(vk_space)) {
            target_menu_state = selected;  // Store the selected target
            menu_state = "main menu";  // Return to the main menu after selecting a target
            selected = 0;  // Reset pointer to the first option
        }
        break;
			
		case "item select" :
		selected = 1;
			

        if (keyboard_check_pressed(vk_space)) {
            // Process item selection and use item effects
           item_menu_state = selected;  // Store selected item
           selected = 0;

            // After using item, return to the main menu
            menu_state = "main menu";  // Go back to main menu after using item
            selected = 0;  // Reset pointer to the first option
        }
        break;
			}
		}

