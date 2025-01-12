grid_size = 7; // 7x7 grid
global.size_cell = 100; // global variable for size of each cell
global.player_moved = false; //flag to track player movement
global.numEnemies = 3;


grid = array_create(grid_size);      // for loop to build grid
for (var i= 0; i < grid_size; i++){
	grid[i] = array_create(grid_size , 0);
}

for (var i = 0; i < grid_size; i++){  // visually building grid
	for (var j = 0; j < grid_size; j++){
		instance_create_layer(i*100,j*100, "Tiles", tiles);
	}
}

var grid_x = irandom(grid_size - 1); // picking a random swuare on grid
var grid_y = irandom(grid_size - 1);


x = grid_x * 100;  
y = grid_y * 100;  

var player_instance = instance_create_layer(x,y,"Instances",obj_player) //create player instance, assume one player

grid[grid_x, grid_y] = player_instance; // set randomly generated grid position to player instance

 global.enemies = [] // putting all my enenmies in an array
 var num_enemies = 3; // number of enemies
 
for (var i = 0; i < num_enemies; i++){
	//spawn enemy in random positions
	var ex= irandom(grid_size -1);
	var ey = irandom(grid_size-1);
	
	while (grid[ex,ey] !=0){       // make sure position in grid is empty
		ex =irandom(grid_size -1);
		ey =irandom(grid_size -1);
	}
	var enemy_type= choose("cardinal", "diagonal", "double_cardinal");
	var enemy = instance_create_layer(ex*00, ey*100, "Instances", obj_enemy);
	// setting the values of each index
	global.enemies[i] = {
        instance: enemy,   
        x: ex,             
        y: ey,             
        enemy_health: 50,        
        enemy_attack: 10,         
        type: enemy_type,  
		is_attacked: false 
	}
	// updating value on the grid
	grid[ex,ey] = enemy;
	
	
}



