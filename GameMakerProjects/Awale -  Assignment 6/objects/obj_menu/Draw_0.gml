
//switch(menu_state){
//		case "main menu":
//		draw_text(100, 100, "Main Menu:");
//		for (var i = 0; i<array_length(main_options); i++){
				
//				draw_text(100, 120 + i * 20, main_options[i])
//		}
//		break;
//		case "target select":
//		draw_text(100,100, "Select Your Target:")
//		for (var i = 0; i<array_length(global.enemies_list); i++){
			
//			draw_text(100, 120 + i * 20, global.enemies_list[i])
//		}
//		break;
//		case "item Select":
//		draw_text(100,100, "Select your Item:")
//		for (var i = 0; i<array_length(global.enemies_list); i++){
			
//			draw_text(100, 120 + i * 20, global.enemies_list[i])
//		}
//	break;
//}

switch (menu_state) {
    case "main menu":
        // Draw Main Menu Title
        draw_text(100, 100, "Main Menu:");
        
        // Loop through main menu options and display them
        for (var i = 0; i < array_length(main_options); i++) {
            // Draw the pointer (>) next to the selected option
            if (i == selected) draw_text(80, 120 + i * 20, ">");

            // Draw the menu option text
            draw_text(100, 120 + i * 20, main_options[i]);
        }
        break;

    case "target select":
        // Draw Target Selection Title
        draw_text(100, 100, "Select Your Target:");
        
        // Loop through target menu options and display them
        for (var i = 0; i < array_length(global.enemies_list); i++) {
            // Draw the pointer (>) next to the selected option
            if (i == selected) draw_text(80, 120 + i * 20, ">");

            // Draw the target option text
            draw_text(100, 120 + i * 20, global.enemies_list[i]);
        }
        break;

    case "item select":
        // Draw Item Selection Title
        draw_text(100, 100, "Select Your Item:");
        
        // Loop through item menu options and display them
        for (var i = 0; i < array_length(item_options); i++) {
			
            // Draw the pointer (>) next to the selected option
				draw_text(80, 120 + i * 20, ">");
				

            // Draw the item option text
            draw_text(100, 120 + i * 20, item_options[i]);
        }
        break;

    default:
        // Default message in case the menu_state is uninitialized
        draw_text(100, 100, "No Menu Active");
        break;
}


