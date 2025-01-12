if (is_alive && is_turn) {
    switch (obj_menu.menu_state) {
        case "main menu":
            // Navigate the main menu
            if (keyboard_check_pressed(vk_up)) {
                obj_menu.selected = max(0, obj_menu.selected - 1);  // Move pointer up
            }
            if (keyboard_check_pressed(vk_down)) {
                obj_menu.selected = min(array_length(obj_menu.main_options) - 1, obj_menu.selected + 1);  // Move pointer down
            }
            if (keyboard_check_pressed(vk_space)) {
                switch (obj_menu.selected) {
                    case 0:  // Attack
                        obj_menu.menu_state = "target select";
                        action = "attack";
                        obj_menu.selected = 0;
                        break;

                    case 1:  // Magic
                        obj_menu.menu_state = "target select";
                        action = "magic";
                        obj_menu.selected = 0;
                        break;

                    case 2:  // Item
                        obj_menu.menu_state = "item select";
						action = "Item"
                        obj_menu.selected = 0;
                        break;
                }
            }
            break;

        case "target select":
            // Navigate the target selection menu
            if (keyboard_check_pressed(vk_up)) {
                obj_menu.selected = max(0, obj_menu.selected - 1);  // Move pointer up
            }
            if (keyboard_check_pressed(vk_down)) {
                obj_menu.selected = min(array_length(global.enemies_list) - 1, obj_menu.selected + 1);  // Move pointer down
            }
            if (keyboard_check_pressed(vk_space)) {
                target = global.enemies_list[obj_menu.selected];  // Assign the selected target
                perform_action();  // Execute the chosen action                                      /////!!!!!!!!!!!
                
                obj_menu.menu_state = "main menu";  // Return to main menu
                obj_menu.selected = 0;  // Reset selection
                is_turn = false;  // End the player's turn
            }
            break;

        case "item select":
            // Navigate the item selection menu
            if (keyboard_check_pressed(vk_up)) {
                obj_menu.selected = max(0, obj_menu.selected - 1);  // Move pointer up
            }
            if (keyboard_check_pressed(vk_down)) {
                obj_menu.selected = min(array_length(obj_menu.item_options) - 1, obj_menu.selected + 1);  // Move pointer down
            }
            if (keyboard_check_pressed(vk_space)) {
                if (obj_menu.selected == 0) {
                    hp = min(max_hp, hp + 20);  // Heal the player
                    show_message("You used an HP+ item and restored 20 HP!");
                }
                obj_menu.menu_state = "main menu";  // Return to main menu
                obj_menu.selected = 0;  // Reset selection
                is_turn = false;  // End the player's turn
            }
            break;
    }
}