function move_enemy(enemy) {
    // get the enemy current grid position
    var ex = enemy.x / global.size_cell; 
    var ey = enemy.y / global.size_cell;

    //determine the enemy movement type 
    var move_type = enemy.type;

    //find player instance to determine position
    var player = instance_find(obj_player, 0); // Get the player's position
    if (player != noone) {
        var player_x = player.x / global.size_cell;
        var player_y = player.y / global.size_cell;

        //check if player is close enough for the enemy to attack
        if (abs(player_x - ex) <= 1 && abs(player_y - ey) <= 1) {
            enemy.is_attacked = true; // Flag the enemy to attack if the player is within range
        }
    }

    // If the enemy is flagged to attack, make it move toward player
    if (enemy.is_attacked) {
        if (player != noone) {
            var player_x = player.x / global.size_cell;
            var player_y = player.y / global.size_cell;

            
            if (player_x > ex && ex + 1 < grid_size && grid[ex + 1, ey] == 0) {
                enemy.x = (ex + 1) / global.size_cell; //move right
            }
            else if (player_x < ex && ex - 1 >= 0 && grid[ex - 1, ey] == 0) {
                enemy.x = (ex - 1) / global.size_cell; //move left
            }
            else if (player_y > ey && ey + 1 < grid_size && grid[ex, ey + 1] == 0) {
                enemy.y = (ey + 1) / global.size_cell; // move down
            }
            else if (player_y < ey && ey - 1 >= 0 && grid[ex, ey - 1] == 0) {
                enemy.y = (ey - 1) / global.size_cell; // move up
            }

            // Reset the attack flag after moving toward the player
            enemy.is_attacked = false;
        }
    } else {
        // If the enemy is not attacking, move randomly based on its type
        switch (move_type) {
            case "cardinal": {
                // Move in one of four cardinal directions (up, down, left, right)
                var cardinal_direction = irandom(3);
                switch (cardinal_direction) {
                    case 0: if (ey - 1 >= 0 && grid[ex, ey - 1] == 0) enemy.y = (ey - 1) * global.size_cell; break; // Up
                    case 1: if (ey + 1 < grid_size && grid[ex, ey + 1] == 0) enemy.y = (ey + 1) * global.size_cell; break; // Down
                    case 2: if (ex - 1 >= 0 && grid[ex - 1, ey] == 0) enemy.x = (ex - 1) * global.size_cell; break; // Left
                    case 3: if (ex + 1 < grid_size && grid[ex + 1, ey] == 0) enemy.x = (ex + 1) * global.size_cell; break; // Right
                }
            } break;

            case "diagonal": {
                // Move in one of four diagonal directions (top-left, top-right, bottom-left, bottom-right)
                var diagonal_direction = irandom(3);
                switch (diagonal_direction) {
                    case 0: if (ex - 1 >= 0 && ey - 1 >= 0 && grid[ex - 1, ey - 1] == 0) { 
                        enemy.x = (ex - 1) * global.size_cell; 
                        enemy.y = (ey - 1) * global.size_cell; 
                    } break; //top-left
                    case 1: if (ex + 1 < grid_size && ey - 1 >= 0 && grid[ex + 1, ey - 1] == 0) { 
                        enemy.x = (ex + 1) * global.size_cell; 
                        enemy.y = (ey - 1) * global.size_cell; 
                    } break; //top-right
                    case 2: if (ex - 1 >= 0 && ey + 1 < grid_size && grid[ex - 1, ey + 1] == 0) { 
                        enemy.x = (ex - 1) * global.size_cell; 
                        enemy.y = (ey + 1) * global.size_cell; 
                    } break; //bottom-left
                    case 3: if (ex + 1 < grid_size && ey + 1 < grid_size && grid[ex + 1, ey + 1] == 0) { 
                        enemy.x = (ex + 1) * global.size_cell; 
                        enemy.y = (ey + 1) * global.size_cell; 
                    } break; //bottom-right
                }
            } break;

            case "double_cardinal": {
               
    // Start with the current position
    var current_x = ex;
    var current_y = ey;

    // Determine the first direction
    var first_direction = irandom(3);
    switch (first_direction) {
        case 0: 
            if (current_y - 1 >= 0 && grid[current_x, current_y - 1] == 0) { 
                current_y -= 1; //move up
            }
            break;
        case 1: 
            if (current_y + 1 < grid_size && grid[current_x, current_y + 1] == 0) { 
                current_y += 1; // move down
            }
            break;
        case 2: 
            if (current_x - 1 >= 0 && grid[current_x - 1, current_y] == 0) { 
                current_x -= 1; // move left
            }
            break;
        case 3: 
            if (current_x + 1 < grid_size && grid[current_x + 1, current_y] == 0) { 
                current_x += 1; // move right
            }
            break;
    }

    // Determine the second direction
    var second_direction = irandom(3);
    switch (second_direction) {
        case 0: 
            if (current_y - 1 >= 0 && grid[current_x, current_y - 1] == 0) { 
                current_y -= 1; // move up
            }
            break;
        case 1: 
            if (current_y + 1 < grid_size && grid[current_x, current_y + 1] == 0) { 
                current_y += 1; // move down
            }
            break;
        case 2: 
            if (current_x - 1 >= 0 && grid[current_x - 1, current_y] == 0) { 
                current_x -= 1; // move left
            }
            break;
        case 3: 
            if (current_x + 1 < grid_size && grid[current_x + 1, current_y] == 0) { 
                current_x += 1; // move right
            }
            break;
    }

    // Update the enemy's position after both moves
    enemy.x = current_x * global.size_cell;
    enemy.y = current_y * global.size_cell;
}

            break;
        }
    }

    // If the enemy's position has changed, update the grid
    if (ex != enemy.x / global.size_cell || ey != enemy.y / global.size_cell) { 
        grid[ex, ey] = 0; // Clear the old position
        grid[enemy.x / global.size_cell, enemy.y / global.size_cell] = enemy.instance; // Set new position in the grid
        enemy.instance.x = enemy.x;  // Update instance position visually
        enemy.instance.y = enemy.y;
    }
}

